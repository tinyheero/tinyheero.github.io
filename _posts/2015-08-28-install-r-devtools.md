---
layout: post
title: "Installing devtools on Mac OSX - \"fatal error: 'libxml/tree.h'\""
date: 2015-08-31
tags: [R, devtools, xml2]
---

I recently tried to install the [devtools R package](https://cran.r-project.org/web/packages/xml2/index.html) (v1.8) on my Mac that was running OS X Yosemite (v10.10.4 - 14E46) with Xcode (v6.4 - 6E35b). My R (v3.2.2) was installed using homebrew. 

I ran the following command in my R console:

~~~r
install.packages("devtools")
~~~

Only to be met with the following errors:

~~~
./xml2_utils.h:5:10: fatal error: 'libxml/tree.h' file not found
#include <libxml/tree.h>
~~~

The error is actually an issue with the xml2 R package which is dependency of devtools. I made a separate post, [Installing the xml2 R Package - "fatal error: 'libxml/tree.h'"]({% post_url 2015-08-19-install-r-xml2 %}) that solves this problem. 
