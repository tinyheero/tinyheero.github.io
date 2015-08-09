---
layout: post
title:  "Making Patient Gene Mutation Matrix Plots"
tags: [R, Bioinformatics, Cancer]
---

Have you ever thought about the human body can be so resilant to so many different pathogens that exist and respond to even those it hasn't seen? A key mechanism that ensures this adaptibility of immune system is a process called "Somatic Hypermutation". This process is mediated by an enzyme called activation-induced cytidine deaminase (AID) that mutates the VDJ region of a normal B-cell which plays a role in creating antibodies for the immune system. By inducing these somatic mutations, variability in the region is generated allowing for B-cells to produce different types of antibodies that can respond to all sorts of pathogens.

In B-cell lymphomas, it is known that these malignant B-cells can co-opt various mechanisms of normal B-cells and use it to its advantage. One of these mechanisms that it co-opts is the somatic hypermutation mechanism allowing for these malignant B-cells to mutate other genomic regions that aren't associated with antibody production. For instance, 

The immune system employs a mechanism called somatic hypermutation that mutates the VDJ regions of normal B-cells 

Somatic hypermutation is a process that is mediated by an enzyme called Activation-induced cytidine deaminase (AID) that normally mutates the VDJ region of a normal B-cell. This functions to generate diversity to allow for different anti-bodies to be created so that the body can respond to various forms of pathogen. This mechanism can be co-opted by a tumour cell and used to somatically mutated regions outside of the VDJ region (called Aberrant SHM (or ASHM)) and eventually resulting in effects that may help the tumour cells proliferate. We know two things about SHM:

It has a preference to mutate the G base in the RGYW motif (A/G, G, C/T, A/T). Or the C base in the WRCY (A/T, A/G, C, C/T) motif.

* SHM can operate on other motifs that are NOT RGYW or WRCY. But these two motifs are the most recognized in literature.
* It operates within the first 2000 base-pairs downstream of the transcription start site of a gene. This is strand-specific.

* Cite Pasqualucci's work

Fortunately, the folks at Bioconductor have provided us with some great tools for the job. We will specifically be making use of these R packages:

* [GenomicRanges](http://bioconductor.org/packages/release/bioc/html/GenomicRanges.html): Representation and manipulation of genomic intervals 

# Specifying GRanges

Given a table of SNVs, we first need to create a GRanges object. 

```{r}
snvs.gr <- Ranges(snvs.df$chr, IRanges(start = snvs.df$pos, end = snvs.df$pos))
```

To look into whether SNVs fall into our specified regions of interest, we can make use of the findOverlaps function

```r
findOverlaps(snvs.gr, tss.gr)
```

http://al2na.github.io/compgenr/genomic_intervals/granges.html

addMotifToSnv
