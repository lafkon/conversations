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
# MAIN=http://pad.constantvzw.org/p/conversations.csolfrank/export/txt

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
  cat $TEXBODY | sed '/^$/d' | \
  sed 's/{quote}/{quotation}/g' | \
  sed '$!N; /^\(.*\)\n\1$/!P; D' >> $TMPTEX

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
  writeTeXsrc "\printindex"

  writeTeXsrc "\bibliographystyle{plain}"
  writeTeXsrc "\nobibliography{$TMPDIR/ref}"

  writeTeXsrc "\cleardoublepage"
  writeTeXsrc "\input{lib/tex/free_art_license.sty}"
  writeTeXsrc "\includepagesplus{var/license/fal_1-3.pdf}{1}{.85}%
               {offset=10 0}{trim=0 0 0 0}{Free Art License}"

  writeTeXsrc "\cleartofour"

  writeTeXsrc "\end{document}"

# --------------------------------------------------------------------------- #
# GENERATE INDEX REFERENCE ACCORDING TO LIST
# --------------------------------------------------------------------------- #
  for INDEXTHIS in `cat $KEYWORDLIST      | \
                    grep -v "^#"          | \
                    sed 's= =jfh7Gd54Dcw=g'`
   do
      MAINKEYWORD=`echo $INDEXTHIS         | \
                   sed 's=jfh7Gd54Dcw= =g' | \
                   cut -d "|" -f 1`
      KEYWORD=$MAINKEYWORD
      for KEYWORD in `echo $INDEXTHIS         | \
                      sed 's=|= =g'`
      do
         KEYWORD=`echo $KEYWORD | sed 's=jfh7Gd54Dcw= =g'`
         sed -i "s= $KEYWORD =&\\\index{$MAINKEYWORD} =gI" $TMPTEX
      done
  done
# --------------------------------------------------------------------------- #

  sed -i "s/$EMPTYLINE/ /g" $TMPTEX



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
    echo 'preamble
         "\\begin{theindex}\n\\thispagestyle{empty}\n"
         postamble "\n\n\\end{theindex}\n"' > ${TMPTEX%%.*}.ist
  makeindex -s ${TMPTEX%%.*}.ist ${TMPTEX%%.*}.idx

  pdflatex -interaction=nonstopmode \
           -output-directory $OUTDIR \
            $TMPTEX  # > /dev/null

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

