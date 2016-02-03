---
layout: post
title:  "Configuring R - \"cannot compile a simple Fortran program\""
date:   2016-01-13 11:41
tags: [R]
---

I recently had to install an older version of R (v3.1.2) from source for a specific project. Even though, I have done this a few dozen times it never ceases to amaze me that I still run into new errors. While trying to run `configure`:

~~~bash
./configure --prefix=/home/fong/usr/local/R/3.1.2
~~~

I ran into this error message:

~~~
.
.
.
checking for Fortran 77 libraries of f95...
checking how to get verbose linking output from gcc... -v
checking for C libraries of gcc...  -L/usr/local/lib64 -L/usr/lib64/../lib64 -L/usr/lib/../lib64 -L/usr/local/lib/gcc/x86_64-unknown-linux-gnu/5.2.0 -L/usr/local/lib/gcc/x86_64-unkn
own-linux-gnu/5.2.0/../../../../lib64 -L/lib/../lib64 -L/usr/lib64 -L/usr/local/lib/gcc/x86_64-unknown-linux-gnu/5.2.0/../../../../x86_64-unknown-linux-gnu/lib -L/usr/local/lib/gcc/
x86_64-unknown-linux-gnu/5.2.0/../../.. -lgcc_s
checking for dummy main to link with Fortran 77 libraries... none
checking for Fortran 77 name-mangling scheme... configure: error: in `/home/fong/R-3.2.3':
configure: error: cannot compile a simple Fortran program
See `config.log' for more details
~~~

After doing some googling ([reference](https://github.com/Homebrew/homebrew/issues/12776)), it appeared the issue had to do with no fortran 77 installed on my computer.

But when I checked:

~~~bash
> which gfortran
/usr/local/bin/gfortran
~~~

Clearly, it was on my system. After looking into the `configure` parameters, I found that there was a `F77` parameter that allows me to set "Fortran 77 compiler command". So I modified my `configure` command to:

~~~bash
./configure --prefix=/home/fong/usr/local/R/3.1.2 F77=gfortran
~~~

This fixed my configure problem and the rest of the installation process went smoothly. 
