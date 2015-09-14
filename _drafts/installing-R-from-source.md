---
layout: post
title:  "Installing R from Source"
tags: [R]
---

If you've ever had to install R from source, chances are you'll run into some issues. This blog post lists all the different problems I've encountered and how I got around them. These instructions apply to a Centos Distribution (specifically 7.1) and worked with R-3.2.2. Specifically, I had root access but wanted to install a specific version of R for my personal user account (i.e. in my personal home directory at ~/usr/local).

## Configure, Make, Install

First download the R source package. Once you've extracted the package source, go into the folder and `configure` the compile settings:

```
./configure --prefix=$(HOME)/usr/local/R/3.2.2
```

The `--prefix` indicates that you want R to installed to that specific location. This is just my personal preference where I like to install the software in this format. This allows me to keep easily organize and keep multiple versions of different software. If you did something like this:

```
./configure --prefix=$(HOME)/usr/local
```

And you had an existing installation of R at that location, then you would basically overwrite your existing installation. Once the `configure` step is done, we can run:

```
make
make install
```

After this step, you should have the binary of R installed at `$HOME/usr/local/R/3.2.2/bin/R` and the `Rscript` in the same directory. 

### Cairo

By default, the R installation will have the parameter `--with-cairo` set. This will attempt to compile R with cairo support. This is something you will need if you want to install the [Cairo R package](https://cran.r-project.org/web/packages/Cairo/index.html). You will need to have cairo-devel for this to work:

```
yum install cairo-devel
```

## Common Errors

### headers/libs are not available

You might run into errors like this

1. configure: error: --with-readline=yes (default) and headers/libs are not available
1. configure: error: --with-x=yes (default) and headers/libs are not available

#### GNU Readline

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

#### X11 

The second error `--with-x=yes (default) and headers/libs are not available` occurs because the X11 libraries can't be found. You need to have both `libXt-devel` and `libX11-devel` both of which you can get from yum like:

```
yum install libXt-devel
yum install libX11-devel
```


If you try to install the package Cairo `r install.packages("Cairo")` you may run into 
