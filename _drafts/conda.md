---
layout: post
title:  "A Primer on Conda"
tags: [conda]
---

Conda is a package and environment management system. 

## Conda Environments

Conda provides "virtual environments" which are essentially creates an encapsulated /c

To create a new conda environment:

~~~
create create -n name_of_environment
~~~

To export an existing conda environment:

~~~
conda env export > environment.yml
~~~

To remove a conda environment:

~~~
create env remove -n name_of_environment
~~~

## Adding Channels

Checking available channels that would be searched when trying to install a package:

~~~
conda config --get channels
~~~

This will return a ranked list of channels from lowest priority to highest priority. Meaning it will search through the higher priority channels for the package of interest before moving to a lower priorty channelto a lower priorty channel.

To add a channel:

~~~
conda config --add channels bioconda
~~~

To remove a channel:

~~~
conda config --force --remove channels http://conda.anaconda.org/mutirri
~~~

Managing channel priorities:

~~~
conda config --add channels channel_name
~~~

This will add this channel and make it the highest priority. If it is already in the channel list, this will bump it to the highest priority.

## Using R with Conda

To use R with conda, we can install very easily:

~~~
conda install -c r r r-essentials
~~~

Here we are installing both r and r-essentials.

### Package Management

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

You can also build against a very specific version of R:

~~~
conda build --R 3.3.1 r-rmarkdown
~~~

This tells conda to build the rmarkdown R package against the R version 3.3.1

Successful builds can then be uploaded to the anaconda cloud. To do this, you will need the anaconda upload client

~~~
conda install anaconda-client
~~~

Create an anaconda cloud account. Then run:

~~~
anaconda login
~~~

Enter your authetication details to login. Now when you finished building a package, you can run:

~~~
anaconda upload /path/to/build
~~~

Additionally, you can an upload to automatically happen after every successful build

~~~
conda config --set anaconda_upload yes
~~~

## Extra

You can get tab completion for conda by via the argcomplete package:

~~~
conda install argcomplete
~~~

See this [reference](http://conda.pydata.org/docs/install/tab-completion.html) for more details.

## Installing Cairo on OSX-64

~~~
anaconda search -t conda cairo
~~~

~~~
anaconda search -t conda r-cairo
~~~

Had to install freetype

See https://github.com/Automattic/node-canvas/issues/471
