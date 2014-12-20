#!/bin/bash

mkdir $1

for SVG in `seq 1 100`
do

FILE=$1/affiche_$SVG.svg
WORDSFILE=itw-momo

echo "<?xml version='1.0' encoding='UTF-8' standalone='no'?>" >>$FILE
echo "<!-- Created with Inkscape (http://www.inkscape.org/) -->" >>$FILE
echo "" >>$FILE
echo "<svg" >>$FILE
echo "   xmlns:dc='http://purl.org/dc/elements/1.1/'" >>$FILE
echo "   xmlns:cc='http://creativecommons.org/ns#'" >>$FILE
echo "   xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'" >>$FILE
echo "   xmlns:svg='http://www.w3.org/2000/svg'" >>$FILE
echo "   xmlns='http://www.w3.org/2000/svg'" >>$FILE
echo "   xmlns:sodipodi='http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd'" >>$FILE
echo "   xmlns:inkscape='http://www.inkscape.org/namespaces/inkscape'" >>$FILE
echo "   width='1073.6221'" >>$FILE
echo "   height='765.35431'" >>$FILE
echo "   id='svg2'" >>$FILE
echo "   version='1.1'" >>$FILE
echo "   inkscape:version='0.48.4 r9939'" >>$FILE
echo "   sodipodi:docname='momo3010-01-whitout.svg'>" >>$FILE
echo "  <defs" >>$FILE
echo "     id='defs4' />" >>$FILE
echo "  <sodipodi:namedview" >>$FILE
echo "     id='base'" >>$FILE
echo "     pagecolor='#ffffff'" >>$FILE
echo "     bordercolor='#666666'" >>$FILE
echo "     borderopacity='1.0'" >>$FILE
echo "     inkscape:pageopacity='0.0'" >>$FILE
echo "     inkscape:pageshadow='2'" >>$FILE
echo "     inkscape:zoom='0.5'" >>$FILE
echo "     inkscape:cx='609.00979'" >>$FILE
echo "     inkscape:cy='506.0287'" >>$FILE
echo "     inkscape:document-units='px'" >>$FILE
echo "     inkscape:current-layer='layer3'" >>$FILE
echo "     showgrid='false'" >>$FILE
echo "     inkscape:window-width='1366'" >>$FILE
echo "     inkscape:window-height='692'" >>$FILE
echo "     inkscape:window-x='0'" >>$FILE
echo "     inkscape:window-y='24'" >>$FILE
echo "     inkscape:window-maximized='1'" >>$FILE
echo "     units='mm' />" >>$FILE
echo "  <metadata" >>$FILE
echo "     id='metadata7'>" >>$FILE
echo "    <rdf:RDF>" >>$FILE
echo "      <cc:Work" >>$FILE
echo "         rdf:about=''>" >>$FILE
echo "        <dc:format>image/svg+xml</dc:format>" >>$FILE
echo "        <dc:type" >>$FILE
echo "           rdf:resource='http://purl.org/dc/dcmitype/StillImage' />" >>$FILE
echo "        <dc:title></dc:title>" >>$FILE
echo "      </cc:Work>" >>$FILE
echo "    </rdf:RDF>" >>$FILE
echo "  </metadata>" >>$FILE
echo "  <g" >>$FILE
echo "     inkscape:groupmode='layer'" >>$FILE
echo "     id='layer3'" >>$FILE
echo "     inkscape:label='fond'" >>$FILE
echo "     transform='translate(0,21.259869)'>" >>$FILE
echo "    <rect" >>$FILE
echo "       style='color:#000000;fill:#00000f;fill-opacity:1;fill-rule:nonzero;stroke:#808080;stroke-width:1.03403807;stroke-linecap:square;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;stroke-dashoffset:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate'" >>$FILE
echo "       id='rect7010'" >>$FILE
echo "       width='1154.8232'" >>$FILE
echo "       height='791.39453'" >>$FILE
echo "       x='-41.411556'" >>$FILE
echo "       y='-38.174202' />" >>$FILE
echo "  </g>" >>$FILE
echo "  <g" >>$FILE
echo "     inkscape:label='gabarit'" >>$FILE
echo "     inkscape:groupmode='layer'" >>$FILE
echo "     id='layer1'" >>$FILE
echo "     transform='translate(0,21.259869)'>" >>$FILE
echo "    <rect" >>$FILE
echo "       style='color:#000000;fill:none;stroke:#ff0000;stroke-width:1;stroke-linecap:square;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;stroke-dashoffset:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate'" >>$FILE
echo "       id='rect3779'" >>$FILE
echo "       width='1052.36'" >>$FILE
echo "       height='744.09003'" >>$FILE
echo "       x='11.129921'" >>$FILE
echo "       y='-11.130063' />" >>$FILE
echo "    <path" >>$FILE
echo "       style='fill:none;stroke:#ff0000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1'" >>$FILE
echo "       d='m 537.30992,-11.130036 0,744.090006'" >>$FILE
echo "       id='path3781'" >>$FILE
echo "       inkscape:connector-curvature='0' />" >>$FILE
echo "    <path" >>$FILE
echo "       style='fill:none;stroke:#ff0000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1'" >>$FILE
echo "       d='m 537.30992,-11.12548 0,744.09'" >>$FILE
echo "       id='path3781-0'" >>$FILE
echo "       inkscape:connector-curvature='0' />" >>$FILE
echo "  </g>" >>$FILE



