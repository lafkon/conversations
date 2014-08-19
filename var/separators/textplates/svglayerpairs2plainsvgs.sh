#!/bin/bash

# --------------------------------------------------------------------------- #
#                                                                             #
#  Copyright (C) 2014 LAFKON/Christoph Haag                                   #
#                                                                             #
#  svglayerpairs2plainsvgs.sh is free software: you can redistribute it            # 
#  and/or modify it under the terms of the GNU General Public License as      # 
#  published by the Free Software Foundation, either version 3,               #
#  or (at your option) any later version.                                     #
#                                                                             #
#  svglayerpairs2plainsvgs.sh is distributed in the hope that it will be useful,   #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of             #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                       #
#  See the GNU General Public License for more details.                       #
#                                                                             #
# --------------------------------------------------------------------------- #

  SVG=$1
  OUTDIR=output

# --------------------------------------------------------------------------- #
# INTERACTIVE CHECKS 
# --------------------------------------------------------------------------- #
  if [ ! -f ${SVG%%.*}.svg ]; then echo; echo "We need a svg!"
                                         echo "e.g. $0 yoursvg.svg"; echo
      exit 0;
  fi

  sed ':a;N;$!ba;s/\n/ /g' $SVG                | # REMOVE ALL NEW LINES
  sed 's/inkscape:label="/\n&/g' | \
  grep inkscape:label | \
  cut -d "\"" -f 2 | \
  grep -v "^X_" | \
  cut -d _ -f 1 | \
  sort | uniq > layertypes.tmp

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

  for LAYERTYPE in `cat layertypes.tmp`
   do
   
       OUTSVG=$OUTDIR/${LAYERTYPE}.svg
       
       echo $SVGHEADER                                   >  tmp.svg
       grep "inkscape:label=\"$LAYERTYPE" ${SVG%%.*}.tmp >> tmp.svg
       echo "</svg>"                                     >> tmp.svg

       inkscape --export-pdf=tmp.pdf \
                --export-text-to-path \
                tmp.svg

       inkscape --export-plain-svg=$OUTSVG \
                tmp.pdf

                
       rm tmp.svg tmp.pdf
                
 done
  
  
# --------------------------------------------------------------------------- #
# CLEAN UP 
# --------------------------------------------------------------------------- #
  rm ${SVG%%.*}.tmp layertypes.tmp

exit 0; 



