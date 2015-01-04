#!/bin/bash

#  THIS IS A FRAGILE SYSTEM, HANDLE WITH CARE.                                #
# --------------------------------------------------------------------------- #
#                                                                             #
#  Copyright (C) 2014 LAFKON/Christoph Haag                                   #
#                                                                             #
#  mdsh2tex2pdf.sh is free software: you can redistribute it and/or modify    #
#  it under the terms of the GNU General Public License as published by       #
#  the Free Software Foundation, either version 3 of the License, or          #
#  (at your option) any later version.                                        #
#                                                                             #
#  mdsh2tex2pdf.sh is distributed in the hope that it will be useful,         #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of             #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                       #
#  See the GNU General Public License for more details.                       #
#                                                                             #
# --------------------------------------------------------------------------- #

  OUTDIR=.
  PDFDIR=tmp
  TMPDIR=tmp
  KEYWORDLIST=var/keywords.list


  EMPTYLINE="EMPTY-LINE-EMPTY-LINE-EMPTY-LINE-TEMPORARY-NOT"

  FUNCTIONS=collect.functions
  FNCTSBASIC=lib/sh/basic.functions
  FNCTSCOMMON=lib/sh/common.functions
  cat $FNCTSBASIC  >  $FUNCTIONS
  cat $FNCTSCOMMON >> $FUNCTIONS
# APPEND OPTIONAL FUNCTION SET (IF GIVEN)
  if [[ ! -z "$1" ]]; then cat $1 >> $FUNCTIONS ; fi
# --------------------------------------------------------------------------- #
# INCLUDE FUNCTIONS
# --------------------------------------------------------------------------- #
  source $FUNCTIONS



# =========================================================================== #
# --------------------------------------------------------------------------- #
# ACTION HAPPENS HERE!
# --------------------------------------------------------------------------- #

  MAIN=http://pad.constantvzw.org/p/conversations/export/txt
# MAIN=http://pad.constantvzw.org/p/conversations.aether9/export/txt

  TEXBODY=$TMPDIR/collect-$RANDOM.tex
  TMPTEX=$TEXBODY
  if [ -f $TMPTEX ]; then rm $TMPTEX ; fi

  mdsh2TeX $MAIN

# =========================================================================== #



# --------------------------------------------------------------------------- #
# PREPARE LATEX DOCUMENT FOR RENDERING PDF
# --------------------------------------------------------------------------- #

  TEXCOMPLETE=tmptex.tex
  TMPTEX=$TEXCOMPLETE
  if [ -f $TMPTEX ]; then rm $TMPTEX ; fi

# A5
  writeTeXsrc "\documentclass[9pt,cleardoubleempty]{scrbook}"
  writeTeXsrc "\usepackage[utf8]{inputenc}"
  writeTeXsrc "\usepackage{lib/tex/basic}"
  writeTeXsrc "\usepackage{lib/tex/functions}"
  writeTeXsrc "\usepackage{lib/tex/interview}"
# writeTeXsrc "\usepackage{showframe}"

  writeTeXsrc "\begin{document}"

  cat $TEXBODY | sed '/^$/d'    | \
  sed 's/{quote}/{quotation}/g' | \
  sed '$!N; /^\(.*\)\n\1$/!P; D' >> $TMPTEX

  writeTeXsrc "$EMPTYLINE";
  writeTeXsrc "$EMPTYLINE";
  writeTeXsrc "$EMPTYLINE";

# RESET 
  writeTeXsrc "\clearpage"
  writeTeXsrc "\normalsize"
  writeTeXsrc "\resetfont"

# KEYWORDS,BIBLIOGRAPHY,LICENSE,COLOPHON,THE REST
  writeTeXsrc "\clearpage"
