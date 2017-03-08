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

## Probability and Statistics

* There are 2 major branches of statistics:
    1. Description statistics: Summarizing and presenting key characteristics about some data.
    1. Inferential statistics: Inferring characteristics about a population from a small sample of it. In this branch, you typically start with a hypothesis and then test if your sample follows the hypothesis.
* Probability and statistics deal with questions involving populations and samples, but do so in an "inverse manner" to one another.
    + In a probability problem, properties of a population under study are known (e.g. specified distribution of a population), and questions regarding a sample taken from the population are posed and answered.
    + In a statistics problem, characteristics of the sample are known and properties of the population are inferred.
* We study probability first before statistics because we need to understand the uncertainity associated with taking a sample from a population. Then we are start to understand what a particular sample can tell us about a population.

1. Descriptional Statistics
    * Correlation analysis
        + Parametric
        + Non-Parametric (Kendall and Spearman)
1. [Random Variables]({% post_url 2016-02-26-random-variables %})
1. Probabilities
    * [Joint, Marginal, and Conditional Probabilites]({% post_url 2016-03-20-basic-prob %})
    * [Bayes' Rule]({% post_url 2016-04-21-bayes-rule %})
1. [Probability Distributions]({% post_url 2016-03-17-prob-distr %})
   * Continuous
        + Gaussian (Normal) Distribution
        + Dirichlet Distribution
        + Exponential Distribution
        + Chi-Square Distribution
        + Weibull Distribution
            - Exponential Distribution
        + Beta Distribution
    * Discrete
        + Bernoulli Distribution
        + Binomial Distribution (Sum of n independent Bernoulli trails)
        + Multinomial Distribution
        + Multivariate Hypergeometric Distribution
            - If sampling is done without replacement.
        + Poission Distribution
        + Negative Binomial Distribution
        + Beta-binomial distribution
1. Hypothesis Testing
1. Other
    * [Confidence Intervals]({% post_url 2015-08-25-how-to-interpret-a-CI %})
    * Power Analysis
1. Survival Analysis
    * [The Basics of Survival Analysis]({% post_url 2016-05-12-survival-analysis %})
    * Kaplan-Meier Curves and the Log-rank Test
    * Cox Regression
    * Survival Analysis Study Design Considerations

### References

* [Kinds of Statistics](http://be.wvu.edu/divmim/mgmt/blakely/homepage/Mktg325/Kinds%20of%20Statistics%20and%20Types%20of%20Data.pdf): Good introductory article on what the two main branches of statistics are.
* [Introduction to Statistical Thought](http://people.math.umass.edu/~lavine/Book/book.html)

## Bayesian Statistics

1. [Bayesian Inference 101]({% post_url 2017-03-08-how-to-bayesian-infer-101 %})
1. Classical Frequentist vs. Bayesian 
1. Markov Chain Monte Carlo (MCMC) processes
    + Metropolis algorithm
    + Gibbs Sampling (Special case of Metropolis)
    + BUGS, JAGS, STAN

### References

* [Bayesian Statistics explained to Beginners in Simple English](http://www.analyticsvidhya.com/blog/2016/06/bayesian-statistics-beginners-simple-english/)
* [Doing Bayesian Data Analysis - A Tutorial with R, JAGS, and Stan](https://sites.google.com/site/doingbayesiandataanalysis/)

## Machine Learning / Statistical Learning

![Machine Learning Algorithm Cheat Sheet]({{ site.url }}/assets/microsoft-machine-learning-algorithm-cheat-sheet-v2.png)

1. Supervised Learning
    * Regression (predict continuous values)
        + Linear Regression
        + Artificial Neural Networks (ANN)
            - Can also be used for classification.
    * Classification - Predict discrete (categorical) values (i.e. class a data point belongs to)
        + Logistic Regression
        + Linear Discriminant Analysis (LDA)
            - Naive Bayes Classifier
        + Support Vector Machines (SVM)
        + Random Forest
        + ANN
            - Can also be used for regression.
1. Unsupervised Learning
    * Cluster Analysis
        + Principle Component Analysis (PCA)
        + t-SNE
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
    * Receiver operating characteristic (ROC) curve
    * Mathews correlation coefficient (MCC)

### References

* [The one machine learning concept you need to know](http://www.sharpsightlabs.com/one-concept-machine-learning/)
* [Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/)
    + [Standard Online - This is the corresponding free online course based on this material](https://statlearning.class.stanford.edu)
* [Elements of Statistical Learning](http://statweb.stanford.edu/~tibs/ElemStatLearn/)
* [PCA vs. Hierarchical clustering](http://www.rna-seqblog.com/a-comparison-between-pca-and-hierarchical-clustering/)
* [Some Things Every Biologist Should Know About Machine Learning](http://master.bioconductor.org/help/course-materials/2003/Milan/Lectures/MachineLearning.pdf)