for TRUC in `seq 1 10`
do
ECHELLEWORD=444
RANDOMNOMBER=$RANDOM


let "RANDOMNOMBER %= $ECHELLEWORD"

WORD=`head -$RANDOMNOMBER itw-momo | tail -1`
echo $WORD

ECHELLE_RANDOM=10

RANDOM1=$RANDOM
RANDOM2=$RANDOM
RANDOM3=$RANDOM
RANDOM4=$RANDOM

let "RANDOM1 %= $ECHELLE_RANDOM"
let "RANDOM2 %= $ECHELLE_RANDOM"
let "RANDOM3 %= $ECHELLE_RANDOM"
let "RANDOM4 %= $ECHELLE_RANDOM"

TRANDOM1=$RANDOM
TRANDOM2=$RANDOM
TRANDOM3=$RANDOM
TRANDOM4=$RANDOM

let "TRANDOM1 %= $ECHELLE_RANDOM"
let "TRANDOM2 %= $ECHELLE_RANDOM"
let "TRANDOM3 %= $ECHELLE_RANDOM"
let "TRANDOM4 %= $ECHELLE_RANDOM"



ECHELLEX=297
ECHELLEY=210

NUMBERX=$RANDOM
NUMBERY=$RANDOM

let "NUMBERX %= $ECHELLEX"
let "NUMBERY %= $ECHELLEY"

ECHELLEFONT=60
NUMBERFONT=$RANDOM

let "NUMBERFONT %= $ECHELLEFONT"



echo "  <g" >>$FILE
echo "     inkscape:label='machins$TRUC'" >>$FILE
echo "     inkscape:groupmode='layer'" >>$FILE
echo "     id='layer1'>" >>$FILE

echo "<text  xml:space='preserve'" >>$FILE
echo "   style='font-size:40px;font-style:normal;font-weight:bold;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#808080;fill-opacity:1;stroke:none;font-family:Sans;-inkscape-font-specification:OCR-A Bold'" >>$FILE
echo "   x='${NUMBERX}mm'" >>$FILE
echo "   y='${NUMBERY}mm'" >>$FILE
echo "   id='text3810'" >>$FILE
echo "   sodipodi:linespacing='125%'" >>$FILE
echo "   transform='matrix(0.$TRANDOM1,0.$TRUCer,0.37361513,0.92758382,0,0)'><tspan" >>$FILE
echo "     sodipodi:role='line'" >>$FILE
echo "     x='${NUMBERX}mm'" >>$FILE
echo "     y='${NUMBERY}mm'" >>$FILE
echo "     id='tspan3812'><tspan" >>$FILE
echo "       x='${NUMBERX}mm'" >>$FILE
echo "       y='${NUMBERY}mm'" >>$FILE
echo "       style='font-variant:normal;font-weight:normal;font-stretch:normal;font-family:OCR-A;-inkscape-font-specification:OCR-A Bold'" >>$FILE
echo "       id='tspan3814'>$WORD</tspan></tspan></text>" >>$FILE
echo "<rect" >>$FILE
echo "   style='color:#000000;fill:none;stroke:#808080;stroke-width:2;stroke-linecap:square;stroke-linejoin:bevel;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;stroke-dashoffset:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate'" >>$FILE
echo "   id='rect3816'" >>$FILE
echo "   width='141'" >>$FILE
echo "   height='78'" >>$FILE
echo "   x='${NUMBERX}mm'" >>$FILE
echo "   y='${NUMBERY}mm'" >>$FILE
echo "   transform='matrix(0.7568135,0.65363088,0.$TRUC,0.$RANDOM4,0,0)' />" >>$FILE

