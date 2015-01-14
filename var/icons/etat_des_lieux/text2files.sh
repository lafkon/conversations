#!/bin/bash

  TEXT=$1
  TMPDIR=.
  TMP=$TMPDIR/${RANDOM}
  OUTPUTDIR=.

  FONTFAMILY=OCRA
  SHIFT=0

# --------------------------------------------------------------------------- #
  e() { echo $1 >> ${OUTPUT}; }
# --------------------------------------------------------------------------- #
  letter2svg() {

   if [ -f $OUTPUT ]; then rm $OUTPUT ; fi
   e '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
   e '<svg width="500" height="500" id="svg" version="1.1"'
   e 'xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"'
   e '>'
   e '<g inkscape:label="letter" inkscape:groupmode="layer" id="X">'
#  e '<rect width="500" height="500" x="0" y="0"'
#  e ' style="fill:#FF0000;stroke-width:0;stroke:none" />'
   e '<flowRoot xml:space="preserve" id="flowRoot"'
   e "style=\"font-size:450px;\
              font-style:normal;\
              font-variant:normal;\
              font-weight:normal;\
              font-stretch:normal;\
              text-align:center;\
              line-height:125%;\
              letter-spacing:0px;\
              word-spacing:0px;\
              writing-mode:lr-tb;\
              text-anchor:middle;\
              fill:#FFFFFF;\
              fill-opacity:1;\
              stroke:none;\
              font-family:$FONTFAMILY;\
             -inkscape-font-specification:$FONTFAMILY\""
   e '><flowRegion id="flowRegion">'
   e "<rect id=\"rect\" width=\"500\" height=\"500\" x=\"0\" y=\"$SHIFT\" />"
   e "</flowRegion><flowPara id=\"flowPara\">$1</flowPara></flowRoot>"
   e '</g>'
   e '</svg>'

   inkscape --export-pdf=${OUTPUT%%.*}.pdf \
            --export-text-to-path          \
            $OUTPUT 2> /dev/null
 # inkscape --export-plain-svg=$OUTPUT ${OUTPUT%%.*}.pdf
   pdftocairo -svg ${OUTPUT%%.*}.pdf $OUTPUT
   rm ${OUTPUT%%.*}.pdf

  }
# --------------------------------------------------------------------------- #

# PLACEHOLDER FOR SPACE = SINGLE CHARACTER NOT APPEARING IN INPUT TEXT
# --------------------------------------------------------------------------- #
    NOT=`echo $TEXT | sed 's/ //g' | sed "s/./&|/g" | rev | cut -c 2- | rev`
  SPFOO=`echo "123456789_-" | sed "s/./&\n/g" | egrep -v "$NOT" | head -n 1`


# --------------------------------------------------------------------------- #
  TEXT=`echo $TEXT | sed "s/ /$SPFOO/g"`

  CCOUNT=100
  for CHARACTER in `echo $TEXT      | # ECHO LINE
                    sed "s/./& /g"`   # ADD A SPACE TO EACH CHARACTER
   do
      OUTPUT=`echo $CHARACTER | sed "s/$SPFOO/-/g"`
      OUTPUT=${OUTPUTDIR}/${CCOUNT}_${OUTPUT}.svg
      CHARACTER=`echo $CHARACTER | sed "s/$SPFOO/ /g"`
      echo $OUTPUT
      letter2svg $CHARACTER
      CCOUNT=`expr $CCOUNT + 1`
  done
# --------------------------------------------------------------------------- #




exit 0;

