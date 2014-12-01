#!/bin/bash

# --------------------------------------------------------------------------- #
#                                                                             #
#  Copyright (C) 2014 LAFKON/Christoph Haag                                   #
#                                                                             #
#  svglayers2pdfpages.sh is free software: you can redistribute it            # 
#  and/or modify it under the terms of the GNU General Public License as      # 
#  published by the Free Software Foundation, either version 3,               #
#  or (at your option) any later version.                                     #
#                                                                             #
#  svglayers2pdfpages.sh is distributed in the hope that it will be useful,   #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of             #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                       #
#  See the GNU General Public License for more details.                       #
#                                                                             #
# --------------------------------------------------------------------------- #

  SVG=$1
  OUTDIR=___

# --------------------------------------------------------------------------- #
# INTERACTIVE CHECKS 
# --------------------------------------------------------------------------- #
  if [ ! -f ${SVG%%.*}.svg ]; then echo; echo "We need a svg!"
                                         echo "e.g. $0 yoursvg.svg"; echo
      exit 0;
  fi

# --------------------------------------------------------------------------- #
# MOVE ALL LAYERS ON SEPARATE LINES 
# --------------------------------------------------------------------------- #
  sed ':a;N;$!ba;s/\n/ /g' $SVG          | # REMOVE ALL LINEBREAKS
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

  for LAYER in `grep "groupmode=\"layer\"" ${SVG%%.*}.tmp | \
                grep -v "label=\"XX_" | \
                sed 's/ /df73SAc/g'`
   do

      LAYER=`echo $LAYER | sed 's/df73SAc/ /g'`
      LNAME=`echo $LAYER | sed 's/label/\nlabel/g' | \
             grep "^label" | cut -d "\"" -f 2 | sed 's/ /_/g'`
      PDF=$OUTDIR/${LNAME}.pdf

      if [ ! -f $PDF ]; then

       echo $SVGHEADER >  layer2svg_${LNAME}.svg
       echo $LAYER     >> layer2svg_${LNAME}.svg
       echo "</svg>"   >> layer2svg_${LNAME}.svg

       inkscape --export-pdf=$PDF \
                --export-text-to-path \
                layer2svg_${LNAME}.svg


       gs                                     \
         -o ${PDF%%.*}_CONFORMED.pdf          \
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
         -f $PDF

       mv ${PDF%%.*}_CONFORMED.pdf $PDF



       rm layer2svg_${LNAME}.svg

      else

       echo "$PDF EXISTS!"

      fi

  done

# --------------------------------------------------------------------------- #
# CLEAN UP 
# --------------------------------------------------------------------------- #
  rm ${SVG%%.*}.tmp



exit 0; 



