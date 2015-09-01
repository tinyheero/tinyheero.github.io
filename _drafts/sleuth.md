---
layout: post
title:  "kallisto"
tags: [bioinfo, kallisto]
---

[@lpachter](https://twitter.com/lpachter)'s group has recently introduced a new tool called [kallisto](http://pachterlab.github.io/kallisto/) to the bioinformatics community which has created quite a bit of hype through his blog post "[Near-optimal RNA-Seq quantification with kallisto](https://liorpachter.wordpress.com/2015/05/10/near-optimal-rna-seq-quantification-with-kallisto/)". **The paper at the time of this writing is in [pre-print form at arXiv](http://arxiv.org/abs/1505.02710).**

kallisto is considered a "lightweight algorithm" which (to the best of my knowledge) is defined by the [Sailfish paper](http://www.ncbi.nlm.nih.gov/pubmed/24752080) as algorithms which:

> 1. make frugal use of data
> 1. respect constant factors 
> 1. effectively use concurrent hardware by working with small units of data where possible

kallisto is super fast at quantifying the abundance of transcripts from RNA-seq data with high accuracy. The speed on the program can be attributed to the usage of "psuedoalignments" which aims to (from Lior's blog post):

> ...determine, for each read, not where in each transcript it aligns, but rather which transcripts it is compatible with...

As such, it's **NOT** necessary to do a full alignment of the reads to the genome which is often the slowest step in sequencing analysis. Instead, the raw sequence reads (e.g. fastq) are directly compared to transcript sequences and then used to quanitfy transcript abundance. The comparison of the sequencing reads to the transcripts is done using transcriptome de Bruijn graph (T-B. Specifically, the graph is constructed from the k-mers present in an input transcriptome as opposed to reads which is done normally for genome/transcriptome assembly. For instance, here is Figure 1 from the paper:

![Screenshot of fermikit on github]({{ site.url }}/assets/kallisto-fig1.png)

We see three transcripts (Panel a - pink, blue, and green) which then get converted into 

This is Figure 1 - panel A and B from the kallisto paper.

There is also a companion tool called [sleuth](http://pachterlab.github.io/sleuth/) which performs the analysis (e.g. differential expression) the output of kallisto.

This post describes my experience in installing the two pieces of software. 

Output of Kallisto

* target_id transcript name
* pval - pvalue
* qval - FDR adjusted pvalue using benjamini-hochberg
* b - the 'beta' value (analogous to fold change, though technically a bias estimator which has to do with the transformation)
* se_b - the standard error of beta
* mean_obs - the mean of the observations. this is used for the smoothing
* var_obs - the variance of the observations
* tech_var - the technical variance from the bootstraps
* sigma_sq - the raw estimator of the variance once the tech_var has been removed
* smooth_sigma_sq - the smooth regression fit for the shrinkage estimation
* final_sigma_sq - max(sigma_sq, smooth_sigma_sq). this is the one used for covariance estimation of beta (in addition to tech_var)
