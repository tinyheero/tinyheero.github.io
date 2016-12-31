# Hyperlinks 

~~~
\usepackage{hyperref}
\hypersetup{
  colorlinks=true, % make the links colored
  linkcolor=red, % color TOC links in blue
  urlcolor=red, % url color
  citecolor=red, % reference color
  filecolor=red, % external document color
  linktoc=all % 'all' will create links for everything in the TOC
}

% Allows for cross-referencing to an external document.
% http://tex.stackexchange.com/questions/77774/undefined-control-sequence-when-cross-referencing-with-xr-hyper
\usepackage{nameref,zref-xr}
\zxrsetup{toltxlabel}
~~~

* http://tex.stackexchange.com/questions/73862/how-can-i-make-a-clickable-table-of-contents

# Figure Names

If you have dots in your figure name before the dot extension (e.g. figure_name.modified.png), this will throw an error when you try to render the document:

~~~
Unknown graphics extension
~~~

To get around this, use the `grffile` latex package:

~~~
\includegraphics{grffile}
~~~

# Captions

Figure captions contain short and long descriptions. Allows for the table of contents to use only the short caption while the label uses both the short and long.

* http://latex-community.org/forum/viewtopic.php?f=45&t=3522

~~~
\newcommand*\mycaption[2]{\caption[#1]{\textbf{#1}. #2}}
~~~


