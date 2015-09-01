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

As such, it's **NOT** necessary to do a full alignment of the reads to the genome which is often the slowest step in sequencing analysis. Instead, the raw sequence reads (e.g. fastq) are directly compared to transcript sequences and then used to quanitfy transcript abundance. The comparison of the sequencing reads to the transcripts is done using transcriptome de Bruijn graph (T-DBG).

[See this video ](https://www.youtube.com/watch?v=f-ecmECK7lw) and [Nature primer](http://www.nature.com/nbt/journal/v29/n11/full/nbt.2023.html) for a nice explanation of how De Bruijin Graphs can be applied to Assembly). 

Specifically, the graph is constructed from the k-mers present in an input transcriptome as opposed to reads which is done normally for genome/transcriptome assembly. Specifically, here is Figure 1a,b from the paper (modified slightly to reduce complexity):

![Modified Figure 1a,b]({{ site.url }}/assets/kallisto-fig1-a-b.png)

We see in Figure 1a there are three transcripts (pink, blue, and green) which then get converted into the T-DBG (Figure 1b). Each node/vertex is a k-mer in the T-DBG and is associated with a transcript or set of transcripts (represented by the different colors) which formally in the paper is described as (from my understanding) a k-compatibility class. In other words, the left most node has a k-compatibility class of all 3 transcripts. While the nodes in the top path have a k-compatibility class of only the blue and pink transript. Kallisto will then:

> stores a hash table mapping each k-mer to the contig it is contained in, along with the position within the contig. This structure is called the "kallisto index"

If we were to take a read and hash it back to the T-DBG (pseudoalignment), the different k-mers of the read would be hashed to different nodes in the T-DBG (Figure 1a,c; Modified slighted). 

![Modified Figure 1a,c]({{ site.url }}/assets/kallisto-fig1-a-c.png)

To find the transcript this read corresponds to, we can take the intersection of all the k-compatibility classes (i.e. the transcripts) and this would give us the k-compatibility class of a read and thus the transcripts the read is compatible with (Figure 1c; Modified to add k-compatibility classes of each node). 

![Modified Figure 1c]({{ site.url }}/assets/kallisto-fig1-c.png)

In this case, the intersection of the k-compatible classes of all black nodes would be the blue and pink transcript. This idea can be extended to paired-end reads very easily by simply taking the intersection of the k-compatibility classes along the entire fragment (i.e. both reads). 

This is almost what kallisto does except that it takes advantage of the fact that there can be redundant information along a path. For instance, We see that the 3 left most nodes form a contig (i.e. linear stretches that have identical colorings) and all have the same k-compatibility class; This is classified as having the same "equivalence class". When kallisto hashes a read k-mer to the T-DBG, it looks up the k-compatible class of the node and then **"skips" to the node that is after the last node in the same equivalence class**. Figure 1d demonstrates this:

![Figure 1d,e]({{ site.url }}/assets/kallisto-fig1-d-e.png)

Once the left most k-mer of the read is hashed back, kallisto "skips" the next 2 nodes (as this contains redundant information) and then proceeds to hash only the 4th k-mer of the read. This is quite clever because:

> ...all k-mers in a contig of the T-DBG have the same k-compatibility class, they will not affect the intersection and therefore looking them up in the hash provides no new information. 

So kallisto will always try to "skip over redundant k-mers" or skip to the end of the read. The intersection of the k-compatibility classes then only needs to be done on the "non-skipped" nodes (Figure 1e). This effectively speeds up kallisto significantly since it performs less hash lookups (in this example we only had to perform 3 hash lookups instead of 5). According to the paper:

> For the majority of reads, kallisto ends up performing a hash lookup for only two k-mers (Supp. Fig. 6)

There is also a companion tool called [sleuth](http://pachterlab.github.io/sleuth/) which performs the analysis (e.g. differential expression) the output of kallisto

This post describes my experience in installing the two pieces of software. 


