#!/bin/bash


  PDFS=tmp/o
  SVGS=01_addText
  TMPDIR=tmp





## --------------------------------------------------------------------------- #
## UPDATE IMGREFs IN SVGs
## --------------------------------------------------------------------------- #


  for SVG in `ls $SVGS/*.svg`
  do

    SVGFILENAME=`basename $SVG`
    DIRNAME=${SVGFILENAME%%.*}  
    SUPERSVG=$TMPDIR/SUPER_$DIRNAME.tmp
    
# START SVG WITH EXISTING CONTENT
# ---------------------------------------------------------------------------- #  

    sed ':a;N;$!ba;s/\n//g' $SVG           	 | # REMOVE ALL LINEBREAKS
    sed 's/<g/\n&/g'                       	 | # MOVE GROUP TO NEW LINES
    sed '/groupmode="layer"/s/<g/4Fgt7R/g'	 | # PLACEHOLDER FOR LAYERGROUP OPEN
    sed ':a;N;$!ba;s/\n/ /g'              	 | # REMOVE ALL LINEBREAKS
    sed 's/4Fgt7R/\n<g/g'                 	 | # RESTORE LAYERGROUP OPEN + NEWLINE
    sed 's/display:none/display:inline/g' 	 | # MAKE VISIBLE EVEN WHEN HIDDEN
    grep -v 'label="XX_'                  	 | # REMOVE EXCLUDED LAYERS
    sed 's/<\/svg>/\n&/g'                 	 | # CLOSE TAG ON SEPARATE LINE
    sed "s/^[ \t]*//"                     	 | # REMOVE LEADING BLANKS
    tr -s ' '                             	 | # REMOVE CONSECUTIVE BLANKS
    tee > $SUPERSVG                       	   # WRITE TO TEMPORARY FILE

  
    # WRITE SVG HEADERS
    # ------------------------------------------------------------------------ #
    head -n 1 $SUPERSVG  				 >  $TMPDIR/$DIRNAME.tmp  


    for IMGREF in `ls $PDFS/$DIRNAME/*_notext.png`
    do
    
      IMGFILENAME=`basename $IMGREF`
      echo $IMGREF

      # OPEN LAYER GROUP
      # ---------------------------------------------------------------------- #
      echo "<g id=\""`echo IMGREF_${IMGFILENAME%%.*} | md5sum | cut -c 1-8`"\" \
	    inkscape:groupmode=\"layer\" \
	    inkscape:label=\"IMGREF_${IMGFILENAME%%.*}\">" | \
      tr -s ' '              				 >> $TMPDIR/$DIRNAME.tmp

      # PLACE IMG-REF
      # ---------------------------------------------------------------------- #	
      echo "<image"  					 >> $TMPDIR/$DIRNAME.tmp
      echo "  y=\"0\"" 					 >> $TMPDIR/$DIRNAME.tmp
      echo "  x=\"0\""  				 >> $TMPDIR/$DIRNAME.tmp
      echo "  id=\"image10\""  				 >> $TMPDIR/$DIRNAME.tmp
      echo "  height=\"613\"" 				 >> $TMPDIR/$DIRNAME.tmp
      echo "  width=\"437\""  				 >> $TMPDIR/$DIRNAME.tmp
      echo "  xlink:href=\"../$IMGREF\""  		 >> $TMPDIR/$DIRNAME.tmp
      echo "/>"  					 >> $TMPDIR/$DIRNAME.tmp
      
      # CLOSE LAYER GROUP
      # ---------------------------------------------------------------------- #
      echo "</g>"               			 >> $TMPDIR/$DIRNAME.tmp
      
    done

    # WRITE ALL REMAINING NON-IMGREF-LAYERS 
    # ------------------------------------------------------------------------ #
    grep "^<g" $SUPERSVG | grep -v "IMGREF_" 		 >> $TMPDIR/$DIRNAME.tmp
      

    # CLOSE SVG
    # ------------------------------------------------------------------------ #
    echo "</svg>"                  			 >> $TMPDIR/$DIRNAME.tmp 
    
# MOVE IN PLACE
# ---------------------------------------------------------------------------- #
  mv $TMPDIR/$DIRNAME.tmp  $TMPDIR/${DIRNAME%%.*}.svg   
      
  done

  
  exit 0;  
  
