#!/bin/bash


  INPUT=../i
  OUTPUT=../o/umschlag
  TMPDIR=var/tmp
  OVERLAYSVG=var/overlay-umschlag.svg
  
  #A3 quer
  PAPERW=420mm
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
    
    
    for (( i=0;i<2;i++ ))
    do
      echo "\documentclass[9pt]{scrbook}"                      >  tmp.tex
      echo "\usepackage{pdfpages}"                             >> tmp.tex
      echo "\usepackage{geometry}"                             >> tmp.tex
      echo "\geometry{paperwidth=$PAPERW,paperheight=$PAPERH}" >> tmp.tex
      echo "\begin{document}"                                  >> tmp.tex
      if [ $i -eq 0 ]
	then
	echo "\includepdf[offset=0 -150, angle=75, scale=3]"   >> tmp.tex
	elif [ $i -eq 1 ]
	  then
	echo "\includepdf[offset=-250 0, angle=255, scale=2]"  >> tmp.tex
      fi
      echo "{"${MOD}"}"                                        >> tmp.tex
      echo "\end{document}"                                    >> tmp.tex

      pdflatex -interaction=nonstopmode \
	      -output-directory $TMPDIR \
		tmp.tex  > /dev/null

      # COMBINE PATTERN AND TEXT-PDFS > EXPORT PDF AND PNG
      # ---------------------------------------------------------------------- #
      pdftk $OVERLAYPDF background $TMPDIR/tmp.pdf \
				output $OUTPUT/${FILENAME%%.*}_${i}_UMSCHLAG.pdf  
					
      convert -density 100 $OUTPUT/${FILENAME%%.*}_${i}_UMSCHLAG.pdf \
				       $OUTPUT/${FILENAME%%.*}_${i}_UMSCHLAG.png 
		
		
      echo $OUTPUT/${FILENAME%%.*}_${i}_UMSCHLAG.pdf finished
      
    done
     
    # CLEANUP
    # ------------------------------------------------------------------------ #
    rm $TMPDIR/tmp.*
    rm tmp.tex
    rm $MOD     
    
  done
  
  rm $OVERLAYPDF
  
  exit 0


  
  








#!/bin/bash


#  FOLDER=$1
  FOLDER=i
  OUTPUT=o
  
  TMPDIR=tmp

  PAPERW=1191pt
  PAPERH=842pt
  


  for PDF in `ls $FOLDER/*.pdf`
  do
    i=0
    FILENAME=`basename $PDF`
    SVG=$TMPDIR/${FILENAME%%.*}.svg
    MOD=$TMPDIR/${FILENAME%%.*}_MOD.pdf
    
    inkscape --export-plain-svg=$SVG \
	    $PDF

    sed -re 's/#[Ff]{6}/XxXxXx/g' $SVG | \
    sed -re 's/#[0]{6}/#ffffff/g' | \
    sed 's/XxXxXx/#000000/g'      > tmp.svg

    inkscape --export-pdf=$MOD \
	    tmp.svg

    rm tmp.svg $SVG

    for (( i=0;i<2;i++ ))
    do
      echo "\documentclass[9pt]{scrbook}"                      >  tmp.tex
      echo "\usepackage{pdfpages}"                             >> tmp.tex
      echo "\usepackage{geometry}"                             >> tmp.tex
      echo "\geometry{paperwidth=$PAPERW,paperheight=$PAPERH}" >> tmp.tex
      echo "\begin{document}"                                  >> tmp.tex
      if [ $i -eq 0 ]
	then
	echo "\includepdf[offset=0 -150, angle=75, scale=3]"       >> tmp.tex
	elif [ $i -eq 1 ]
	  then
	echo "\includepdf[offset=-250 0, angle=255, scale=2]"       >> tmp.tex
      fi
      echo "{"${MOD}"}"                                        >> tmp.tex
      echo "\end{document}"                                    >> tmp.tex

      pdflatex -interaction=nonstopmode \
	      -output-directory $TMPDIR \
		tmp.tex  > /dev/null

      
      pdftk overlay-cover.pdf background $TMPDIR/tmp.pdf output $OUTPUT/${FILENAME%%.*}_${i}_COVER.pdf    
    done
    
    #mv $TMPDIR/tmp.pdf $OUTPUT/${FILENAME%%.*}_COVER.pdf 
    rm $TMPDIR/tmp.pdf
    rm $MOD
    
    echo $OUTPUT/${FILENAME%%.*} finished
    
  done

  exit 0;



  
  