# writeTeXsrc "\pagenumbering{gobble}"
  writeTeXsrc "\cleartoleftpage"
  writeTeXsrc "\cleardoublepage"
  writeTeXsrc "\renewcommand{\indexname}{}"
  writeTeXsrc "\addtolength{\topmargin}{-10pt}"
  writeTeXsrc "\invisiblechapter{Keywords}"
  writeTeXsrc "\printindex"

  writeTeXsrc "\bibliographystyle{plain}"
  writeTeXsrc "\nobibliography{$TMPDIR/ref}"

  writeTeXsrc "\cleardoublepage"
  writeTeXsrc "\input{lib/tex/free_art_license.sty}"
  writeTeXsrc "\includepagesplus{var/license/fal_1-3.pdf}{1}{.85}"
  writeTeXsrc "{offset=10 0,pagecommand={\index{Free Art License}}}{trim=0 0 0 0}{Free Art License}"

  writeTeXsrc "\cleartofour"

  writeTeXsrc "\end{document}"



# --------------------------------------------------------------------------- #
# GENERATE INDEX REFERENCE ACCORDING TO LIST
# --------------------------------------------------------------------------- #
  KEYWORDURL=http://pad.constantvzw.org/p/conversations.keywords/export/txt
  wget --no-check-certificate -O ${TMPDIR}/k.list $KEYWORDURL > /dev/null 2>&1

# SAVE SOME FORMATTING
  NL=NL$RANDOM
  sed -i "s/^\\\\/$NL\\\\/g"                 $TMPTEX
  sed -i ':a;N;$!ba;s/\n/ /g'                $TMPTEX
  sed -i "s/${EMPTYLINE}/\n${EMPTYLINE}\n/g" $TMPTEX
  sed -i "s/$NL/\n/g"                        $TMPTEX
  S=XYX${RANDOM}SP ; UN=YXY${RANDOM}UN # RANDOM PLACEHOLDER FOR SPACE AND EVERYTHING

  for INDEXTHIS in `cat ${TMPDIR}/k.list          | # DISPLAY LIST
                    grep -v "^#"                  | # IGNORE SOMETHING
                    awk 'BEGIN { FS = "|" } ; \
                    { print length($1) ":" $0; }' | # ADD LENGTH OF FIELD 1
                    sort -n                       | # NUMERIC SORT
                    cut -d ":" -f 2-              | # REMOVE LENGTH AGAIN
                    tac                           | # BACKUP SPACES
                    sed 's= =jfh7Gd54Dcw=g'`
   do
      MAINKEYWORD=`echo $INDEXTHIS         | # START
                   sed 's=jfh7Gd54Dcw= =g' | # RESTORE SPACE 
                   cut -d "|" -f 1`          # SELECT FIRST FIELD 
      MAINFOO=`echo $MAINKEYWORD  | #
               sed  "s/./&$UN/g"  | # ADD UNID TO EACH LETTER
               sed  "s/ /$S/g"`
      for KEYWORD in `echo $INDEXTHIS                   | # START
                      sed 's/|/\n/g'                    | # PIPE TO NEWLINE
                      awk '{ print length($1) ":" $0; }'| # PRINT LENGTH
                      sort -n | cut -d ":" -f 2- | tac`   # SORT, CLEAN, REVERT
      do
          KEYWORD=`echo $KEYWORD | sed 's=jfh7Gd54Dcw= =g' | sed 's/\./\\\./g'`
          KEYFOO=`echo $KEYWORD     | # START WITH KEYWORD
                  sed  "s/./&$UN/g" | # ADD FOO TO EVERY LETTER
                  sed  "s/ /$S/g"`    # PLACEHOLDER FOR SPACE

        # DISABLE KEYWORD IF PART OF SOMETHING
          sed -ir "s/[a-z]$KEYWORD/&$UN/gI"   $TMPTEX
          sed -ir "s/$KEYWORD[a-z]+/&$UN/gI"   $TMPTEX
        # PLACE INDEX REF
          sed -ir "s=[({]*${KEYWORD}[.,?\!})']*[s]* =&\\\index{$MAINFOO} =gI" \
                  $TMPTEX
        # DISABLE KEYWORD WHEN DONE
          sed -ir "s=${KEYWORD}[.,?\!})']*[s]*=$UN&$UN=gI" \
                  $TMPTEX
      done

  done

