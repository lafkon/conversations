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


# IMGNFO=$TMPDIR/imginformation.txt
# if [ -f $IMGNFO ]; then rm $IMGNFO ; touch $IMGNFO ; fi
# IMGCNT=0
#
# KEYWORDLIST=i/var/keywords_140523.list


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

# RESET FONT
  writeTeXsrc "\normalsize"
  writeTeXsrc "\resetfont"
# INDEX AND BIBLIOGRAPHY
  writeTeXsrc "\emptypage"
  writeTeXsrc "\cleardoublepage"
# writeTeXsrc "\pagenumbering{gobble}"
  writeTeXsrc "\pagestyle{empty}"
  writeTeXsrc "\titlespacing{\chapter}"
  writeTeXsrc "{0pc}{0mm}{3em}[0pc]"
  writeTeXsrc "\printindex"

  writeTeXsrc "\pagestyle{fancy}"
  writeTeXsrc "\addcontentsline{toc}{chapter}{Read this!}"
  writeTeXsrc "\bibliographystyle{plain}"
# writeTeXsrc "\bibliographystyle{unsrtnat}"
  writeTeXsrc "\bibliography{$TMPDIR/ref}"
# writeTeXsrc "\emptypage\emptypage"

# INCLUDE COLLECTED INDEX INFO
# cat $IMGNFO  >> $TMPTEX

  writeTeXsrc "\end{document}"

# GENERATE INDEX REFERENCE ACCORDING TO LIST
# for KEYWORD in `cat $KEYWORDLIST | sed 's/ /jfh7Gd54Dcw/g'`
#  do
#     KEYWORD=`echo $KEYWORD | sed 's/jfh7Gd54Dcw/ /g'`
#     sed -i "s/ $KEYWORD /&\\\index{$KEYWORD} /g" $TMPTEX
# done

  sed -i "s/$EMPTYLINE/ /g" $TMPTEX

  sleep 5

# --------------------------------------------------------------------------- #
# GET REFERENCE FILE 
# --------------------------------------------------------------------------- #
# BIBURL=https://gist.githubusercontent.com/christop/d749b25a67e5aa990a64/raw/2f8d757908c96fbf3377e458a2f6a72d6a0b0d05/references.bib
  BIBURL=http://note.pad.constantvzw.org:8000/p/references.bib/export/txt
  wget --no-check-certificate -O ${TMPDIR}/ref.bib $BIBURL > /dev/null 2>&1
  sleep 5

# --------------------------------------------------------------------------- #
# GENERATE PDF
# --------------------------------------------------------------------------- #

# pdflatex -interaction=nonstopmode \
#          -output-directory $OUTDIR \
#           $TMPTEX  # > /dev/null
  pdflatex -output-directory $OUTDIR \
            $TMPTEX

# if [ -f ${TMPTEX%%.*}.ind ]; then bibtex ${TMPTEX%%.*} ; fi
  bibtex ${TMPTEX%%.*}
# sed -i '/].$/s/newblock/newline/g' ${TMPTEX%%.*}.bbl
  sed -i 's/newblock/newline/g' ${TMPTEX%%.*}.bbl

  makeindex ${TMPTEX%%.*}.idx
  pdflatex -output-directory $OUTDIR $TMPTEX 

## --------------------------------------------------------------------------- #
## REMOVE DUPLICATE PAGE/GRAFIK REFERENCES (BASED ON NEWLABEL IN AUX)
## --------------------------------------------------------------------------- #
#  for REFERENCE in `cat ${TMPTEX%%.*}.aux | \
#                    grep "\\\\newlabel" | \
#                    sed '/\\\\newlabel/s/:[0-9]*}/:Xhdu732cC}/' | \
#                    sort | uniq | \
#                    sed 's/Xhdu732cC/\[0-9\]\*/' | \
#                    sed 's/ /Cjdsu63eTd7/g'`
#   do
#      REFERENCE=`echo $REFERENCE | sed 's/Cjdsu63eTd7/ /g'`
#      for ID in `grep $REFERENCE ${TMPTEX%%.*}.aux | \
#                 cut -d"{" -f 2 | cut -d "}" -f 1 | \
#                 sed '$d'`
#       do
#          sed -i "s/\\\\pageref{$ID},//g" $TMPTEX
#      done
#  done
#  sed -i 's/^,//g'  $TMPTEX
## --------------------------------------------------------------------------- #
   pdflatex -output-directory $OUTDIR $TMPTEX 


# DEBUG
# cp ${TMPTEX%%.*}.aux debug.aux
  cp $TMPTEX debug.tex


# --------------------------------------------------------------------------- #
# CLEAN UP
# --------------------------------------------------------------------------- #
  cp ${TMPTEX%.*}.pdf latest.pdf
# mv ${TMPTEX%.*}.pdf $PDFDIR/`date +%s`.pdf
  rm ${TMPTEX%.*}.* $TEXBODY $FUNCTIONS tmp-*.mdx
# rm $TEXBODY $FUNCTIONS

# if [ `find $TMPDIR -name "*.*" | grep -v .gitignore | wc -l` -gt 0 ] 
# then
# rm $TMPDIR/*.*
# fi


exit 0;


