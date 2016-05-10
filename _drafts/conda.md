---
layout: post
title:  "Inferring Clonal Dynamics"
tags: [bioinfo, kallisto]
---

## Create Conda Environments

~~~
conda create --name env_name r
~~~

## Adding Channels

Checking channels:

~~~
conda config --get channels
~~~

~~~
conda config --add channels bioconda
~~~

## Exporting Conda Environments

~~~
create env export > environment.yml
~~~

## Package Management

Install a package is as simple as running `conda install`. Here we will use the example of trying to install the rmarkdown package in R.

~~~
conda install rmarkdown
~~~

This will search from the available channels and try to install the first (?) version of the package it sees. You can tell conda to install a speciifc version of the package by going:

~~~
conda install rmarkdown=0.9.6
~~~

If you want to install from a very specific channel, you can add the `-c` parameter:

~~~
conda install -c fongchun rmarkdown=0.9.6
~~~

In this situation, we would be installing the rmarkdown package (v0.9.6) from my anaconda channel.

Searching for a package

~~~
conda search name_of_package
~~~

To build build your own packages, first we need to install conda-build (id

~~~
conda install conda-build
~~~

Once we have done this, we can create a skeleton from a CRAN package:

~~~
conda skeleton cran rmarkdown
~~~

Then we need to build it now (notice how R packages will be prepended with a "r" prefix):

~~~
conda build r-rmarkdown
~~~

If you have an anaconda account setup properly, this will also automatically 
