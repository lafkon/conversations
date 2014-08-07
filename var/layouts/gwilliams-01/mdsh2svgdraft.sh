#!/bin/bash

  URL="http://pad.constantvzw.org/p/conversations.gwilliams/export/txt"
  TMPDIR=.
  NAME=`echo $URL | md5sum | cut -c 1-10`
  SVG=${NAME}.svg

  if [ -f $SVG ]; then
       echo "$SVG does exist"
       read -p "overwrite ${SVG}? [y/n]" ANSWER
       if [ $ANSWER = y ] ; then 
            rm $SVG
       else
            echo "Bye"; exit 0; 
       fi
  fi

  wget --no-check-certificate -O ${TMPDIR}/${NAME}.mdsh $URL # > /dev/null 2>&1

  FUNCTIONS=mdsh2svgdraft.functions
  source $FUNCTIONS


  writeSVG(){ echo $1 >> $SVG; }


# START SVG

  writeSVG '<svg'
  writeSVG '   xmlns:dc="http://purl.org/dc/elements/1.1/"'
  writeSVG '   xmlns:cc="http://creativecommons.org/ns#"'
  writeSVG '   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"'
  writeSVG '   xmlns:svg="http://www.w3.org/2000/svg"'
  writeSVG '   xmlns="http://www.w3.org/2000/svg"'
  writeSVG '   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"'
  writeSVG '   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"'
  writeSVG '   width="524.40942"'
  writeSVG '   height="744.09448"'
  writeSVG '   id="svg2"'
  writeSVG '   version="1.1"'
  writeSVG '   inkscape:version="0.48.3.1 r9886">'
  writeSVG '  <sodipodi:namedview'
  writeSVG '     id="base"'
  writeSVG '     pagecolor="#ffffff"'
  writeSVG '     bordercolor="#666666"'
  writeSVG '     borderopacity="1.0"'
  writeSVG '     inkscape:pageopacity="0.0"'
  writeSVG '     inkscape:pageshadow="2"'
  writeSVG '     inkscape:zoom="0.43398421"'
  writeSVG '     inkscape:cx="-69.535182"'
  writeSVG '     inkscape:cy="391.40329"'
  writeSVG '     inkscape:document-units="px"'
  writeSVG '     inkscape:current-layer="layer2"'
  writeSVG '     showgrid="false"'
  writeSVG '     showguides="true"'
  writeSVG '     inkscape:guide-bbox="true"'
  writeSVG '     units="mm"'
  writeSVG '     width="148mm">'
  writeSVG '    <sodipodi:guide'
  writeSVG '       position="104.88023,645.76615"'
  writeSVG '       orientation="0,314.64896"'
  writeSVG '       id="guide3090" />'
  writeSVG '    <sodipodi:guide'
  writeSVG '       position="419.52919,645.76615"'
  writeSVG '       orientation="566,0"'
  writeSVG '       id="guide3092" />'
  writeSVG '    <sodipodi:guide'
  writeSVG '       position="419.52919,79.766142"'
  writeSVG '       orientation="0,-314.64896"'
  writeSVG '       id="guide3094" />'
  writeSVG '    <sodipodi:guide'
  writeSVG '       position="104.88023,79.766142"'
  writeSVG '       orientation="-566,0"'
  writeSVG '       id="guide3096" />'
  writeSVG '    <sodipodi:guide'
  writeSVG '       position="104.88023,-20.233857"'
  writeSVG '       orientation="-786,0"'
  writeSVG '       id="guide3098" />'
  writeSVG '    <sodipodi:guide'
  writeSVG '       position="419.52919,765.76614"'
  writeSVG '       orientation="786,0"'
  writeSVG '       id="guide3100" />'
  writeSVG '  </sodipodi:namedview>'
  writeSVG '  <g inkscape:label="XX_0000" inkscape:groupmode="layer" id="0000">'  

# INSERT TEXT

  for LINE in `cat ${TMPDIR}/${NAME}.mdsh | \
               sed 's/ /HdzIcs734DwP/g' | sed '/^$/d'`
   do
      # --------------------------------------------------- # 
      # RESTORE SPACES
        LINE=`echo $LINE | sed 's/HdzIcs734DwP/ /g'`
      # --------------------------------------------------- #  
      # CHECK IF LINE STARTS WITH A %
        ISCMD=`echo $LINE | grep ^% | wc -l`
      # --------------------------------------------------- # 
      # IF LINE STARTS WITH A %
        if [ $ISCMD -ge 1 ]; then

           CMD=`echo $LINE | \
                cut -d "%" -f 2 | \
                cut -d ":" -f 1 | \
                sed 's, ,,g'`
           ARG=`echo $LINE | cut -d ":" -f 2-`
      # --------------------------------------------------- # 
      # CHECK IF COMMAND EXISTS

           CMDEXISTS=`grep "^function ${CMD}()" $FUNCTIONS |\
                      wc -l`
      # --------------------------------------------------- # 
      # IF COMMAND EXISTS 
        if [ $CMDEXISTS -ge 1 ]; then
           # EXECUTE COMMAND
             $CMD $ARG
        fi
      # --------------------------------------------------- # 
      # IF LINE DOES NOT START WITH % (= SIMPLE MARKDOWN)
        else
      # --------------------------------------------------- # 
      # APPEND LINE TO TEX FILE
        writeSVG "$LINE"
        fi
      # --------------------------------------------------- # 

  done

# CLOSE SVG


  writeSVG '</flowPara></flowRoot>'
  writeSVG '</g>'
  writeSVG '</svg>'

# CLEAN UP

  rm ${TMPDIR}/${NAME}.mdsh




exit 0;
