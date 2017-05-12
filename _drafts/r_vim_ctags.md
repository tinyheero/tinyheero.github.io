---
layout: post
title:  "Getting Vim and Ctags working in R"
tags: [pan cancer]
---

I've been an avid Vim user for many years and believe it's one of the best text editors out there. My enthusiasm for Vim is also one of the major reasons why I have never adopted RStudio for R programming and instead opted to use the [Nvim-R plugin](https://github.com/jalvesaq/Nvim-R). 

Recently I discovered the power of Ctags.

https://andrew.stwrt.ca/posts/vim-ctags/

```
rtags(path = ".", recursive = TRUE, ofile = "RTAGS")
nvimcom::etags2ctags("RTAGS", "Rtags")
```

Exit R. Now in the shell enter:

```
ctags --languages=C,Fortran,Java,Tcl -R -f RsrcTags .
```

If you want to have a project specific setup, then you want to add the following to your vimrc:

```
set tags+=./Rtags,./RsrcTags,Rtags,RsrcTags;
```

Got the idea from this [stack overflow answer](http://stackoverflow.com/a/8285918).

This effectively makes it so that it searches inside the directory of the source file for where this function is declared and then goes up a directly.
