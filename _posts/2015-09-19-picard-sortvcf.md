---
layout: post
title:  "\"VariantContextComparator.java:84\" when Using Picard's SortVcf"
tags: [bioinfo, picard]
---

If you've ever had to sort a vcf file by the same order of as a reference file, then the [SortVcf](http://broadinstitute.github.io/picard/command-line-overview.html#SortVcf) function from Picard tools is what you need. The function can be easily run with the following command:

~~~
java -jar picard.jar SortVcf I=input.vcf O=input.sort.vcf SD=ref.dict
~~~

The ref.dict is the sequence dictionary of your reference genome. This can be generated through Picard tools:

~~~
java -jar picard.jar CreateSequenceDictionary R=ref.fa O=ref.dict
~~~

Now, when you run SortVcf you may encounter an issue like this:

~~~
Exception in thread "main" java.lang.NullPointerException
    at htsjdk.variant.variantcontext.VariantContextComparator.compare(VariantContextComparator.java:84)
    at htsjdk.variant.variantcontext.VariantContextComparator.compare(VariantContextComparator.java:21)
    at java.util.TimSort.countRunAndMakeAscending(TimSort.java:324)
    at java.util.TimSort.sort(TimSort.java:203)
    at java.util.Arrays.sort(Arrays.java:727)
    at htsjdk.samtools.util.SortingCollection.spillToDisk(SortingCollection.java:218)
    at htsjdk.samtools.util.SortingCollection.add(SortingCollection.java:165)
    at picard.vcf.SortVcf.sortInputs(SortVcf.java:154)
    at picard.vcf.SortVcf.doWork(SortVcf.java:87)
    at picard.cmdline.CommandLineProgram.instanceMain(CommandLineProgram.java:187)
    at picard.cmdline.PicardCommandLine.instanceMain(PicardCommandLine.java:95)
    at picard.cmdline.PicardCommandLine.main(PicardCommandLine.java:105)
~~~

It's a bit cryptic, but someone else posted a similar issue on [biostars](https://www.biostars.org/p/138561/). The issue has to do with your input vcf file containing a chromosome that is NOT found in the reference genome. A few things to check for:

1. Make sure it is NOT a UCSC (hg18, hg19) vs. NCBI (b36, b37) chromosome prefix issue. 
1. Make sure the mitochrondrial chromosome matches. Technically, UCSC should be labeling it as chrM. But I've seen it labeled as MT while the rest of the chromosomes have the chr prefix in a vcf file. 

# References

* [Question: Vcf Sort According To Order Of The Reference File](https://www.biostars.org/p/84747/)
* [Picard Tools SortVCF Command Line Overiew](http://broadinstitute.github.io/picard/command-line-overview.html#SortVcf)
