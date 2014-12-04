#!/bin/bash


  INPUT=../i
  OUTPUT=../o/sticker
  TMPDIR=var/tmp
  OVERLAYSVG=var/overlay-sticker.svg
  
  #A4
  PAPERW=210mm
  PAPERH=297mm  
  

  
## --------------------------------------------------------------------------- #
## CREATE OVERLAY-PDF FROM SVG ONCE
## --------------------------------------------------------------------------- #  
  
  OVERLAYNAME=`basename $OVERLAYSVG`
  OVERLAYPDF=$TMPDIR/${OVERLAYNAME%%.*}.pdf
  inkscape --export-pdf=$OVERLAYPDF $OVERLAYSVG

  

## --------------------------------------------------------------------------- #
## FIND, INVERT AND COMBINE TO FINAL PDF
## --------------------------------------------------------------------------- #


  for PDF in `ls $INPUT/*/*.pdf`
  do
    FILENAME=`basename $PDF`
    SVG=$TMPDIR/${FILENAME%%.*}.svg
    MOD=$TMPDIR/${FILENAME%%.*}_INVERT.pdf
    
    # CONVERT TO SVG > INVERT COLORS > CONVERT BACK TO PDF
    # ------------------------------------------------------------------------ #
    inkscape --export-plain-svg=$SVG $PDF

    sed -re 's/#[Ff]{6}/XxXxXx/g' $SVG 				| \
    sed -re 's/#[0]{6}/#ffffff/g' 				| \
    sed 's/XxXxXx/#000000/g'      				> tmp.svg

    inkscape --export-pdf=$MOD tmp.svg
   
    rm tmp.svg $SVG

    # SHIFT/SCALE... (not really necessary currently)
    # ------------------------------------------------------------------------ #    
    echo "\documentclass[9pt]{scrbook}"                     	>  tmp.tex
    echo "\usepackage{pdfpages}"                             	>> tmp.tex
    echo "\usepackage{geometry}"                             	>> tmp.tex
    echo "\geometry{paperwidth=$PAPERW,paperheight=$PAPERH}" 	>> tmp.tex
    echo "\begin{document}"                                  	>> tmp.tex
    echo "\includepdf[offset=0mm 0mm, scale=1]"       	     	>> tmp.tex
    echo "{"${MOD}"}"                                        	>> tmp.tex
    echo "\end{document}"                                    	>> tmp.tex

    pdflatex -interaction=nonstopmode \
	    -output-directory $TMPDIR \
	      tmp.tex  > /dev/null

    # COMBINE PATTERN AND TEXT-PDFS > EXPORT PDF AND PNG
    # ------------------------------------------------------------------------ #
    pdftk $OVERLAYPDF background $TMPDIR/tmp.pdf \
				      output $OUTPUT/${FILENAME%%.*}_STICKER.pdf  
				      
    convert -density 100 $OUTPUT/${FILENAME%%.*}_STICKER.pdf \
					     $OUTPUT/${FILENAME%%.*}_STICKER.png 
     
    # CLEANUP
    # ------------------------------------------------------------------------ #
    rm $TMPDIR/tmp.*
    rm tmp.tex
    rm $MOD     
    
    echo $OUTPUT/${FILENAME%%.*} finished
    
  done
  
  rm $OVERLAYPDF
  
  exit 0


  
  