# --------------------------------------------------------------------------- #

  sed -i "s/$S/ /g" $TMPTEX                        # RESTORE SPACEFOO
  sed -i "s/$UN//g" $TMPTEX                        # RESTORE UNID
  sed -i "s/[ ]*\\\\cite/\\\\cite/g" $TMPTEX       # NO SPACE BEFORE CITATION
  sed -i "s/[ ]*\\\\foot/\\\\foot/g" $TMPTEX       # NO SPACE BEFORE FOOTNOTE
  sed -i 's/[ ]*\\ldots{}[ ]*/\\ldots{}/g' $TMPTEX # NO SPACE FOR LDOTS 
  sed -i 's/[ ]*\\index{/\\index{/g' $TMPTEX       # NO SPACE FOR KEYWORDS 
  sed -i "s/^[ \t]*//" $TMPTEX                     # NO LEADING BLANKS

  sed -i "s/$EMPTYLINE/ /g" $TMPTEX

# --------------------------------------------------------------------------- #


# --------------------------------------------------------------------------- #
# GET REFERENCE FILE 
# --------------------------------------------------------------------------- #
  BIBURL=http://note.pad.constantvzw.org:8000/p/references.bib/export/txt
  wget --no-check-certificate -O ${TMPDIR}/ref.bib $BIBURL > /dev/null 2>&1

# --------------------------------------------------------------------------- #
# GENERATE PDF (multiple cycles for index,bibliography)
# --------------------------------------------------------------------------- #

  pdflatex -interaction=nonstopmode \
           -output-directory $OUTDIR \
            $TMPTEX  # > /dev/null

  bibtex ${TMPTEX%%.*}

  # PAGESTYLE FOR INDEX
  # ------------------------------------------------------------------------ #
    echo 'preamble
         "\\begin{theindex}\n\\thispagestyle{empty}\n"
         postamble "\n\n\\end{theindex}\n"' > ${TMPTEX%%.*}.ist
  # ------------------------------------------------------------------------ #
  makeindex -s ${TMPTEX%%.*}.ist ${TMPTEX%%.*}.idx

  pdflatex -interaction=nonstopmode \
           -output-directory $OUTDIR \
            $TMPTEX  # > /dev/null

  # DIFFERENT STYLE FOR SOME THINGS IN TOC
  # ------------------------------------------------------------------------ #
    for SPECIALTOC in "Introduction" \
                      "Colophon"      \
                      "Keywords"       \
                      "Free Art License"
     do
        SPECIALSTYLE="\\\\fontfamily{ocr}\\\\selectfont\\\\footnotesize{" 
        NEWTOC="{$SPECIALSTYLE$SPECIALTOC}}"
        sed -i "s/$SPECIALTOC/$NEWTOC/gI" ${TMPTEX%%.*}.toc
    done

  # ------------------------------------------------------------------------ #

  pdflatex -interaction=nonstopmode \
           -output-directory $OUTDIR \
            $TMPTEX  # > /dev/null

  # DEBUG
  cp $TMPTEX debug.tex


# --------------------------------------------------------------------------- #
# CLEAN UP
# --------------------------------------------------------------------------- #
  cp ${TMPTEX%.*}.pdf latest.pdf
# mv ${TMPTEX%.*}.pdf $PDFDIR/`date +%s`.pdf
  rm ${TMPTEX%.*}.* $TEXBODY $FUNCTIONS tmp-*.mdsh

# if [ `find $TMPDIR -name "*.*" | grep -v .gitignore | wc -l` -gt 0 ] 
# then
# rm $TMPDIR/*.*
# fi


exit 0;

