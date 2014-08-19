#!/bin/bash

# ATTACH PATH CONTENT OF A SVG FILE TO AN EXISTING SVG FILE
# ATTENTION: GROUP AND GROUP TRANSLATES WILL BE LOST

  TARGET=$1
  SRCDIR=`echo $2 | sed 's,/$,,'`
  echo "attach $SRCDIR/*.svg to $TARGET"

# --------------------------------------------------------------------------- #
# INTERACTIVE CHECKS 
# --------------------------------------------------------------------------- #
  if [ ! -f ${TARGET%%.*}.svg ]; then 
      echo; echo "We need a svg!"
      echo "e.g. $0 svg2attach2.svg folderwithsvgfiles"; echo
      exit 0;
  fi

  if [ `ls $SRCDIR/*.svg 2>/dev/null | wc -l` -lt 1 ]; then 
      echo; echo "We need a folder with svg files!"
      echo "e.g. $0 svg2attach2.svg folderwithsvgfiles"; echo
      exit 0;
  fi


# START SVG WITH EXISTING CONTENT
# --------------------------------------------------------------------------- #
  cat $TARGET | sed 's,</svg>,,g' >  ${TARGET%%.*}.tmp

  for SVG in `ls $SRCDIR/*.svg`
   do
    # CARE FOR VALID NAME
    # -------------------------------------------------------------------- #
      # NAME=`basename $SVG | \
            # rev | cut -d "." -f 2- | rev | \
            # sed 's/[^a-zA-Z0-9 ]//g' | \
            # sed 's/ /_/g' | \
            # tr [:upper:] [:lower:]`
      NAME=XX_`basename $SVG | \
               rev | cut -d "." -f 2- | rev`

    # OPEN LAYER GROUP
    # -------------------------------------------------------------------- #
      echo "<g id=\""`echo $NAME | md5sum | cut -c 1-8`"\" \
             inkscape:groupmode=\"layer\" \
             inkscape:label=\"$NAME\">" | \
      tr -s ' '              >> ${TARGET%%.*}.tmp

      echo "<g>"             >> ${TARGET%%.*}.tmp

    # COLLECT PATHS (PATHS ONLY = NO PRIMITIVES 
    # -------------------------------------------------------------------- #
      sed ':a;N;$!ba;s/\n/XvT53Dgs33/g' $SVG | # REMOVE ALL NEWLINES
      sed "s/</\n</g"                        | # BRACKETS AS LINES
      egrep "<path"                          | # SELECT SVG STUFF + PATHS 
      sed 's/XvT53Dgs33/ /g'                 | # RESTORE NEWLINES NOT
      tr -s ' '                              | # REMOVE CONSECUTIVE BLANKS
      tee                        >> ${TARGET%%.*}.tmp

    # CLOSE LAYER GROUP
    # -------------------------------------------------------------------- #

      echo "</g>"                >> ${TARGET%%.*}.tmp 
      echo "</g>"                >> ${TARGET%%.*}.tmp

  done

# CLOSE SVG
# --------------------------------------------------------------------------- #
  echo "</svg>"                  >> ${TARGET%%.*}.tmp

# MOVE IN PLACE
# --------------------------------------------------------------------------- #
  mv ${TARGET%%.*}.tmp ${TARGET%%.*}_`date +%s`.svg

# MOVE IN PLACE
# --------------------------------------------------------------------------- #
  sed -i '/^$/d' ${TARGET%%.*}_`date +%s`.svg


exit 0;


