#!/bin/bash

DIR="___/";
cd $DIR;

for FILE in *.pdf;
do
	echo -n  "$FILE"
	if [ `find . -name "${FILE%%.*}.png" | wc -l` -le 0 ]; then
           convert $FILE ${FILE%%.*}.png 
	   echo " converted"
        else
	   echo " existing"
	fi
done;
exit 0;