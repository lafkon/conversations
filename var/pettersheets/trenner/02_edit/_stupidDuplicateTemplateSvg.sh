#!/bin/bash

  DIRNAMES=../../i
  TEMPLATE=_template.svg
  OUTPUT=.

  
  for DIR in `ls -d $DIRNAMES/*/`
  do

    NAME=`basename $DIR`
    cp $TEMPLATE $OUTPUT/$NAME.svg
    echo copied $TEMPLATE to: $OUTPUT/$NAME.svg
  
  done
  exit 0
