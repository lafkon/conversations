#!/bin/bash

FOLDER=___
URL=___
TMP=SEEME.html
PDFURL=http://github.com/lafkon/var.release.conversations/raw/master/var/separators/___

#rm A*.tmp

####################################################################
for FILE in `ls $FOLDER/*.png`
do
  NAME=${FILE%.*}
  NAME=${NAME##*/}

echo "<a href=\""$PDFURL/$NAME".pdf\">\
<img src=\""$URL/$NAME.png"\" alt=\"petter\"/>\
</a>" >> A2.tmp
 
done
####################################################################

COUNT=1 ;
A3=`ls $FOLDER/*.png | wc -l`

echo "<html>" >  $TMP
echo "<head>" >> $TMP
#echo "<link rel=\"stylesheet\" href=\"../../../../../.site/css/seeme.css\" type=\"text/css\" />" >> $TMP
echo "<style type=\"text/css\">" >> $TMP
echo "a {" >> $TMP
echo "  background-color: #FF3C00;" >> $TMP
echo "  float: left;" >> $TMP
echo "  margin: 0px 6px 5px 0px;" >> $TMP
echo "}" >> $TMP
echo "body {" >> $TMP
echo "  background-color: #333;" >> $TMP
echo "}" >> $TMP
echo "</style>" >> $TMP
echo "</head>" >> $TMP
echo "<body>" >> $TMP
echo "<div class="posters">" >> $TMP

while [ $COUNT -le $A3 ]
do
     cat A2.tmp | head -$COUNT | tail -1  			>> $TMP
     COUNT=`expr $COUNT + 1`
done

echo "</div>" >> $TMP
echo "</body></html>" 							>> $TMP
rm *.tmp	

exit 0;