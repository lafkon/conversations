#!/bin/bash

 for SVG in `find . -name "*.svg" | grep -v "___"`
  do
     sed -re 's/#[Ff]{6}/XxXxXx/g' $SVG | \
     sed -re 's/#[0]{6}/#ffffff/g' | \
     sed 's/XxXxXx/#000000/g'    > ${SVG%.*}_NEGATIVE.svg
 done

exit 0;
