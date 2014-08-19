#!/bin/bash

# ATTACH LAYERS OF A SVG FILE TO AN EXISTING SVG FILE

  TARGET=$1
  SOURCE=$2

  SVG=${TARGET%%.*}_`date +%s`.svg

# --------------------------------------------------------------------------- #
# INTERACTIVE CHECKS 
# --------------------------------------------------------------------------- #
  if [ ! -f ${TARGET%%.*}.svg ]; then 
      echo; echo "We need a svg!"
      echo "e.g. $0 svg2attach2.svg svgwithlayers2attach.svg"; echo
      exit 0;
  fi
  if [ ! -f ${SOURCE%%.*}.svg ]; then 
      echo; echo "We need a svg!"
      echo "e.g. $0 svg2attach2.svg svgwithlayers2attach.svg"; echo
      exit 0;
  fi

# --------------------------------------------------------------------------- #
# START SVG WITH EXISTING CONTENT
# --------------------------------------------------------------------------- #
  cat $TARGET | sed 's,</svg>,,g'           >  ${SVG}

# --------------------------------------------------------------------------- #
# MOVE ALL LAYERS ON SEPARATE LINES 
# --------------------------------------------------------------------------- #

  sed ':a;N;$!ba;s/\n/ /g' $SOURCE       | # REMOVE ALL LINEBREAKS
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
# ATTACH LAYERS 
# --------------------------------------------------------------------------- #

# grep "groupmode=\"layer\"" ${SVG%%.*}.tmp >> $SVG
  grep "groupmode=\"layer\"" ${SVG%%.*}.tmp | \
  sed 's/inkscape:label="/&XX_/g'           >> $SVG

# --------------------------------------------------------------------------- #
# CLOSE SVG
# --------------------------------------------------------------------------- #
  echo "</svg>"                             >> $SVG

# --------------------------------------------------------------------------- #
# CLEAN UP
# --------------------------------------------------------------------------- #
  rm ${SVG%%.*}.tmp




exit 0;


