---
layout: post
title:  "\"Configuration failed because cairo was not found\""
tags: [cairo, R]
---

I recently was trying to install Hadley Wickham's new [svglite R package](https://github.com/hadley/svglite) on my Mac OS X Yosemite:

~~~r
devtools::install_github("hadley/svglite")
~~~

Only to be meant with the following errors:

~~~
** package ‘gdtools’ successfully unpacked and MD5 sums checked
Found pkg-config cflags and libs!
Using PKG_CFLAGS=
Using PKG_LIBS=-L/usr/local/Cellar/cairo/1.14.2_1/lib -lcairo
------------------------- ANTICONF ERROR ---------------------------
Configuration failed because cairo was not found. Try installing:
 * deb: libcairo-dev (Debian, Ubuntu)
 * rpm: cairo-devel (Fedora, CentOS, RHEL)
 * csw: libcairo_dev (Solaris)
 * brew: cairo (OSX)
If cairo is already installed, check that 'pkg-config' is in your
PATH and PKG_CONFIG_PATH contains a cairo.pc file. If pkg-config
is unavailable you can set INCLUDE_DIR and LIB_DIR manually via:
R CMD INSTALL --configure-vars='INCLUDE_DIR=... LIB_DIR=...'
--------------------------------------------------------------------
ERROR: configuration failed for package ‘gdtools’
* removing ‘/usr/local/lib/R/3.2/site-library/gdtools’
~~~

The error message complained about not having cairo installed, even though I had already installed it through homebrew:

~~~bash
brew install cairo

Error: cairo-1.14.2_1 already installed
To install this version, first `brew unlink cairo`
~~~

I noticed that I hadn't set the `PKG_CONFIG_PATH` environment variable so I thought that maybe the `pkg-config` command wasn't able to find the cairo.pc file (located in the folder `/usr/local/lib/pkgconfig`). So I set this:

~~~bash
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
~~~

And tried to run the install command again, but yet it complained again. I finally found this [post](https://github.com/Automattic/node-canvas/wiki/Installation---OSX) which describes how to install Cairo. Specifically it states that if we install Cairo through homebrew, then we need to set the `PKG_CONFIG_PATH` like this:

~~~bash
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig
~~~

The `/opt/X11/lib/pkgconfig` contains other .pc files including another cairo.pc. After doing this, I was able to install the `svglite` R package! 

It's not clear to me why this works exactly (i.e. why it didn't recognize the cairo.pc in `/usr/local/lib/pkgconfig`), but hopefully this helps someone if they encounter this issue. If you know why this works, please do drop a comment!
