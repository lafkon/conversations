#!/bin/bash

  SVG=$1
  TMPDIR=.

  PATCHSRCS="../___"


# if [ -z "$SVG" ]; then

#    echo "Please provide an svg file"
#    echo "e.g. $0 input.svg"
#    exit 0

# fi

# OUTPUTDIR=o
# TMPDIR=tmp
# BLANKFONT=i/utils/blank.sfd
# NAME=from_svg_directly
# NAME=hands

# ANSWER=y

# if [ -f ${OUTPUTDIR}/${NAME}.ttf ]; then
#      echo "file does exist"
#      read -p "overwrite ${OUTPUTDIR}/${NAME}.ttf? [y/n] " ANSWER
# fi

# if [ $ANSWER = y ] ; then




# --------------------------------------------------------------------------- #
# MODIFY SVG BODY FOR EASIER PARSING
# --------------------------------------------------------------------------- #

     SVGHEADER=`tac $SVG | sed -n '/<\/metadata>/,$p' | tac`

     sed 's/ / \n/g' $SVG               | # SPACES TO LINEBREAKS
     sed 's/>/>\n/g'                    | # LINEBREAK AFTER END BRACKET
     sed -n '/<\/metadata>/,/<\/svg>/p' | 
     sed '1d;$d'                        | # SELECT BODY ONLY
     sed 's/<g/4Fgt7RfjIoPg7/g'         | # PLACEHOLDER FOR START BRACKET
     sed ':a;N;$!ba;s/\n/ /g'           | # REMOVE ALL NEW LINES
     sed 's/4Fgt7RfjIoPg7/\n<g/g'       | # RESTORE START BRACKET
     sed '/inkscape:label/s/<g/4Fgt7R/g'| # PLACEHOLDER FOR START BRACKET
     sed ':a;N;$!ba;s/\n/ /g'           | # REMOVE ALL NEW LINES
     sed 's/4Fgt7R/\n<g/g'              | # 
     grep  "inkscape:label"             | # LAYERS ONLY
#    grep "<path"                       | # PATHS ONLY
     grep -v "XX_"                      | # REMOVE DRAFT LAYERS
     grep -v "00_"                      | # REMOVE GUIDE LAYER
     sed 's/display:none/display:inline/g' > ${SVG%%.*}.tmp



     PDF2PATCH=`sed ':a;N;$!ba;s/\n/ /g' $SVG | #
                sed 's/inkscape:label/\n&/g'  | #
                cut -d "\"" -f 2              | # 
                grep ^00_ | head -n 1         | # 
                sed 's/^00_//g'`

     echo $PDF2PATCH

     PDF2PATCH=`find $PATCHSRCS -name "${PDF2PATCH}.pdf"`
     echo $PDF2PATCH


     OUT=`basename $SVG | rev | cut -d "." -f 2- | rev`
     SHIFTX="0"
     SHIFTY="0"
     SHIFT="translate($SHIFTX,$SHIFTY)"
     echo $SVGHEADER                       >  $TMPDIR/${OUT}_tmp.svg
     echo "<g transform=\"$SHIFT\">"       >> $TMPDIR/${OUT}_tmp.svg
     cat ${SVG%%.*}.tmp                    >> $TMPDIR/${OUT}_tmp.svg
     echo "</g></svg>"                     >> $TMPDIR/${OUT}_tmp.svg

     inkscape --export-pdf=$TMPDIR/${OUT}_tmp.pdf $TMPDIR/${OUT}_tmp.svg
 
     pdftk $TMPDIR/${OUT}_tmp.pdf background $PDF2PATCH output ${SVG%%.*}.pdf



     rm ${SVG%%.*}.tmp $TMPDIR/${OUT}_tmp.*

## --------------------------------------------------------------------------- #
## ONE SVG FOR EACH LAYER
## --------------------------------------------------------------------------- #
#
#    SHIFTX="-1"
#    SHIFTY="2"
#
#    for LAYER in `cat ${SVG%%.*}.tmp | \
#                  sed 's/ /kjsdf73SAc/g' | \
#                  grep -v "^$" | \
#                  grep "inkscape:label"`
#     do
#        LAYER=`echo $LAYER | sed 's/kjsdf73SAc/ /g'`
#        OUT=`echo $LAYER | sed 's/label/\nlabel/g' | \
#             grep "^label" | cut -d "\"" -f 2`
#
#        SHIFT="translate($SHIFTX,$SHIFTY)"
#
#        echo $SVGHEADER                       >  $TMPDIR/$OUT.svg
#        echo "<g transform=\"$SHIFT\">"       >> $TMPDIR/$OUT.svg
#        echo $LAYER                           >> $TMPDIR/$OUT.svg
#        echo "</g></svg>"                     >> $TMPDIR/$OUT.svg
#
#        inkscape --export-pdf=$TMPDIR/$OUT.pdf $TMPDIR/$OUT.svg
#
#       #STYLE="style=\"fill:#000000;stroke:none;stroke-width:0px\""
#       #sed -i "s/style=\"[^\"]*\"/$STYLE/g" $TMPDIR/$OUT.svg         
#
#    done




# else
#     exit 0;

# fi




# pdftk $TMPDIR/*.pdf cat output $TMPDIR/combined.pdf



# pdftk $TMPDIR/combined.pdf multibackground i/latest.pdf output overlay.pdf


exit 0;




