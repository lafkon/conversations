#!/bin/bash

  MAINURL=http://www.lafkon.net/xk/hotglue/conversations-

  PADNAMEURL=$1

  FUNCTIONS=i/sh/hotglue.functions
  source $FUNCTIONS

  TMPDIR=tmp
  EMPTYLINE="EMPTY-LINE-EMPTY-LINE-EMPTY-LINE-TEMPORARY-NOT"

  PADDUMP=$TMPDIR/pad.md
  PADURL=http://note.pad.constantvzw.org:8000/p/conversations.${PADNAMEURL}/export/txt
  PADHTML=$TMPDIR/pad.html

  PADINFODUMP=$TMPDIR/padinfo.md
  PADINFOURL=http://note.pad.constantvzw.org:8000/p/conversations.informations/export/txt

  PADGLOBAL2DUMP=$TMPDIR/padglobal2.md
  PADGLOBAL2URL=http://note.pad.constantvzw.org:8000/p/conversations/export/txt



# COPY THE GENERAL HEADER
# --------------------------------------------------------------------------- #
  #cp i/canvas/*.box tmp/


# DOWNLOAD THE PAD
# --------------------------------------------------------------------------- #
  wget --no-check-certificate -O $PADDUMP $PADURL
  wget --no-check-certificate -O $PADINFODUMP $PADINFOURL
  wget --no-check-certificate -O $PADGLOBAL2DUMP $PADGLOBAL2URL


# MODIFY STRUCTURE
# --------------------------------------------------- #
# SAVE EMPTYLINES THROUGH PLACEHOLDER
  sed -i "s/^ *$/$EMPTYLINE/g"               $PADDUMP

# CONVERT FOOTNOTES TO COMMANDS
# sed -i 's/\[^\]{/\n% SIDENOTE:/g'          $PADDUMP
  sed -i 's/\[^\]{/\[FT\]\n% SIDENOTE:/g'    $PADDUMP
  sed -i '/^% SIDENOTE/s/}/\n/'              $PADDUMP
# CONVERT BIBREFERENCES TO COMMANDS
  sed -i 's/\[@/\n% BIBITEM:/g'              $PADDUMP
  sed -i '/^% BIBITEM/s/]/\n/'               $PADDUMP

# REMOVE CONSECUTIVE (BLANK) LINES
  sed -i '$!N; /^\(.*\)\n\1$/!P; D'          $PADDUMP


# SET HOTGLUE STANDARD AND START VALUES
# --------------------------------------------------------------------------- #
  XPOSSTANDARD=350
  WIDTHSTANDARD=550

  XPOS=$XPOSSTANDARD ; YPOS=210 ; WIDTH=$WIDTHSTANDARD ;  HEIGHT=0

