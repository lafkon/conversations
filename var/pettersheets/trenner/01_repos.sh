#!/bin/bash


  INPUT=../i
  OUTPUT=var/tmp/o
  TMPDIR=var/tmp

  #Buchseite inkl. Verschnitt (3mm rundrum)
  PAPERW=154mm
  PAPERH=216mm

  

function CREATEBGPDF {
    SVG=$TMPDIR/black.svg

    echo "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>"	  > $SVG
    echo "<svg xmlns:dc=\"http://purl.org/dc/elements/1.1/\""            >> $SVG
    echo "   xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\""  >> $SVG
    echo "   xmlns:svg=\"http://www.w3.org/2000/svg\""                   >> $SVG
    echo "   xmlns=\"http://www.w3.org/2000/svg\""                       >> $SVG
    echo "   version=\"1.1\""                                            >> $SVG
    echo "   width=\"$PAPERW\""                                          >> $SVG
    echo "   height=\"$PAPERH\""                                         >> $SVG
    echo "   id=\"bglayer\">"                                            >> $SVG
    echo "  <g id=\"bg\">"                                               >> $SVG
    echo "    <rect"                                                     >> $SVG
    echo "       width=\"$PAPERW\""                                      >> $SVG
    echo "       height=\"$PAPERH\""                                     >> $SVG
    echo "       x=\"0\""                                                >> $SVG
    echo "       y=\"0\""                                                >> $SVG
    echo "       id=\"rect\""                                            >> $SVG
    echo "       style=\"fill:#000000;stroke:none\" />"                  >> $SVG
    echo "  </g>"                                                        >> $SVG
    echo "</svg>"                                                        >> $SVG
    
    inkscape --export-pdf=${SVG%%.*}.pdf $SVG 
    
    rm $SVG
}


## --------------------------------------------------------------------------- #
## PLACE, SCALE SHIFT > COMBINE WITH BLACK-BG > OUTPUT PDF AND PNG
## --------------------------------------------------------------------------- #

  CREATEBGPDF

  rm $OUTPUT/*/*_notext.png
  rm $OUTPUT/*/*_notext.pdf  
  
  for PDF in `ls $INPUT/*/*.pdf | grep -v "+GUI.pdf"`
  do

    DIRNAME=`dirname $PDF | rev | cut -d "/" -f 1 | rev`
    FILENAME=`basename $PDF`

    echo "\documentclass[9pt]{scrbook}"                      >  tmp.tex
    echo "\usepackage{pdfpages}"                             >> tmp.tex
    echo "\usepackage{geometry}"                             >> tmp.tex
    echo "\geometry{paperwidth=$PAPERW,paperheight=$PAPERH}" >> tmp.tex
    echo "\begin{document}"                                  >> tmp.tex
    echo "\includepdf[scale=0.8, offset=7mm 1.4mm]"          >> tmp.tex
    echo "{"${PDF}"}"                                        >> tmp.tex
    echo "\end{document}"                                    >> tmp.tex

    pdflatex -interaction=nonstopmode \
	    -output-directory $TMPDIR \
	     tmp.tex  > /dev/null

    mkdir -p $OUTPUT/$DIRNAME

    TMPPDF=$OUTPUT/$DIRNAME/${FILENAME%%.*}_TRENNER_notext.pdf
    pdftk $TMPDIR/tmp.pdf background ${SVG%%.*}.pdf output $TMPPDF    
#     test mit referenzpdf
#     inkscape --export-pdf=${SVG%%.*}.pdf edit/blackref.svg 
#     pdftk ${SVG%%.*}.pdf background $TMPDIR/tmp.pdf output $TMPPDF 

     rm $TMPDIR/tmp.*
     rm tmp.tex

     convert -density 100 $TMPPDF ${TMPPDF%%.*}.png    
     echo $OUTPUT/$DIRNAME/$FILENAME generated
    
  done

  rm ${SVG%%.*}.pdf

  
  

