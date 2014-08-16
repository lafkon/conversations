WHAT
----

A collection of transformer scripts to produce a printed collection 
of conversations on tools and practices around libre graphics. 


http://note.pad.constantvzw.org:8000/p/conversations


CONVERSATIONS
-------------

- http://pad.constantvzw.org/p/conversations.harrison
- http://pad.constantvzw.org/p/conversations.pamado




HOW
---

mdsh2tex2pdf.sh is transformer utility to pull mdsh code from some location 
(local/remote) and create a pdf from this content using LaTeX code as an 
intermediary format. In this current setup the markdown code is edited and 
stored in an etherpad environment.

.mdsh is an extension to markdown adding possibility of footnotes, citations, 
comments and action hooks.

Action hooks are lines of text (disguised as comments) that trigger the 
execution defined in a local file. This actions are written for Bash and may do 
anything that's possible on a GNU/Linux commandline interface.


-------------------------------------------------------------------------------
Current actions:
-------------------------------------------------------------------------------


`% INCLUDEMDSH: locationofcode`    
- includes mdsh code in mdsh code


`% NOWSPEAKING: SC`    
- indicates speaker change


`% GRAFIK: locationofpdfjpgsvgpngx`    
- includes an image. 
- will check for alternate version in the same location
  to provide highest quality
- fullpage/inline/side


`% SCALEFONT:`
- change fontsize


`% RESETFONT:`
- go back to standard font definition


USED SOFTWARE
-------------

`basename (GNU coreutils) 8.13`    
 strip directory and suffix from filenames    

`bash  4.2+dfsg-0.1`    
 GNU Bourne Again SHell    

`bibtex (bibtex 0.99d 1 February 2010)`    
 make a bibliography for (La)TeX    

`cat (GNU coreutils) 8.13`    
 concatenate files and print on the standard output    

`convert (ImageMagick Date: 2009/01/10 01:00:00)`    
 convert between image formats as well as resize an image, blur, crop, despeckle, dither, draw on, flip, join, re-sample, and much more.    

`cp (GNU coreutils) 8.13`    
 copy files and directories    

`curl  7.26.0-1+wheezy8`    
 command line tool for transferring data with URL syntax    

`cut (GNU coreutils) 8.13`    
 remove sections from each line of files    

`dpkg  1.16.12`    
 Debian package management system    

`echo (GNU coreutils 8.12.197-032bb September 2011)`    
 display a line of text    

`egrep (GNU grep) 2.12`    
 print lines matching a pattern    

`exit (Linux 2009-09-20)`    
 cause normal process termination    

`expr (GNU coreutils) 8.13`    
 evaluate expressions    

`fold (GNU coreutils) 8.13`    
 wrap each input line to fit in specified width    

`ftp  0.17-27`    
 classical file transfer client    

`gedit  3.4.2-1`    
 official text editor of the GNOME desktop environment    

`gimp  2.8.2-2+deb7u1`    
 The GNU Image Manipulation Program    

`grep  2.12-2`    
 GNU grep, egrep and fgrep    

`head (GNU coreutils) 8.13`    
 output the first part of files    

`inkscape  0.48.3.1-1.3`    
 vector-based drawing program    

`kate  4:4.8.4-1`    
 K Advanced Text Editor    

`latex (Web2C 2012 14 May 2010)`    
 structured text formatting and typesetting    

`ls (GNU coreutils) 8.13`    
 list directory contents    

`makeindex (TeX Live 24 September 2011)`    
 a general purpose, formatter-independent index processor    

`man 2.6.2`    
 macros to format man pages    

`md5sum (GNU coreutils) 8.13`    
 compute and check MD5 message digest    

`mv (GNU coreutils) 8.13`    
 move (rename) files    

`ne  2.4-1`    
 easy-to-use and powerful text editor    

`pandoc  1.9.4.2-2`    
 general markup converter    

`pdflatex (pdftex 1.40 1 March 2011 PDFTEX(1))`    
 PDF output from TeX    

`pdftk  1.44-7`    
 tool for manipulating PDF documents    

`python  2.7.3-4+deb7u1`    
 interactive high-level object-oriented language (default version)    

`read (Linux 2009-02-23)`    
 read from a file descriptor    

`rev from util-linux 2.20.1`    
 reverse lines of a file or files    

`rm (GNU coreutils) 8.13`    
 remove files or directories    

`scribus  1.4.0.dfsg+r17300-1.1`    
 Open Source Desktop Page Layout - stable branch    

`sed  4.2.1-10`    
 The GNU sed stream editor    

`sleep (GNU coreutils) 8.13`    
 delay for a specified amount of time    

`sort (GNU coreutils) 8.13`    
 sort lines of text files    

`tac (GNU coreutils) 8.13`    
 concatenate and print files in reverse    

`tail (GNU coreutils) 8.13`    
 output the last part of files    

`tee (GNU coreutils) 8.13`    
 read from standard input and write to standard output and files    

`tr (GNU coreutils) 8.13`    
 translate or delete characters    

`uniq (GNU coreutils) 8.13`    
 report or omit repeated lines    

`vim  2:7.3.547-7`    
 Vi IMproved - enhanced vi editor    

`wc (GNU coreutils) 8.13`    
 print newline, word, and byte counts for each file    

`wget  1.13.4-3+deb7u1`    
 retrieves files from the web    

