#!/bin/bash

# --------------------------------------------------------------------------- #
#                                                                             #
#  Copyright (C) 2014 LAFKON/Christoph Haag                                   #
#                                                                             #
#  XXX is free software: you can redistribute it      # 
#  and/or modify it under the terms of the GNU General Public License as      # 
#  published by the Free Software Foundation, either version 3,               #
#  or (at your option) any later version.                                     #
#                                                                             #
#  XXX is distributed in the hope that it             #
#  will be useful, but WITHOUT ANY WARRANTY; without even the implied         #
#  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           #
#  See the GNU General Public License for more details.                       #
#                                                                             #
# --------------------------------------------------------------------------- #

  SVG=$1
  OUTDIR=___
  BASENAME=`echo ${SVG%%.*} | rev | cut -d "-" -f 1 | rev`

  echo $OUTDIR/${BASENAME}

# --------------------------------------------------------------------------- #
# INTERACTIVE CHECKS 
# --------------------------------------------------------------------------- #
  if [ ! -f ${SVG%%.*}.svg ]; then echo; echo "We need a svg!"
                                         echo "e.g. $0 yoursvg.svg"; echo
      exit 0;
  fi
  if [ `ls $OUTDIR/${BASENAME}-* | wc -l` -gt 0 ]; then
       echo "export for $SVG does exist!"
       read -p "overwrite $OUTDIR/${BASENAME}-XX? [y/n] " ANSWER
       if [ X$ANSWER != Xy ] ; then echo "Bye"; exit 0; fi
  fi


# --------------------------------------------------------------------------- #
# EXPORT HOW MANY LAYERS? (STANDARD 20, COUNT STARTS AT 100)
# --------------------------------------------------------------------------- #
  EXPORTPAGES=`sed 's/exportpagenum="/\n&/g' $SVG | #
               grep "^exportpagenum" | head -n 1  | #
               cut -d "\"" -f 2`
  if [ `echo $EXPORTPAGES | \
        sed 's/[0-9].*/X/g' | grep X | wc -l` -gt 0 ]; then
        EXPORTPAGES=`expr 100 + $EXPORTPAGES + 1`
  else
        EXPORTPAGES=120
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
  grep -v 'inkscape:label="XX_'          | # REMOVE EXCLUDED LAYERS
  sed 's/<\/svg>//g'                     | # REMOVE SVG CLOSE
  sed 's/display:none/display:inline/g'  | # MAKE VISIBLE EVEN WHEN HIDDEN
  tee > ${SVG%%.*}.tmp                     # WRITE TO TEMPORARY FILE


# --------------------------------------------------------------------------- #
# SHIFT CONTNENT AND EXPORT PDF FILES 
# --------------------------------------------------------------------------- #

  CNT=100
  SHIFTSUM=0

  SVGHEADER=`head -n 1 ${SVG%%.*}.tmp`

  while [ $CNT -lt $EXPORTPAGES ];
   do
       PDF=$OUTDIR/${BASENAME}-${CNT}.pdf

       if [ `expr $CNT \/ 2 \* 2` != $CNT ]; then

             SHIFTADD=1764
       else
             SHIFTADD=1431
       fi

       TRANSFORM="transform=\"translate(-${SHIFTSUM},0)\""

       echo $SVGHEADER        | # THE HEADER
       sed "s/$BREAKFOO/\n/g" | # RESTORE ORIGINAL LINEBREAKS
       sed "s/$SPACEFOO/ /g"  | # RESTORE ORIGINAL SPACES
       tee                                                >  tmp.svg
       echo "<g $TRANSFORM inkscape:label=\"ALL\">"       >> tmp.svg  
       grep "^<g" ${SVG%%.*}.tmp | # SVG LAYERS
       sed "s/$BREAKFOO/\n/g"    | # RESTORE ORIGINAL LINEBREAKS
       sed "s/$SPACEFOO/ /g"     | # RESTORE ORIGINAL SPACES
       tee                                                >> tmp.svg
       echo "</g>"                                        >> tmp.svg
       echo "</svg>"                                      >> tmp.svg
       
       inkscape --export-pdf=$PDF \
                --export-text-to-path \
                tmp.svg
       gs -o ${PDF%%.*}_CONFORMED.pdf          \
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


       SHIFTSUM=`expr $SHIFTSUM + $SHIFTADD`
       CNT=`expr $CNT + 1`

  done



  rm ${SVG%%.*}.tmp tmp.svg


exit 0;