## --------------------------------------------------------------------------- #
## UPDATE IMGREFs IN SVGs
## --------------------------------------------------------------------------- #

  PDFS=var/tmp/o
  SVGS=02_edit

  for SVG in `ls $SVGS/*.svg`
  do

    SVGFILENAME=`basename $SVG`
    DIRNAME=${SVGFILENAME%%.*}  
    SUPERSVG=$TMPDIR/SUPER_$DIRNAME.tmp
    
    if [ `ls $PDFS/$DIRNAME/*_notext.png 2>/dev/null | wc -l` -gt 0 ]; then 
    
# START SVG WITH EXISTING CONTENT
# ---------------------------------------------------------------------------- #  

    sed ':a;N;$!ba;s/\n//g' $SVG           | # REMOVE ALL LINEBREAKS
    sed 's/<g/\n&/g'                       | # MOVE GROUP TO NEW LINES
    sed '/groupmode="layer"/s/<g/4Fgt7R/g' | # PLACEHOLDER FOR LAYERGROUP OPEN
    sed ':a;N;$!ba;s/\n/ /g'               | # REMOVE ALL LINEBREAKS
    sed 's/4Fgt7R/\n<g/g'                  | # RESTORE LAYERGROUP OPEN + NEWLINE
    sed 's/display:none/display:inline/g'  | # MAKE VISIBLE EVEN WHEN HIDDEN
    grep -v 'label="XX_'                   | # REMOVE EXCLUDED LAYERS
    sed 's/<\/svg>/\n&/g'                  | # CLOSE TAG ON SEPARATE LINE
    sed "s/^[ \t]*//"                      | # REMOVE LEADING BLANKS
    tr -s ' '                              | # REMOVE CONSECUTIVE BLANKS
    tee > $SUPERSVG                          # WRITE TO TEMPORARY FILE

  
    # WRITE SVG HEADERS
    # ------------------------------------------------------------------------ #
    head -n 1 $SUPERSVG  				 >  $TMPDIR/$DIRNAME.tmp  
    
    for IMGREF in `ls $PDFS/$DIRNAME/*_notext.png`
    do
    
      IMGFILENAME=`basename $IMGREF`

      # OPEN LAYER GROUP
      # ---------------------------------------------------------------------- #
      GROUPBEGIN="<g id=\"XX_IMGREF_${IMGFILENAME%%.*}\"
            inkscape:groupmode=\"layer\"
            inkscape:label=\"XX_IMGREF_${IMGFILENAME%%.*}\">" 

      # PLACE IMG-REF
      # ---------------------------------------------------------------------- #	
      GROUPBODY="<image y=\"0\" x=\"0\" id=\"image${IMGFILENAME%%.*}\"		  
           height=\"$PAPERH\"
           width=\"$PAPERW\"
           xlink:href=\"../$IMGREF\"
           />"

      # CLOSE LAYER GROUP
      # ---------------------------------------------------------------------- #
      GROUPEND="</g>"
      
      # WRITE NEW LAYER (on one line)
      # ---------------------------------------------------------------------- #
      echo $GROUPBEGIN $GROUPBODY $GROUPEND              >> $TMPDIR/$DIRNAME.tmp
      
    done

    # WRITE ALL REMAINING NON-IMGREF-LAYERS / KEEP RENAMED ONCE (non XX)
    # ------------------------------------------------------------------------ #
    #grep "^<g" $SUPERSVG | grep -v "XX_IMGREF_" 	 >> $TMPDIR/$DIRNAME.tmp
    grep "^<g" $SUPERSVG  	 >> $TMPDIR/$DIRNAME.tmp
      

    # CLOSE SVG
    # ------------------------------------------------------------------------ #
    echo "</svg>"                  			 >> $TMPDIR/$DIRNAME.tmp 
    
# MOVE IN PLACE
# ---------------------------------------------------------------------------- #
  mv $TMPDIR/$DIRNAME.tmp  $SVGS/${DIRNAME%%.*}.svg
  rm $SUPERSVG
  
  echo $SVGS/${DIRNAME%%.*}.svg updated
      
    fi
  done
  
  exit 0;  
  
