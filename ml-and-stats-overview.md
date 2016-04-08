---
layout: page
title: Machine Learning and Statistics
permalink: /ml-and-stats-overview/
---

Being a somewhat structured person, it's important for me to see how topics relate to each other. With machine learning and statistics being such expansive topics, I struggled (and still do) to understand how all the different methods related to each other. This page is my attempt to structure the various topics/methods of machine learning and statistics. My ultimate goal will be to have a post on each of these topics.

<div class="alert alert-dismissible alert-warning">
<h4>Warning!</h4>
<p>This page is very much a work-in-progress</p>
</div>

## Statistics

* There are 2 major branches of statistics:
    1. Description statistics: Summarizing and presenting key characteristics about some data.
    1. Inferential statistics: Inferring characteristics about a population from a small sample of it. In this branch, you typically start with a hypothesis and then test if your sample follows the hypothesis.
* Probability and statistics deal with questions involving populations and samples, but do so in an "inverse manner" to one another.
    + In a probability problem, properties of a population under study are known (e.g. specified distribution of a population), and questions regarding a sample taken from the population are posed and answered.
    + In a statistics problem, characteristics of the sample are known and properties of the population are inferred.
* We study probability first before statistics because we need to understand the uncertainity associated with taking a sample from a population. Then we are start to understand what a particular sample can tell us about a population.

1. [Random Variables]({% post_url 2016-02-26-random-variables %})
1. Probabilities
    * [Joint, Marginal, and Conditional Probabilites]({% post_url 2016-03-20-basic-prob %})
    * Bayes' Rule
1. [Probability Distributions]({% post_url 2016-03-17-prob-distr %})
   * Continuous
        + Gaussian (Normal) Distribution
        + Dirichlet Distribution
    * Discrete
        + Binomial Distribution
            - Bernoulli Distribution
        + Multinomial Distribution
        + Multivariate Hypergeometric Distribution
            - If sampling is done without replacement.
1. Bayesian Statistics
   * Classical Frequentist vs. Bayesian 
1. Other
    * [Confidence Intervals]({% post_url 2015-08-25-how-to-interpret-a-CI %})

### References

* [Kinds of Statistics](http://be.wvu.edu/divmim/mgmt/blakely/homepage/Mktg325/Kinds%20of%20Statistics%20and%20Types%20of%20Data.pdf): Good introductory article on what the two main branches of statistics are.
* [Introduction to Statistical Thought](http://people.math.umass.edu/~lavine/Book/book.html)
* [Doing Bayesian Data Analysis - A Tutorial with R, JAGS, and Stan](https://sites.google.com/site/doingbayesiandataanalysis/)

## Machine Learning / Statistical Learning

![Machine Learning Algorithm Cheat Sheet]({{ site.url }}/assets/microsoft-machine-learning-algorithm-cheat-sheet-v2.png)

1. Supervised Learning
    * Regression
        + Linear Regression
    * Classification
        + Logistic Regression
        + Linear Discriminant Analysis (LDA)
            - Naive Bayes Classifier
        + Support Vector Machines (SVM)
        + Random Forest
1. Unsupervised Learning
    * Cluster Analysis
        + Principle Component Analysis (PCA)
        + Hierarchical clustering
        + DBSCAN
        + K-means
        + [Mixture Models]({% post_url 2015-10-13-mixture-model %})
        + Topic Modeling
            - Latent Dirichlet Allocation (LDA)
            - Non-negative Matrix Factorization (NMF)
1. Feature Selection
1. Other
    * [Bias-Variance Tradeoff](http://scott.fortmann-roe.com/docs/BiasVariance.html)

### References

* [Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/)
    + [Standard Online - This is the corresponding free online course based on this material](https://statlearning.class.stanford.edu)
* [Elements of Statistical Learning](http://statweb.stanford.edu/~tibs/ElemStatLearn/)
* [PCA vs. Hierarchical clustering](http://www.rna-seqblog.com/a-comparison-between-pca-and-hierarchical-clustering/)
* [Some Things Every Biologist Should Know About Machine Learning](http://master.bioconductor.org/help/course-materials/2003/Milan/Lectures/MachineLearning.pdf)