# COLORSTANDARD="255,255,255"
  BOXCOLORSTANDARD="none"
  BOXCOLOR=$COLORSTANDARD

  TEXTCOLORSTANDARD="0,0,0"
  TEXTCOLOR=$TEXTCOLORSTANDARD

  CHARPERLINESTANDARD=55
  CHARPERLINE=$CHARPERLINESTANDARD

  LINEHEIGHT=10 # 'REAL' HEIGHT FOR BOX CALCULATION
  FOOTNOTECOUNT=1

  FOOTNOTEPOS=0
 YFOOTNOTEPOS=0


 # --------------------------------------------------------------------------- #
 # MAKE THE SPEAKERS PRESENTATION
 # --------------------------------------------------------------------------- #

  # --------------------------------------------------- #
  # GET THE INITIALS OF THE SPEAKERS
 `grep "% NOWSPEAKING:" $PADDUMP | cut -d ":" -f2 | sort | uniq  |\
  sed  's/ //' | sed  '/^$/d'                              >$TMPDIR/SPEAKERLIST`


  HEADER

  MENULOOP1
  LASTYPOS1=`cat $LASTPOSY`
  echo "-------> $LASTYPOS1"

  MENULOOP2 $LASTYPOS1
  LASTYPOS1=`cat $LASTPOSY`
  echo "xxx> $LASTYPOS1"

  MENULOOP3 $LASTYPOS1
  LASTYPOS1=`cat $LASTPOSY`
  echo ":::::> $LASTYPOS1"
  echo "Menu=$MENUBOX"
  echo "MenuPos1=$YPOS1"
  echo "MenuPos2=$YPOS2"
  echo "MenuPos3=$YPOS3"


 # --------------------------------------------------- #
 # LOOP FOR MAKE EACH BOXES
  cat $TMPDIR/SPEAKERLIST |{ while read INITIAL
  do

  if [ "$INITIAL" = "X" ]
    then
    continue
  fi

  YPOS=`expr $YPOS + 20`
  echo  "Les initiaux sont $INITIAL"

  WHO $INITIAL $YPOS
  done


 # --------------------------------------------------- #
 # LOOP FOR MAKING EACH URL CLICKABLE
  NOMBEROFLINK=`grep -o -c  http.* tmp/pad.md`
  echo "$NOMBEROFLINK"

  for ((i=1 ; i<=$NOMBEROFLINK ; i=i+1))
   do
   LINK=`grep -o -m$i http.* tmp/pad.md | tail -n1`
   echo "LINK=$LINK"
   #sed "s/$Vd/<a href=$Vd>$Vd<\/a>/g"
   grep $LINK tmp/pad.md | sed -i "s|$LINK|<a href=\"$LINK\" target=\"_blank\">$LINK</a>|g" tmp/pad.md


  done




# --------------------------------------------------------------------------- #
# PARSE MDSH AND SPLIT THE CONTENT IN SEPARATE PARTS FOR SPEAKERS
# --------------------------------------------------------------------------- #
  FILENAME=4000100
  FILE=$TMPDIR/$FILENAME



  if [ -f $FILE ]; then rm $FILE ; fi


  for LINE in `cat $PADDUMP | sed -e 's/ /djqteDF34/g'`
   do
     # RESTORE SPACES ON CURRENT LINE
       LINE=`echo $LINE | sed 's/djqteDF34/ /g'`


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
     # APPEND LINE TO HOTGLUE FILE
       echo "$LINE" | \
       sed "s/^$/jdsN36Fgc/g" | \
       pandoc -r markdown -w html | \
       sed -e 's/<blockquote>/<i>/' -e 's/<\/blockquote>/<\/i>/' \
           -e 's/<strong>/<b>/' -e 's/<\/strong>/<\/b>/' \
           -e 's/<p>//g' -e 's/<\/p>//g' \
           -e 's/<em>/<b>/g' -e 's/<\/em>/<\/b>/g' \
       >> ${FILE}.dump
       fi
     # --------------------------------------------------- #





 done




# --------------------------------------------------------------------------- #
# FLUSH (EXECUTE A LAST TIME THE NOWSPEAKING COMMAND)
  NOWSPEAKING
# CLEAN UP
   #rm $TMPDIR/*.dump $TMPDIR/*.md


sed -i "s/^object-height:.*$/object-height:${FULLHEIGHT}px/" $TMPDIR/strokeV.box
sed -i "s/HH/H/" $TMPDIR/*.box
sed -i "s/ALA/AL/" $TMPDIR/*.box








# --------------------------------------------------------------------------- #
# UPLOAD TO AN EXISTING HOTGLUE INSTALLATION
# --------------------------------------------------------------------------- #

  if [ "$PADNAMEURL" == "fsnelting+mfuller" ]
    then
    PADNAMEURL=fsnelting-mfuller
  fi

  echo  "$PADNAMEURL"
  CANVASNAME=conversations-$PADNAMEURL

  HOTGLUEBASE=hotglue/content
  HOTGLUECONTENT=$HOTGLUEBASE/$CANVASNAME/head

  ACCESS=`head -n 1 conf/ftp.conf`
    HOST=`tail -n 1 conf/ftp.conf`

  FTPTMP=$TMPDIR/ftp.input
  if [ -f $FILE ]; then rm $TMPDIR/*.md ; fi

# UPLOAD VIA FTP (CONTROL FILE USED LATER)

# LOGIN DATA
# --------------------------------------------------------------------------- #
  echo "$ACCESS"                                                   >  $FTPTMP
# RECURSIVELY CREATE DIRECTORIES
# --------------------------------------------------------------------------- #
  for MAKEDIR in `echo $HOTGLUECONTENT | sed 's,/,\n,g' | \
              tail -2`
   do
      MAKEDIR=$MADEDIR/$MAKEDIR
      echo "mkdir $HOTGLUEBASE$MAKEDIR"                            >> $FTPTMP
      echo "chmod 777 $HOTGLUEBASE$MAKEDIR"                        >> $FTPTMP
      MADEDIR=$MAKEDIR
  done

# CLEAR GENERATED FILES ONLINE
# --------------------------------------------------------------------------- #
  echo "mdelete $HOTGLUECONTENT/*"                                >> $FTPTMP


# UPLOAD FILES
# --------------------------------------------------------------------------- #
  for BOX in `ls $TMPDIR/*.box `
   do
      HOTGLUEFILE=`basename $BOX | cut -d "." -f 1`
    # UPLOAD VIA FTP (CONTROL FILE USED LATER)
      echo "put $BOX $HOTGLUECONTENT/${HOTGLUEFILE}"               >> $FTPTMP
    # CHMOD TO MAKE EDITABLE VIA HOTGLUE/BROWSER
      echo "chmod 666 $HOTGLUECONTENT/${HOTGLUEFILE}"              >> $FTPTMP
  done



# EXIT COMMAND
# --------------------------------------------------------------------------- #
  echo "bye"                                                       >> $FTPTMP

# EXECUTE COMMAND FILE
# --------------------------------------------------------------------------- #
  ftp -i -p -n $HOST  < $FTPTMP
  rm $FTPTMP
  rm $TMPDIR/*




}
exit 0;
