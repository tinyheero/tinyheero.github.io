---
layout: post
title:  "Using Bioconductor in a Conda Environment"
tags: [conda, bioconductor, geoquery]
---

I recently switched over to using the [conda package management system](http://conda.pydata.org/docs/) for R. One of the benefits of conda is that package installation can be performed very easily with the command:

~~~bash
conda install -c r r-{name_of_package}
~~~

One of the particular [channels](http://conda.pydata.org/docs/custom-channels.html) is bioconda which is focused on providing bioinformatics packages. From my understanding they are the ones responsible for uploading [bioconductor packages](https://www.bioconductor.org/) to the conda cloud (where all the package binaries sit). 

Recently, I needed to install the [bioconductor package GEOquery](https://www.bioconductor.org/packages/release/bioc/html/GEOquery.html) which can be installed from conda with the following command:

~~~bash
conda install -c bioconda bioconductor-geoquery
~~~

At the time of this writing, the current version is 2.38.4. As it turns out the NCBI, recently changed all http links to be https only resulting in this new version not working. The latest version that is on bioconductor was 2.4, and so I thought maybe the easiest thing to do was to just install it without going through conda:

~~~r
source("https://bioconductor.org/biocLite.R")
biocLite("GEOquery")
~~~

Only I ran into error:

~~~r
> source("https://bioconductor.org/biocLite.R")
Error in file(filename, "r", encoding = encoding) :
  cannot open connection
In addition: Warning message:
In file(filename, "r", encoding = encoding) :
  URL 'https://bioconductor.org/biocLite.R': status was 'Problem with the SSL CA cert (path? access rights?)'
~~~

It seems like the issue is that the SSL CA certificate can't be found? A little googling revealed this [helpful post](https://social.technet.microsoft.com/Forums/systemcenter/en-US/5d9f2b71-b1da-4006-8485-608bfab8815a/installing-bioconductor?forum=ropen<Paste>). Then it clued into me. I was in a conda environment (geo_test) and so the `https://bioconductor.org/biocLite.R` must not be recognize that and thus not be able to find the `.pem` file it needs. 

Searching in my conda environment revealed a `cacert.pem` file to be located at:

~~~bash
/Users/fongchun/miniconda2/envs/geo_test/ssl/cacert.pem
~~~

And so in R, I ran the following command:

~~~r
Sys.setenv(CURL_CA_BUNDLE = "/Users/fongchun/miniconda2/envs/geo_test/ssl/cacert.pem")
~~~

And then I tried to install the latest version of GEOquery from bioconductor again:

~~~r
source("https://bioconductor.org/biocLite.R")
biocLite("GEOquery")
~~~

And success! Hopefully this post helps you solve this SSL problem should you encounter this yourself when using bioconductor in a conda environment.

<div class="alert alert-warning" role="alert">
<h4>Important Note</h4>
I should note that this isn't really the "correct" thing to do it. I should be building the latest version and then submitted it to bioconda. But hey...I am a graduate student and I was in a time crunch :)
</div>
