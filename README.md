WHAT
----

A collection of transformer scripts to produce a printed collection 
of conversations on tools and practices around libre graphics. 


http://note.pad.constantvzw.org:8000/p/conversations





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

-------------------------------------------------------------------------------
% INCLUDEMDSH: locationofcode
-------------------------------------------------------------------------------

- includes mdsh code in mdsh code

-------------------------------------------------------------------------------
% NOWSPEAKING: SC
-------------------------------------------------------------------------------

- indicates speaker change

-------------------------------------------------------------------------------
% GRAFIK: locationofpdfjpgsvgpngx
-------------------------------------------------------------------------------

- includes an image. 
- will check for alternate version in the same location
  to provide highest quality

- fullpage/inline/side

-------------------------------------------------------------------------------
% SCALEFONT:
-------------------------------------------------------------------------------

- change fontsize

-------------------------------------------------------------------------------
% RESETFONT:
-------------------------------------------------------------------------------

- go back to standard font definition






CONVERSATIONS
-------------

http://pad.constantvzw.org/p/conversations.harrison
http://pad.constantvzw.org/p/conversations.pamado

