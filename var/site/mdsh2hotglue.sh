#!/bin/bash

  FUNCTIONS=i/sh/hotglue.functions
  source $FUNCTIONS

  TMPDIR=tmp
  EMPTYLINE="EMPTY-LINE-EMPTY-LINE-EMPTY-LINE-TEMPORARY-NOT"

  PADDUMP=$TMPDIR/pad.md
  PADURL=http://note.pad.constantvzw.org:8000/p/conversations.rlafuente/export/txt
  PADHTML=$TMPDIR/pad.html

# COPY THE GENERAL HEADER
# --------------------------------------------------------------------------- #
  cp i/canvas/general-title $TMPDIR/general-title.box
  cp i/canvas/with $TMPDIR/with.box
  cp i/canvas/credits $TMPDIR/credits.box
  cp i/canvas/menu00 $TMPDIR/menu00.box
  cp i/canvas/menu01 $TMPDIR/menu01.box
  cp i/canvas/menu02 $TMPDIR/menu02.box
  cp i/canvas/menu03 $TMPDIR/menu03.box
  cp i/canvas/menu04 $TMPDIR/menu04.box
  cp i/canvas/menu05 $TMPDIR/menu05.box
  cp i/canvas/menu06 $TMPDIR/menu06.box
  cp i/canvas/menu07 $TMPDIR/menu07.box
  cp i/canvas/menu08 $TMPDIR/menu08.box
  cp i/canvas/menu09 $TMPDIR/menu09.box
  cp i/canvas/menu10 $TMPDIR/menu10.box
  cp i/canvas/menu11 $TMPDIR/menu11.box
  cp i/canvas/menu12 $TMPDIR/menu12.box
  cp i/canvas/menu13 $TMPDIR/menu13.box
  cp i/canvas/menu14 $TMPDIR/menu14.box
  cp i/canvas/menu15 $TMPDIR/menu15.box
  cp i/canvas/menu16 $TMPDIR/menu16.box
  cp i/canvas/menu17 $TMPDIR/menu17.box
  cp i/canvas/menu18 $TMPDIR/menu18.box
  cp i/canvas/menu19 $TMPDIR/menu19.box
  cp i/canvas/menu20 $TMPDIR/menu20.box
  cp i/canvas/menu21 $TMPDIR/menu21.box
  cp i/canvas/menu22 $TMPDIR/menu22.box
  cp i/canvas/menu23 $TMPDIR/menu23.box
  cp i/canvas/menu24 $TMPDIR/menu24.box
  cp i/canvas/menu25 $TMPDIR/menu25.box
  cp i/canvas/menu26 $TMPDIR/menu26.box

# DOWNLOAD THE PAD
# --------------------------------------------------------------------------- #
  wget --no-check-certificate -O $PADDUMP $PADURL

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
  XPOSSTANDARD=400
  WIDTHSTANDARD=550

  XPOS=$XPOSSTANDARD ; YPOS=274 ; WIDTH=$WIDTHSTANDARD ;  HEIGHT=0

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
       >> ${FILE}.dump
       fi
     # --------------------------------------------------- #

   done
# --------------------------------------------------------------------------- #
# FLUSH (EXECUTE A LAST TIME THE NOWSPEAKING COMMAND)
  NOWSPEAKING
# CLEAN UP
  rm $TMPDIR/*.dump $TMPDIR/*.md











# --------------------------------------------------------------------------- #
# UPLOAD TO AN EXISTING HOTGLUE INSTALLATION
# --------------------------------------------------------------------------- #

  CANVASNAME=conversations-toolsofthetrade

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
  echo "mdelete $HOTGLUECONTENT/4*"                                >> $FTPTMP


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






exit 0;
