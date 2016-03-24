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

1. [Random Variables]({% post_url 2016-02-26-random-variables %})
1. Probabilities
    * Joint, Marginal, and Conditional Probabilites
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
    * Principle Component Analysis (PCA)
    * Hierarchical clustering
    * DBSCAN
    * Cluster Analysis
        + K-means
        + [Mixture Models]({% post_url 2015-10-13-mixture-model %})
        + Topic Modeling
            - Latent Dirichlet Allocation (LDA)
            - Non-negative Matrix Factorization (NMF)
1. Other
    * [Bias-Variance Tradeoff](http://scott.fortmann-roe.com/docs/BiasVariance.html)

### References

* [Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/)
    + [Standard Online - This is the corresponding free online course based on this material](https://statlearning.class.stanford.edu)
* [Elements of Statistical Learning](http://statweb.stanford.edu/~tibs/ElemStatLearn/)
* [PCA vs. Hierarchical clustering](http://www.rna-seqblog.com/a-comparison-between-pca-and-hierarchical-clustering/)
