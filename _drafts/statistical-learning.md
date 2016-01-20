---
layout: post
title:  "Statistical Learning"
tags: [R]
---

<div class="alert alert-dismissible alert-info">
<h4>Heads Up!</h4>
<p>The content of this page is largely my notes from the "Introduction to Statistical Learning (ISL)" Textbook.</p>
</div>

Statistical learning is a set of approaches for estimating some unknown function <span class="inlinecode">$f$</span>. Two main reasons why we are interested in estimating <span class="inlinecode">$f$</span>: 

1. Prediction: We want to know what the resultant Y is given some input X. In other words, we want <span class="inlinecode">$Y = f(X)$</span>. 
1. Inference: "We are often interested in understanding the way that Y is affected as X changes. In this situation we wish to estimate f, but our goal is not necessarily to make predictions for Y." (ISL)

Most statistical learning methods for estimating <span class="inlinecode">$f$</span> are characterized as either parametric or non-parametric.

## Parametric Methods

Make an assumption about the functional form or shape of <span class="inlinecode">$f$</span>. For example if we assume <span class="inlinecode">$Y = f(X)$</span> is linear, then the problem is estimation is simplified where we only have to estimate the coefficients and not the entire p-dimensional function <span class="inlinecode">$f(X)$</span>. Using this "model-based" approach reduces the problem of estimating <span class="inlinecode">$f$</span> down to estimating a set of parameters.

The potential disadvantage of a parametric approach is that the model we choose will usually not match the true unknown form of f.


## Non-parametric Methods

* "Non-parametric methods do not make explicit assumptions about the func- tional form of f ."
* "Such approaches can have a major advantage over parametric approaches: by avoiding the assumption of a particular functional form for f, they have the potential to accurately fit a wider range of possible shapes for f."
* "But non-parametric approaches do suffer from a major disadvantage: since they do not reduce the problem of estimating f to a small number of parameters, a very large number of observations (far more than is typically needed for a parametric approach) is required in order to obtain an accurate estimate for f."


