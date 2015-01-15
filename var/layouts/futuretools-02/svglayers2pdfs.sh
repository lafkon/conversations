#!/bin/bash

# --------------------------------------------------------------------------- #
#                                                                             #
#  Copyright (C) 2014 LAFKON/Christoph Haag                                   #
#                                                                             #
#  svglayers2pdfs.sh is free software: you can redistribute it                # 
#  and/or modify it under the terms of the GNU General Public License as      # 
#  published by the Free Software Foundation, either version 3,               #
#  or (at your option) any later version.                                     #
#                                                                             #
#  svglayers2pdfs.sh is distributed in the hope that it                       #
#  will be useful, but WITHOUT ANY WARRANTY; without even the implied         #
#  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           #
#  See the GNU General Public License for more details.                       #
#                                                                             #
# --------------------------------------------------------------------------- #

  SVG=$1
  PDF=${SVG%%.*}.pdf
  BASE=${SVG%%.*}

# --------------------------------------------------------------------------- #
# INTERACTIVE CHECKS 
# --------------------------------------------------------------------------- #
  if [ ! -f ${SVG%%.*}.svg ]; then echo; echo "We need a svg!"
                                         echo "e.g. $0 yoursvg.svg"; echo
      exit 0;
  fi
  if [ `ls ${BASE}*.pdf 2> /dev/null | wc -l` -gt 0 ]; then
       echo "output for $SVG does exist"
       read -p "overwrite ${BASE}_XX? [y/n] " ANSWER
       if [ X$ANSWER != Xy ] ; then echo "Bye"; exit 0; fi
  fi


  BREAKFOO=NL${RANDOM}F00
  SPACEFOO=SP${RANDOM}F0O
# --------------------------------------------------------------------------- #
# MOVE ALL LAYERS ON SEPARATE LINES (TEMPORARILY; EASIFY PARSING LATER ON)
# --------------------------------------------------------------------------- #
  sed ":a;N;\$!ba;s/\n/$BREAKFOO/g" $SVG | # REMOVE ALL LINEBREAKS (BUT SAVE)
  sed "s/ /$SPACEFOO/g"                  | # REMOVE ALL SPACE (BUT SAVE)
  sed 's/<g/4Fgt7RfjIoPg7/g'             | # PLACEHOLDER FOR GROUP OPEN
  sed ':a;N;$!ba;s/\n/ /g'               | # REMOVE ALL NEW LINES
  sed 's/4Fgt7RfjIoPg7/\n<g/g'           | # RESTORE GROUP OPEN + NEWLINE
  sed '/groupmode="layer"/s/<g/4Fgt7R/g' | # PLACEHOLDER FOR LAYERGROUP OPEN
  sed ':a;N;$!ba;s/\n/ /g'               | # REMOVE ALL LINEBREAKS
  sed 's/4Fgt7R/\n<g/g'                  | # RESTORE LAYERGROUP OPEN + NEWLINE
  sed 's/<\/svg>//g'                     | # REMOVE SVG CLOSE
  sed 's/display:none/display:inline/g'  | # MAKE VISIBLE EVEN WHEN HIDDEN
  tee > ${SVG%%.*}.tmp                     # WRITE TO TEMPORARY FILE


# --------------------------------------------------------------------------- #
# EXTRACT HEADER
# --------------------------------------------------------------------------- #
  SVGHEADER=`head -n 1 ${SVG%%.*}.tmp`

# --------------------------------------------------------------------------- #
# WRITE LAYERS TO SEPARATE FILES AND TRANSFORM TO PDF 
# --------------------------------------------------------------------------- #

  COUNT=1
  for LAYER in `grep "groupmode=\"layer\"" ${SVG%%.*}.tmp | \
                grep -v "label=\"XX_" | \
                sed 's/ /df73SAc/g'`
   do
   
          NUM=`echo 0000$COUNT | rev | cut -c 1-4 | rev`
    
          LAYER=`echo $LAYER | sed 's/df73SAc/ /g'`
          LNAME=`echo $LAYER | sed 's/inkscape:label/\nTHIS/g'    | \
                 grep "^THIS" | head -n 1 | sed "s/$SPACEFOO/_/g" | \
                 cut -d "\"" -f 2 | sed 's/ /_/g'`
          OUT=${BASE}_${NUM}_${LNAME}
          echo "writing ${OUT}.pdf"
    
          echo $SVGHEADER        | # THE HEADER
          sed "s/$BREAKFOO/\n/g" | # RESTORE ORIGINAL LINEBREAKS
          sed "s/$SPACEFOO/ /g"  | # RESTORE ORIGINAL SPACES
          tee                    >   ${OUT}.svg
    
          echo $LAYER            | # THE LAYER
          sed "s/$BREAKFOO/\n/g" | # RESTORE ORIGINAL LINEBREAKS
          sed "s/$SPACEFOO/ /g"  | # RESTORE ORIGINAL SPACES
          tee                    >>  ${OUT}.svg
    
          echo "</svg>"          >>  ${OUT}.svg
    
          inkscape --export-pdf=${OUT}.pdf \
    	           --export-text-to-path \
    	           ${OUT}.svg

          gs -o ${OUT}_CONFORMED.pdf              \
             -sDEVICE=pdfwrite                    \
             -sColorConversionStrategy=Gray       \
             -sProcessColorModel=DeviceGray       \
             -sColorImageDownsampleThreshold=2    \
             -sColorImageDownsampleType=Bicubic   \
             -sColorImageResolution=300           \
             -sGrayImageDownsampleThreshold=2     \
             -sGrayImageDownsampleType=Bicubic    \
             -sGrayImageResolution=300            \
             -sMonoImageDownsampleThreshold=2     \
             -sMonoImageDownsampleType=Bicubic    \
             -sMonoImageResolution=1200           \
             -dSubsetFonts=true                   \
             -dEmbedAllFonts=true                 \
             -dAutoRotatePages=/None              \
             -sCannotEmbedFontPolicy=Error        \
             -c ".setpdfwrite<</NeverEmbed[ ]>> setdistillerparams" \
             -f ${OUT}.pdf > /dev/null

          mv ${OUT}_CONFORMED.pdf ${OUT}.pdf

          rm ${OUT}.svg
          COUNT=`expr $COUNT + 1`
  done

# --------------------------------------------------------------------------- #
# MAKE MULTIPAGE PDF
# --------------------------------------------------------------------------- #
# pdftk layer2svg_*.pdf cat output $PDF

# --------------------------------------------------------------------------- #
# CLEAN UP 
# --------------------------------------------------------------------------- #
  rm ${SVG%%.*}.tmp



exit 0; 


