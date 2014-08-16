#!/bin/bash



 PADGLOBALDUMP=padglobal.md
 PADGLOBALURL=http://note.pad.constantvzw.org:8000/p/conversations/export/txt

 wget --no-check-certificate -O $PADGLOBALDUMP $PADGLOBALURL



 grep "% INCLUDEMDSH:" $PADGLOBALDUMP | cut -d '.' -f4 | cut -d "/" -f1 | while read name
 do

 echo  "$name"

 ./mdsh2hotglue.sh $name

 done



 #exit 0;
