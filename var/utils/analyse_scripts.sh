#!/bin/bash


  ROOT=../../
  BASHOPERATORS="^in$|^for|^while|^do|^if|^fi|^done|^then|^else|\]|\[|\{|\}"
  EXCLUDE="^png|^pdf$|^html$|^eps$" # NOT BELONGING HERE
  ADD="bash|gimp|scribus|vim|kate|gedit|ne"

  DUMP=all.tmp
  if [ -f $DUMP ]; then rm $DUMP ; fi




# COMBINE ALL SCRIPTS AND FUNCTIONS
  for SCRIPT in `find $ROOT -name "*.sh" -o -name "*.functions"`
   do
      # echo $SCRIPT
        cat $SCRIPT >> $DUMP
  done

  echo $ADD | sed 's/|/\n/g' >> $DUMP


# GET INFORMATIONS FOR USED PROGRAMS

  for PROGRAM in `cat $DUMP | \
                  grep -v "^#" | \
                  sed 's/for /for/g' | \
                  sed 's/ /\n/g' | \
                  sed 's/\`/\n/g' | \
                  sed 's/;/\n/g' | \
                  sed '/^ *[0-9]\+ *$/d' | \
                  sed '/^[A-Z]*[A-Z]*$/d' | \
                  grep ^[a-z] | \
                  egrep -v "$BASHOPERATORS" | \
                  egrep -v "$EXCLUDE" | \
                  sed 's/^[ \t]*//' |\
                  sort | uniq`
  do
      if [ `man $PROGRAM 2> /dev/null | wc -l` -gt 0 ]; then

        if [ `dpkg -p $PROGRAM 2> /dev/null | wc -l` -gt 0 ]; then

              DPKGINFO=`dpkg -p $PROGRAM | sed ':a;N;$!ba;s/\n/XDrEuWS/g'`
             
              VERSION=`echo $DPKGINFO | sed 's/XDrEuWS/\n/g' | \
                       grep ^Version | cut -d ":" -f 2-`

              DESCRIPTION=`echo $DPKGINFO | sed 's/XDrEuWS/\n/g' | \
                           grep ^Description: | cut -d ":" -f 2-`

              PNAME="$PROGRAM $VERSION"

              echo "\`${PNAME}\`    "
              echo "$DESCRIPTION    "
         else
             if [ `$PROGRAM --version 2> /dev/null | grep $PROGRAM | wc -l` -gt 0  ]; then

                   PNAME=`$PROGRAM --version 2> /dev/null | head -1`
             else
                   VERSION=`man $PROGRAM | tail -1 | \
                            sed 's/  */ /gp' | head -1 | \
                            sed 's/^ //g' | sed "s/ ${PROGRAM}(.*)//gi"`
                   PNAME="$PROGRAM ($VERSION)"
             fi
                   PINFO=`man -f $PROGRAM | head -1 | cut -d "-" -f 2-`

                   echo "\`${PNAME}\`    "
                   echo "$PINFO    "
         fi
               echo
       fi
   done



# rm $DUMP









exit 0;
