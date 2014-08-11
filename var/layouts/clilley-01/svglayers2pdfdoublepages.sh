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
       read -p "overwrite ${PDF}? [y/n]" ANSWER
       if [ $ANSWER = n ] ; then echo "Bye"; exit 0; fi
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
  XSHIFT="526.410"
  TRANSFORM="transform=\"translate($XSHIFT,0)\""

  COUNT=1
  for LAYER in `grep "groupmode=\"layer\"" ${SVG%%.*}.tmp | \
                grep -v "label=\"XX_" | \
                sed 's/ /df73SAc/g'`
   do
      for PAGE in 1 2
      do

      if [ $PAGE -eq 1 ]; then

          SHIFT=$TRANSFORM 
      else
          SHIFT=""
      fi

      NUM=`echo 0000$COUNT | rev | cut -c 1-4 | rev`

      LAYER=`echo $LAYER | sed 's/df73SAc/ /g'`
      LNAME=`echo $LAYER | sed 's/label/\nlabel/g' | \
             grep "^label" | cut -d "\"" -f 2 | sed 's/ /_/g'`
      
      echo $SVGHEADER        >  layer2svg_${NUM}_${LNAME}.svg
      echo "<g $SHIFT>"      >> layer2svg_${NUM}_${LNAME}.svg
      echo $LAYER            >> layer2svg_${NUM}_${LNAME}.svg
      echo "</g>"            >> layer2svg_${NUM}_${LNAME}.svg
      echo "</svg>"          >> layer2svg_${NUM}_${LNAME}.svg

      inkscape --export-pdf=layer2svg_${NUM}_${LNAME}.pdf \
	       --export-text-to-path \
	       layer2svg_${NUM}_${LNAME}.svg

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
  rm ${SVG%%.*}.tmp layer2svg_*.pdf



exit 0; 



