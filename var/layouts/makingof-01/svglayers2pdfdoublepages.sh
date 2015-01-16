#!/bin/bash

# --------------------------------------------------------------------------- #
#                                                                             #
#  Copyright (C) 2014 LAFKON/Christoph Haag                                   #
#                                                                             #
#  svglayers2pdfdoublepages.sh is free software: you can redistribute it      # 
#  and/or modify it under the terms of the GNU General Public License as      # 
#  published by the Free Software Foundation, either version 3,               #
#  or (at your option) any later version.                                     #
#                                                                             #
#  svglayers2pdfdoublepages.sh is distributed in the hope that it             #
#  will be useful, but WITHOUT ANY WARRANTY; without even the implied         #
#  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           #
#  See the GNU General Public License for more details.                       #
#                                                                             #
# --------------------------------------------------------------------------- #

  SVG=$1
  PDF=${SVG%%.*}.pdf

# --------------------------------------------------------------------------- #
# INTERACTIVE CHECKS 
# --------------------------------------------------------------------------- #
  if [ ! -f ${SVG%%.*}.svg ]; then echo; echo "We need a svg!"
                                         echo "e.g. $0 yoursvg.svg"; echo
      exit 0;
  fi
  if [ -f $PDF ]; then
       echo "$PDF does exist"
       read -p "overwrite ${PDF}? [y/n] " ANSWER
       if [ X$ANSWER != Xy ] ; then echo "Bye"; exit 0; fi
  fi

  BREAKFOO=`echo N${RANDOM}FO0 | cut -c 1-8`
  SPACEFOO=`echo S${RANDOM}F0O | cut -c 1-8`
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
# SVGHEADER=`head -n 1 ${SVG%%.*}.tmp`

# --------------------------------------------------------------------------- #
# WRITE LAYERS TO SEPARATE FILES AND TRANSFORM TO PDF 
# --------------------------------------------------------------------------- #
  XSHIFT="526.410"
  TRANSFORM="transform=\"translate($XSHIFT,0)\""
 
  COUNT=1
  for LAYERNAME in `sed -n '1!p' ${SVG%%.*}.tmp        | # DISPLAY EVERYTHING EXCEPT FIRST LINE
                    sed 's/inkscape:label="/\nTHIS/g'  | #
                    sed 's/"/\n"/g'                    | #
                    grep ^THIS                         | #
                    sed 's/THIS//g'                    | #
                    grep -v "^XX_"                     | #
                    sort -u`   
   do
      for PAGE in 1 2
      do
          if [ $PAGE -eq 1 ]; then
               SHIFT=$TRANSFORM 
          else
               SHIFT=""
          fi

          NUM=`echo 0000$COUNT | rev | cut -c 1-4 | rev`
          LNAME=`echo $LAYERNAME | #
                 sed 's/ /_/g'`
    
          OUT=layer2svg_${NUM}_${LNAME}

          head -n 1 ${SVG%%.*}.tmp | # THE HEADER
          sed "s/$BREAKFOO/\n/g"   | # RESTORE ORIGINAL LINEBREAKS
          sed "s/$SPACEFOO/ /g"    | # RESTORE ORIGINAL SPACES
          tee                    >   ${OUT}.svg
    
          echo "<g $SHIFT>"      >>  ${OUT}.svg

          grep ":label=\"$LAYERNAME" ${SVG%%.*}.tmp | # THE LAYER
          sed "s/$BREAKFOO/\n/g" | # RESTORE ORIGINAL LINEBREAKS
          sed "s/$SPACEFOO/ /g"  | # RESTORE ORIGINAL SPACES
          tee                    >>  ${OUT}.svg
          echo "</g>"            >>  ${OUT}.svg
    
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
    
          rm layer2svg_${NUM}_${LNAME}.svg
          COUNT=`expr $COUNT + 1`
      done
  done

# --------------------------------------------------------------------------- #
# MAKE MULTIPAGE PDF
# --------------------------------------------------------------------------- #
  pdftk layer2svg_*.pdf cat output $PDF

# --------------------------------------------------------------------------- #
# CLEAN UP 
# --------------------------------------------------------------------------- #
  rm ${SVG%%.*}.tmp  layer2svg_*.pdf

exit 0;


