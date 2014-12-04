#!/bin/bash


  SVGINPUT=02_edit
  PDFINPUT=var/tmp/o
  OUTPUT=../o/trenner
  TMPDIR=var/tmp

## --------------------------------------------------------------------------- #
## PATCHING PDF WITH SCG-TEXT-LAYERS
## --------------------------------------------------------------------------- #  


  for SVG in `ls $SVGINPUT/*.svg`
  do
  
    SVGFILENAME=`basename $SVG`
    DIRNAME=${SVGFILENAME%%.*}  
    SUPERSVG=$TMPDIR/SUPER_$DIRNAME.tmp   
    SVGHEADER=`tac $SVG | sed -n '/<\/metadata>/,$p' | tac`
    
    echo "----------------------------------------------------------------------"
    echo PROBING: $SVG
    
# START SVG WITH EXISTING CONTENT
# ---------------------------------------------------------------------------- #  

#     sed ':a;N;$!ba;s/\n//g' $SVG           | # REMOVE ALL LINEBREAKS
#     sed 's/<g/\n&/g'                       | # MOVE GROUP TO NEW LINES
#     sed '/groupmode="layer"/s/<g/4Fgt7R/g' | # PLACEHOLDER FOR LAYERGROUP OPEN
#     sed ':a;N;$!ba;s/\n/ /g'               | # REMOVE ALL LINEBREAKS
#     sed 's/4Fgt7R/\n<g/g'                  | # RESTORE LAYERGROUP OPEN + NEWLINE
#     sed 's/display:none/display:inline/g'  | # MAKE VISIBLE EVEN WHEN HIDDEN
#     grep -v 'label="XX_'                   | # REMOVE EXCLUDED LAYERS
#     sed 's/<\/svg>/\n&/g'                  | # CLOSE TAG ON SEPARATE LINE
#     sed "s/^[ \t]*//"                      | # REMOVE LEADING BLANKS
#     tr -s ' '                              | # REMOVE CONSECUTIVE BLANKS
#     tee > $SUPERSVG                          # WRITE TO TEMPORARY FILE

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
     grep -v "XX_"                      | # REMOVE DRAFT LAYERS
     grep -v "IMGREF_"                  | # REMOVE GUIDE LAYER
     sed 's/display:none/display:inline/g' > $SUPERSVG

     
# FIND IMGREF-LAYER
# ---------------------------------------------------------------------------- #   
     PDF2PATCH=`sed ':a;N;$!ba;s/\n/ /g' $SVG | #
                sed 's/inkscape:label/\n&/g'  | #
                cut -d "\"" -f 2              | # 
                grep ^IMGREF_ | head -n 1         | # 
                sed 's/^IMGREF_//g'`

                
# LOOK FOR ACCORING PDF-REPLACEMENT
# ---------------------------------------------------------------------------- #   
     PDF2PATCH=`find $PDFINPUT -name "${PDF2PATCH}.pdf"`

# WRITE CLEANED SVG (REMOVED IMGREF-LAYERS)
# ---------------------------------------------------------------------------- #   
     if [ -n "$PDF2PATCH" ]; then
	echo USING: $PDF2PATCH
	
	echo $SVGHEADER                       	   >  $TMPDIR/${DIRNAME}_TMP.svg
	echo "<g>"      			   >> $TMPDIR/${DIRNAME}_TMP.svg
	cat $SUPERSVG	                  	   >> $TMPDIR/${DIRNAME}_TMP.svg
	echo "</g></svg>"                     	   >> $TMPDIR/${DIRNAME}_TMP.svg

	# EXPORT AND COMBINE TEXT+PDF / EXPORT PNG
	# -------------------------------------------------------------------- #   
	inkscape --export-pdf=$TMPDIR/${DIRNAME}_TMP.pdf \
						      $TMPDIR/${DIRNAME}_TMP.svg
						      
	pdftk $TMPDIR/${DIRNAME}_TMP.pdf background $PDF2PATCH \
					   output $OUTPUT/${DIRNAME}_TRENNER.pdf
					   
	convert -density 100 $OUTPUT/${DIRNAME}_TRENNER.pdf \
						  $OUTPUT/${DIRNAME}_TRENNER.png
				  
	echo  TO OUTPUT: $OUTPUT/${DIRNAME}_TRENNER.pdf
	rm $TMPDIR/${DIRNAME}_TMP.*
    fi
    
    rm $SUPERSVG
  
  done
  
  echo "----------------------------------------------------------------------"     
  exit 0;

