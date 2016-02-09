---
layout: post
title: "Installing the xml2 R Package - \"fatal error: 'libxml/tree.h'\""
date: 2015-08-19
tags: [R, xml2]
---

I recently tried to install the [xml2 R package](https://cran.r-project.org/web/packages/xml2/index.html) (v0.1.1) on my Mac that was running OS X Yosemite (v10.10.4 - 14E46) with Xcode (v6.4 - 6E35b), I ran the following command in my R console:

~~~r
install.packages("xml2", repos = "http://cran.stat.sfu.ca/")
~~~

Only to be met with the following errors:

~~~
trying URL 'http://cran.stat.sfu.ca/src/contrib/xml2_0.1.1.tar.gz'
Content type 'application/x-gzip' length 73772 bytes (72 Kb)
opened URL
==================================================
downloaded 72 Kb

* installing *source* package ‘xml2’ ...
** package ‘xml2’ successfully unpacked and MD5 sums checked
Found libxml2 in -I/usr/include/libxml2
** libs
clang++ -I/usr/local/Cellar/r/3.1.2_1/R.framework/Resources/include -DNDEBUG -I/usr/include/libxml2  -I/usr/local/opt/gettext/include -I/usr/local/opt/readline/include -I"/usr/local/Cellar/r/3.1.2_1/R.framework/Versions/3.1/Resources/library/Rcpp/include" -I"/usr/local/Cellar/r/3.1.2_1/R.framework/Versions/3.1/Resources/library/BH/include"   -fPIC  -g -O2  -c RcppExports.cpp -o RcppExports.o
In file included from RcppExports.cpp:4:
In file included from ./xml2_types.h:4:
./xml2_utils.h:5:10: fatal error: 'libxml/tree.h' file not found
#include <libxml/tree.h>
         ^
1 error generated.
make: *** [RcppExports.o] Error 1
ERROR: compilation failed for package ‘xml2’
* removing ‘/usr/local/Cellar/r/3.1.2_1/R.framework/Versions/3.1/Resources/library/xml2’
* restoring previous ‘/usr/local/Cellar/r/3.1.2_1/R.framework/Versions/3.1/Resources/library/xml2’

The downloaded source packages are in
	‘/private/var/folders/vv/l3j5b1y57sgf08xh75k4p22c0000gn/T/RtmpGoL6zB/downloaded_packages’
Warning message:
In install.packages("xml2", repos = "http://cran.stat.sfu.ca/") :
  installation of package ‘xml2’ had non-zero exit status
~~~

I solved this issue by using [homebrew](http://brew.sh) to install libxml2:

~~~
brew install libxml2
~~~

This should install libxml2 into the folder `/usr/local/Cellar/libxml2`. At the time of this writing, version 2.9.2 was the formula in homebrew. So the exact folder would be `/usr/local/Cellar/libxml2/2.9.2`. 

The next step was to indicate this specific libxml2 folder to use for the installation process. To do this, I downloaded the package source of xml2 and extracted the .tar.gz file. Inside of this folder, you'll find a `configure` file, if you can inspect this file:

~~~
# Use backticks to be bourne compliant
PKGCONFIG=`command -v pkg-config`

# Custom libxml2 path for compatibility with old XML package
if [ "$LIBXML_INCDIR" ]; then
  LIBXML_CFLAGS="-I$LIBXML_INCDIR"
  echo "User specified xml2 headers in $LIBXML_INCDIR."
elif [ "$PKGCONFIG" ]; then
  LIBXML_CFLAGS=`pkg-config --cflags libxml-2.0`
  LIBXML_LIBS=`pkg-config --libs libxml-2.0`
elif [ -r "/usr/include/libxml2/libxml/parser.h" ]; then
  LIBXML_CFLAGS="-I/usr/include/libxml2/"
elif [ -r "/usr/local/include/libxml2/libxml/parser.h" ]; then
  LIBXML_CFLAGS="-I/usr/local/include/libxml2/"
elif [ -r "/opt/csw/include/libxml2/libxml/parser.h" ]; then
  LIBXML_CFLAGS="-I/opt/csw/include/libxml2/"
  LIBXML_LIBS="-L/opt/csw/lib/ -lxml2"
fi

if [ "$LIBXML_CFLAGS" ]; then
  echo "PKG_CPPFLAGS= $LIBXML_CFLAGS" > src/Makevars
  echo "Found libxml2 in $LIBXML_CFLAGS"
else
  echo "Could not find libxml2. Please install libxml2-devel (rpm) or libxml2-dev (deb)."
  exit 1
fi

if [ "$LIBXML_LIBS" ]; then
  echo "PKG_LIBS= $LIBXML_LIBS" >> src/Makevars
else
  echo "PKG_LIBS= -lxml2" >> src/Makevars
fi

exit 0
~~~

We need to set the environment variable `LIBXML_INCDIR` to point to the libxml2 location:

`export LIBXML_INCDIR=/usr/local/Cellar/libxml2/2.9.2`

Now run (from inside the extract libxml2 folder):

~~~
R CMD INSTALL .
~~~

You should be able to successfully install the xml2 R package now!
