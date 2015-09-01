---
layout: post
title:  "Installing kallisto and sleuth"
tags: [bioinfo, kallisto]
---

[@lpachter](https://twitter.com/lpachter)'s group has recently introduced a new tool called [kallisto](http://pachterlab.github.io/kallisto/) to the bioinformatics community which has created quite a bit of hype through his blog post "[Near-optimal RNA-Seq quantification with kallisto](https://liorpachter.wordpress.com/2015/05/10/near-optimal-rna-seq-quantification-with-kallisto/)". **The paper at the time of this writing is in [pre-print form at arXiv](http://arxiv.org/abs/1505.02710).**

kallisto is considered a "lightweight algorithm" which (to the best of my knowledge) is defined by the Sailfish paper as algorithms which:

> 1. make frugal use of data
> 1. respect constant factors 
> 1. effectively use concurrent hardware by working with small units of data where possible

The major intellectual advancement is using "psuedoalignments" which aim to (from Lior's blog post):

> ...determine, for each read, not where in each transcript it aligns, but rather which transcripts it is compatible with...

As such, it's **NOT** necessary to do a full alignment of the reads to the genome which is often a very slow step in sequencing analysis. The raw sequence reads (e.g. fastq) are compared directly with the transcript sequences and used to transcript abundance quantification which can be ascertained with high accuracy. (I should mention that this concept was first introduced by [Sailfish](http://www.ncbi.nlm.nih.gov/pubmed/24752080). The comparison of the sequencing reads to the transcripts is done using transcriptome de Bruijn graph. Specifically, the graph is constructed from the k-mers present in an input transcriptome as opposed to reads which is done normally for genome/transcriptome assembly.

kallisto is super fast at quantifying the abundance of transcripts from RNA-seq data with high accuracy. 

There is also a companion tool called [sleuth](http://pachterlab.github.io/sleuth/) which performs the analysis (e.g. differential expression) the output of kallisto.

This post describes my experience in installing the two pieces of software. 

# Installing kallisto

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
