---
layout: post
title:  "Installing R from Source - Solving the Readline and X11 Libraries Not Available Errors"
tags: [R]
---

If you've ever had to install R from source, chances are you'll run into some issues. This blog post lists all the different problems I've encountered and how I got around them. These instructions apply to a Centos Distribution (specifically 7.1) and worked with R-3.2.2.  

## headers/libs are not available

You might run into errors like this

1. configure: error: --with-readline=yes (default) and headers/libs are not available
1. configure: error: --with-x=yes (default) and headers/libs are not available

### GNU Readline

The first error `error: --with-readline=yes (default) and headers/libs are not available` is related to the fact that R can't find the libraries for [GNU Readline](https://cnswww.cns.cwru.edu/php/chet/readline/rltop.html). The easiest solution is to just set `--with-readline=no` in your `./configure` statement. But this is **not** recommend based on [posts I've read on forums](http://stackoverflow.com/questions/17473547/error-with-readline-yes-default-and-headers-libs-are-not-available). 

What you need to do is install this GNU Readline. For me, I had access to admin on the machine and I could see that readline was installed at:

```
ls /usr/lib64
libreadline.so -> ../../lib64/libreadline.so.6
libreadline.so.6 -> libreadline.so.6.2
libreadline.so.6.2
```

It didn't make sense to me why R couldn't see these libraries. After some [digging around](http://stackoverflow.com/questions/17473547/error-with-readline-yes-default-and-headers-libs-are-not-available), it turns out you need to actually get both the readline and readline-devel packages. You can do this with:

```
yum install readline
yum install readline-devel
```

I am not 100% sure of the differences between these two libraries, but it appears that if you need to develop programs that require the `readline` package then you need to install `readline-devel`.

### X11 

The second error `--with-x=yes (default) and headers/libs are not available` occurs because the X11 libraries can't be found. You need to have both `libXt-devel` and `libX11-devel` both of which you can get from yum like:

```
yum install libXt-devel
yum install libX11-devel
```
