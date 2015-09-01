---
layout: post
title:  "Installing kallisto"
tags: [bioinfo, kallisto]
---

The installations for installing kallisto by source can be found on the [project website](http://pachterlab.github.io/kallisto/source.html). The requirements are a bit higher than usual bioinformatics software, but thankfully I had root access to a relatively new machine running CentOS Linux 7.1. So I was able to install the dependencies using yum as suggested.

However, when I tried to compile kallisto using cmake it complained:

```
cd build;
cmake ..
CMake Error at CMakeLists.txt:1 (cmake_minimum_required):
  CMake 2.8.12 or higher is required.  You are running version 2.8.11

	-- Configuring incomplete, errors occurred!
```

It seems that the latest version of CMake in the yum repo is 2.8.11, but kallisto requires 2.8.12. So for CMake, I had to install from source manually by [downloading the latest CMake source distribution](http://www.cmake.org/download/) (v3.3.1 at the time of this writing) extracting the folder. Then inside the folder:

```
./configure
gmake
gmake install
```

This will install cmake into `/usr/local/bin`. You also need to [remove the cmake installed by yum](http://www.linuxquestions.org/questions/linux-newbie-8/building-and-installing-cmake-806827/). If not, you will get this error when you try to use cmake:

> Could not find CMAKE_ROOT !!! CMake has most likely not been installed correctly.

To do this, run:

```
yum remove cmake
```

After this, you should be able to run compile kallisto as per instructed:

```
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=/path/to/install/kallisto ..
make
make install
```

kallisto will now be able to at `/path/to/install/kallisto`. 
