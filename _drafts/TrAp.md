---
layout: post
title:  "Using TrAp (Tree Approach to Clonality) for Deconvoluting the Evolutionary Patterns Underlying a Tumour"
tags: [bioinfo, TrAp, cancer, evolution]
---

I recently had a chance to try out the [TrAp software](http://sourceforge.net/projects/klugerlab/files/TrAp/) from the [Yuval Kluger's Lab](http://sourceforge.net/projects/klugerlab/). The publication can be found here:

..

TrAP is an algorithm for inferring the "composition, abundance and evolutionary paths of the underlying cell subpopulations of a tumour." 

# Installing TrAp

TrAp is developed using Java and comes packaged as a .jar file that you can just download from SourceForge \([http://sourceforge.net/projects/klugerlab/files/TrAp/](http://sourceforge.net/projects/klugerlab/files/TrAp/)\). At the time of this writing, there is version 0.31 listed in SourceForge. Once you download the TrApWithDependencies.jar file, you can run:

```bash
java -jar TrApWithDependencies.jar --help

java -jar TrApWithDependencies.jar [ --help ] [ --gui || --text ] [ file ... ]
--gui : Runs TrAp in GUI mode
--text : Runs TrAp in text mode
--help : Prints this help and exits
```

You can actually run TrAp in either gui mode (using the `--gui` option) or text mode (using the `--text` option). Interestingly, if you run TrAp in gui mode it will return a interface that has a log message that says:

> Welcome to the TrAp GUI version 0.3a

Not sure if it should say 0.31 or not? In either case, you can quickly test TrAp in the gui by going `Examples -> Example 1`. Or in the `--text` mode, you can run:

```bash
java -jar TrApWithDependencies.jar --text figure1.txt
```

You can download figure1.txt from SourceFigure under the examples folder. I've also listed the contents below:

```
DATATYPE FIXED 0.0000001
SIGNAL WT 1.
SIGNAL A<sub>2</sub> .8
SIGNAL A<sub>3</sub> .5
SIGNAL A<sub>4</sub> .5
SIGNAL A<sub>5</sub> .4
SIGNAL A<sub>6</sub> .2
```

# Using TrAp

I found that it was a bit tricky to find the documentation on the exact inputs into TrAp. But under the examples folder, you will find a README.txt file that contains some information on the input files. I found that the example input files to be the most informative. My understanding is that each line consists of one these keywords:

1. DATA: defines the type of data to be used
1. DATATYPE : How errors are defined
1. DEFAULT_TOLERANCE : The default tolerance to be used
1. GENERALIZED : Specifies whether the generalized version of the TrAp should be used
1. MAX_NUMBER : The maximum amount of solutions to be shown
1. MAX_PERCENT : The maximum percentage of solutions to be shown
1. SIGNAL: Input of a signal
    + SIGNAL name value [error]

Following the keywords are the options for that keyword. For instance, based on the example figure1.txt file:

```
SIGNAL A<sub>2</sub> .8
```

This line indicates we have:

1. SIGNAL (i.e. genomic aberration)
2. name: A2 (unique identifier of the genomic aberration)
3. value: 0.8 (i.e. cellular frequency of the genomic aberration)

Optionally, we can include an error term for the SIGNAL too.
