#!/bin/bash

# --------------------------------------------------------------------------- #
#                                                                             #
#  Copyright (C) 2015 LAFKON/Christoph Haag                                   #
#                                                                             #
#  svg2pdfxc.sh is free software: you can redistribute it                     # 
#  and/or modify it under the terms of the GNU General Public License as      # 
#  published by the Free Software Foundation, either version 3,               #
#  or (at your option) any later version.                                     #
#                                                                             #
#  svg2pdfxc.sh is distributed in the hope that it                            #
#  will be useful, but WITHOUT ANY WARRANTY; without even the implied         #
#  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           #
#  See the GNU General Public License for more details.                       #
#                                                                             #
# --------------------------------------------------------------------------- #

  SVG=$1 ; SVG=`realpath $SVG` # ABSOLUTE PATH SVG
  BASE=`echo $SVG | rev | cut -d "." -f 2- | rev`
  PDF=${BASE}.pdf

# --------------------------------------------------------------------------- #
# INTERACTIVE CHECKS 
# --------------------------------------------------------------------------- #
  if [ ! -f ${BASE}.svg ]; then echo; echo "We need a svg!"
                                      echo "e.g. $0 yoursvg.svg"; echo
      exit 0;
  fi
  if [ -f $PDF ]; then
       echo "export for $SVG does exist!"
       read -p "overwrite ${PDF}? [y/n] " ANSWER
       if [ X$ANSWER != Xy ] ; then echo "Bye"; exit 0; fi
  fi
# --------------------------------------------------------------------------- #

  inkscape --export-pdf=${PDF} \
           --export-text-to-path \
           $SVG

  gs -o ${BASE}_CONFORMED.pdf              \
     -sDEVICE=pdfwrite                    \
     -sColorConversionStrategy=Gray       \
     -sProcessColorModel=DeviceGray       \
     -sColorImageDownsampleThreshold=2    \
     -sColorImageDownsampleType=Bicubic   \
     -sColorImageResolution=300           \
     -sGrayImageDownsampleThreshold=2     \
     -sGrayImageDownsampleType=Bicubic    \
     -sGrayImageResolution=300            \
     -sMonoImageDownsampleThreshold=2     \
     -sMonoImageDownsampleType=Bicubic    \
     -sMonoImageResolution=1200           \
     -dSubsetFonts=true                   \
     -dEmbedAllFonts=true                 \
     -dAutoRotatePages=/None              \
     -sCannotEmbedFontPolicy=Error        \
     -c ".setpdfwrite<</NeverEmbed[ ]>> setdistillerparams" \
     -f $PDF > /dev/null

  mv ${BASE}_CONFORMED.pdf $PDF

# --------------------------------------------------------------------------- #

exit 0;