echo "  </g>" >>$FILE

echo "<g" >>$FILE
echo "   inkscape:groupmode='layer'" >>$FILE
echo "   id='layer2'" >>$FILE
echo "   inkscape:label='texte'" >>$FILE
echo "   transform='translate(0,21.259869)'>" >>$FILE
echo "  <text" >>$FILE
echo "     xml:space='preserve'" >>$FILE
echo "     style='font-size:40px;font-style:normal;font-weight:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#fff2f7;fill-opacity:1;stroke:none;display:inline;font-family:Sans'" >>$FILE
echo "     x='-400.81839'" >>$FILE
echo "     y='50.911076'" >>$FILE
echo "     id='text2996'" >>$FILE
echo "     sodipodi:linespacing='125%'" >>$FILE
echo "     transform='matrix(0,-1,1,0,0,0)'><tspan" >>$FILE
echo "       sodipodi:role='line'" >>$FILE
echo "       id='tspan2998'" >>$FILE
echo "       x='-400.81839'" >>$FILE
echo "       y='50.911076'" >>$FILE
echo "       style='font-size:14px;font-style:normal;font-variant:normal;font-weight:500;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:OCRA;-inkscape-font-specification:OCRA Medium'>Chat with momo3010 ~ november 2011</tspan></text>" >>$FILE
echo "  <text" >>$FILE
echo "     xml:space='preserve'" >>$FILE
echo "     style='font-size:40px;font-style:normal;font-weight:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#fff2f7;fill-opacity:1;stroke:none;display:inline;font-family:Sans'" >>$FILE
echo "     x='80.137451'" >>$FILE
echo "     y='61.565952'" >>$FILE
echo "     id='text3004'" >>$FILE
echo "     sodipodi:linespacing='125%'><tspan" >>$FILE
echo "       sodipodi:role='line'" >>$FILE
echo "       id='tspan3006'" >>$FILE
echo "       x='80.137451'" >>$FILE
echo "       y='61.565952'" >>$FILE
echo "       style='font-size:8px;font-style:normal;font-variant:normal;font-weight:500;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:OCRA;-inkscape-font-specification:OCRA Medium'>&gt; momo3010 is now ONLINE...</tspan></text>" >>$FILE
echo "  <flowRoot" >>$FILE
echo "     xml:space='preserve'" >>$FILE
echo "     id='flowRoot3029'" >>$FILE
echo "     style='font-size:11px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#fff2f7;fill-opacity:1;stroke:none;display:inline;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "     transform='translate(482.41117,-60.233179)'><flowRegion" >>$FILE
echo "       id='flowRegion3031'><rect" >>$FILE
echo "         id='rect3033'" >>$FILE
echo "         width='212.78195'" >>$FILE
echo "         height='85.714287'" >>$FILE
echo "         x='188.7218'" >>$FILE
echo "         y='201.98921'" >>$FILE
echo "         style='font-size:11px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode' /></flowRegion><flowPara" >>$FILE
echo "       id='flowPara3035'><flowSpan" >>$FILE
echo "         style='font-size:7px;font-style:normal;font-variant:normal;font-weight:500;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:OCRA;-inkscape-font-specification:OCRA Medium'" >>$FILE
echo "         id='flowSpan3492'>FS: </flowSpan><flowSpan" >>$FILE
echo "         style='font-size:10px;fill:#fff2f7;fill-opacity:1'" >>$FILE
echo "         id='flowSpan3496'>Yes, true.</flowSpan></flowPara></flowRoot>    <text" >>$FILE
echo "     xml:space='preserve'" >>$FILE
echo "     style='font-size:11px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#fff2f7;fill-opacity:1;stroke:none;display:inline;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "     x='671.12988'" >>$FILE
echo "     y='287.14017'" >>$FILE
echo "     id='text3211'" >>$FILE
echo "     sodipodi:linespacing='125%'><tspan" >>$FILE
echo "       sodipodi:role='line'" >>$FILE
echo "       id='tspan3213'" >>$FILE
echo "       x='671.12988'" >>$FILE
echo "       y='287.14017'><tspan" >>$FILE
echo "         style='font-size:7px;font-style:normal;font-variant:normal;font-weight:500;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:OCRA;-inkscape-font-specification:OCRA Medium'" >>$FILE
echo "         id='tspan3537'>FS:</tspan><tspan" >>$FILE
echo "         style='font-size:10px;fill:#fff2f7;fill-opacity:1'" >>$FILE
echo "         id='tspan3535'> you mean the way it plays out?</tspan></tspan></text>" >>$FILE
echo "  <text" >>$FILE
echo "     xml:space='preserve'" >>$FILE
echo "     style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#fff2f7;fill-opacity:1;stroke:none;display:inline;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "     x='671.12988'" >>$FILE
echo "     y='337.0524'" >>$FILE
echo "     id='text3592'" >>$FILE
echo "     sodipodi:linespacing='125%'><tspan" >>$FILE
echo "       sodipodi:role='line'" >>$FILE
echo "       x='671.12988'" >>$FILE
echo "       y='337.0524'" >>$FILE
echo "       id='tspan3596'><tspan" >>$FILE
echo " style='font-size:7px;font-style:normal;font-variant:normal;font-weight:500;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:OCRA;-inkscape-font-specification:OCRA Medium'" >>$FILE
echo " id='tspan3606'>FS: </tspan>i love the way it works with speed, and these fireworks when it turns</tspan><tspan" >>$FILE
echo "       sodipodi:role='line'" >>$FILE
echo "       x='671.12988'" >>$FILE
echo "       y='349.5524'" >>$FILE
echo "       id='tspan3598'><tspan" >>$FILE
echo " style='font-size:7px;font-style:normal;font-variant:normal;font-weight:500;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:OCRA;-inkscape-font-specification:OCRA Medium'" >>$FILE
echo " id='tspan3602'>FS: </tspan>also the drip is great -- i like that it is not faking paint</tspan></text>" >>$FILE
echo "  <text" >>$FILE
echo "     xml:space='preserve'" >>$FILE
echo "     style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#fff2f7;fill-opacity:1;stroke:none;display:inline;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "     x='671.12988'" >>$FILE
echo "     y='374.67471'" >>$FILE
echo "     id='text3662'" >>$FILE
echo "     sodipodi:linespacing='125%'><tspan" >>$FILE
echo "       sodipodi:role='line'" >>$FILE
echo "       id='tspan3664'" >>$FILE
echo "       x='671.12988'" >>$FILE
echo "       y='374.67471'><tspan" >>$FILE
echo " style='font-size:7px;font-style:normal;font-variant:normal;font-weight:500;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:OCRA;-inkscape-font-specification:OCRA Medium'" >>$FILE
echo " id='tspan3668'>FS: </tspan>yes. the digital rendering is super precise without trying to</tspan><tspan" >>$FILE
echo "       sodipodi:role='line'" >>$FILE
echo "       x='671.12988'" >>$FILE
echo "       y='387.17471'" >>$FILE
echo "       id='tspan3666'>be the same. no replacement</tspan></text>" >>$FILE
echo "  <text" >>$FILE
echo "     xml:space='preserve'" >>$FILE
echo "     style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#fff2f7;fill-opacity:1;stroke:none;display:inline;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "     x='671.12988'" >>$FILE
echo "     y='462.08389'" >>$FILE
echo "     id='text3714'" >>$FILE
echo "     sodipodi:linespacing='125%'><tspan" >>$FILE
echo "       sodipodi:role='line'" >>$FILE
echo "       x='671.12988'" >>$FILE
echo "       y='462.08389'" >>$FILE
echo "       id='tspan3718'><tspan" >>$FILE
echo " style='font-size:7px;font-style:normal;font-variant:normal;font-weight:500;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:OCRA;-inkscape-font-specification:OCRA Medium'" >>$FILE
echo " id='tspan3720'>FS: </tspan>yeah. it is sort of legible in the way a tag also talks about how it was done</tspan></text>" >>$FILE
echo "  <text" >>$FILE
echo "     xml:space='preserve'" >>$FILE
echo "     style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#fff2f7;fill-opacity:1;stroke:none;display:inline;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "     x='671.12988'" >>$FILE
echo "     y='499.58078'" >>$FILE
echo "     id='text3858'" >>$FILE
echo "     sodipodi:linespacing='125%'><tspan" >>$FILE
echo "       sodipodi:role='line'" >>$FILE
echo "       id='tspan3860'" >>$FILE
echo "       x='671.12988'" >>$FILE
echo "       y='499.58078'><tspan" >>$FILE
echo " style='font-size:7px;font-style:normal;font-variant:normal;font-weight:500;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:OCRA;-inkscape-font-specification:OCRA Medium'" >>$FILE
echo " id='tspan3862'>FS: </tspan>what do you mean?</tspan></text>" >>$FILE
echo "  <text" >>$FILE
echo "     xml:space='preserve'" >>$FILE
echo "     style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#fff2f7;fill-opacity:1;stroke:none;display:inline;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "     x='671.12988'" >>$FILE
echo "     y='599.78143'" >>$FILE
echo "     id='text4009'" >>$FILE
echo "     sodipodi:linespacing='125%'><tspan" >>$FILE
echo "       sodipodi:role='line'" >>$FILE
echo "       id='tspan4011'" >>$FILE
echo "       x='671.12988'" >>$FILE
echo "       y='599.78143'><tspan" >>$FILE
echo " style='font-size:7px;font-style:normal;font-variant:normal;font-weight:500;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:OCRA;-inkscape-font-specification:OCRA Medium'" >>$FILE
echo " id='tspan4013'>FS: </tspan>sorry you got disconnected</tspan></text>" >>$FILE
echo "  <flowRoot" >>$FILE
echo "     xml:space='preserve'" >>$FILE
echo "     id='flowRoot3818'" >>$FILE
echo "     style='font-size:40px;font-style:normal;font-weight:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#fff2f7;fill-opacity:1;stroke:none;display:inline;font-family:Sans'" >>$FILE
echo "     transform='translate(36.785734,4.3522574)'><flowRegion" >>$FILE
echo "       id='flowRegion3820'><rect" >>$FILE
echo "         id='rect3822'" >>$FILE
echo "         width='458.23459'" >>$FILE
echo "         height='725.39612'" >>$FILE
echo "         x='42.426407'" >>$FILE
echo "         y='62.439095'" >>$FILE
echo "         style='fill:#fff2f7;fill-opacity:1' /></flowRegion><flowPara" >>$FILE
echo "       id='flowPara3938'" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'>momo3010: there is one BIG point i want to make</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5650'>momo3010: graffiti is so easy to do .. u only need a marker or</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5654'>something .. even a pencil is enough and u are in the game .. it</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5656'>takes u 1 min. to buy something to write and start</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5658'>momo3010: with all the computer stuff the entry barrier </flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5660'>is much higher</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5664'>&gt;&gt;&gt;&gt;</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5666'>momo3010: i dont have to understand graffiti to do it. just get out</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5668'>and do it! with gml i have to have a sort of understanding of xml,</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5670'>i will need a comp, internet ..</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5672'>momo3010: what i like of gml is the way to document (save) the tag,</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5674'>keeping the original still outside! that is really cool</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5676'>momo3010: in the gallery i just show the code .. haha</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5678'>momo3010: ‘keep it simple keep it fresh’</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5680'>momo3010: one thing i miss too (i think evan is not forgetting </flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5682'>this aspect)</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5684'>momo3010: is the aesthetic of graffitianalysis</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5686'>&gt;&gt;&gt;&gt;</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5688'>momo3010: yes</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5690'>momo3010: it is super nice .. it attracts people. u see it and ..</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5692'>momo3010: wowow</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5710'>&gt;&gt;&gt;&gt;</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara4018'>momo3010: it is really well done .. so this is the aesthetic point</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara4016'>which is also very important for a tag</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara4024'>&gt;&gt;&gt;&gt;</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara4028'>momo3010: http://www.graffitiresearchlab.de/blitztag</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5714'>momo3010: the germans have made various brushes .. do not know </flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5716'>i like it that much ..</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5718'>momo3010: this is more trying to look like graffiti brushes </flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5720'>but it is not</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5722'>momo3010: gml is cool to keep it raw</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5726'>&gt;&gt;&gt;&gt;</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5728'>momo3010: that is why we need data from outside. the way the tag is</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5730'>done is always depending on the outside!</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5734'>&gt;&gt;&gt;&gt;</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5736'>momo3010: i said to evan: look it is cool the gml recorder .. but</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5738'>if i am in a room my tag looks different then when i am outside</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5742'>momo3010: it makes a difference when, where, and how to place the</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5744'>tag</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5748'>momo3010: is the place hidden, do i have time, is it crowded, </flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5750'>is it a big wall ..</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5752'>momo3010: what i like also about all gml is the fact</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5760'>&gt;&gt;&gt;&gt;</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5762'>momo3010: it opened a whole new direction. combination of digital</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5764'>art with graffiti art .. the two new popular cultures .. i see gml</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5766'>not only as 'x,y, time'. it paved the way to do electronic outdoor</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5768'>stuff.</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5772'>momo3010: everybody interesting in doing something into his area is</flowPara><flowPara" >>$FILE
echo "       style='font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#fff2f7;fill-opacity:1;font-family:Junicode;-inkscape-font-specification:Junicode'" >>$FILE
echo "       id='flowPara5774'>somehow connected to gml.</flowPara></flowRoot>    <path" >>$FILE
echo "     style='fill:#fff2f7;fill-opacity:1;stroke:#ffffff;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;display:inline'" >>$FILE
echo "     d='m 101.92507,597.64955 563.33121,0'" >>$FILE
echo "     id='path3103'" >>$FILE
echo "     inkscape:connector-curvature='0' />" >>$FILE
echo "  <path" >>$FILE
echo "     style='fill:#fff2f7;fill-opacity:1;stroke:#ffffff;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;display:inline'" >>$FILE
echo "     d='m 101.92507,497.57424 563.33121,0'" >>$FILE
echo "     id='path3105'" >>$FILE
echo "     inkscape:connector-curvature='0' />" >>$FILE
echo "  <path" >>$FILE
echo "     style='fill:#fff2f7;fill-opacity:1;stroke:#ffffff;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;display:inline'" >>$FILE
echo "     d='m 101.92507,460.07735 563.33121,0'" >>$FILE
echo "     id='path3107'" >>$FILE
echo "     inkscape:connector-curvature='0' />" >>$FILE
echo "  <path" >>$FILE
echo "     style='fill:#fff2f7;fill-opacity:1;stroke:#ffffff;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;display:inline'" >>$FILE
echo "     d='m 101.92507,372.64919 563.33121,0'" >>$FILE
echo "     id='path3109'" >>$FILE
echo "     inkscape:connector-curvature='0' />" >>$FILE
echo "  <path" >>$FILE
echo "     style='fill:#fff2f7;fill-opacity:1;stroke:#ffffff;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;display:inline'" >>$FILE
echo "     d='m 101.92507,335.11682 563.33121,0'" >>$FILE
echo "     id='path3111'" >>$FILE
echo "     inkscape:connector-curvature='0' />" >>$FILE
echo "  <path" >>$FILE
echo "     style='fill:#fff2f7;fill-opacity:1;stroke:#ffffff;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;display:inline'" >>$FILE
echo "     d='m 101.92507,285.12538 563.33121,0'" >>$FILE
echo "     id='path3113'" >>$FILE
echo "     inkscape:connector-curvature='0' />" >>$FILE
echo "  <path" >>$FILE
echo "     style='fill:#fff2f7;fill-opacity:1;stroke:#ffffff;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;display:inline'" >>$FILE
echo "     d='m 101.92507,147.62416 563.33121,0'" >>$FILE
echo "     id='path3115'" >>$FILE
echo "     inkscape:connector-curvature='0' />" >>$FILE
echo "</g>" >>$FILE

done

echo "</svg>" >>$FILE

done
