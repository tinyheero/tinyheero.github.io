---
layout: post
title:  "Why Bayesian Statistics?"
tags: [conda]
---

The term you will have undoubtly encountered the term Bayesian statistics at some point. It is What makes it so 
Having done my 

The crux of Bayesian statistics is centered around representing uncertainity about an unknown quantity. To illustrate this, imagine I had the following coin (this is a Canadian penny):

<div style="text-align:center">
  <img src="https://upload.wikimedia.org/wikipedia/en/f/f8/Canadian_Penny_-_Obverse.png"/>
</div>

If I flipped this coin, what is the probability that the coin lands on a head? You most likely guessed 0.5, which is a reasonable guess given your prior knowledge on how coins work. But what if I told you that I got this coin from a magic shop? You'll probably have some doubts that it is 0.5 now. It could be anything now. Maybe it's a trick coin and always gives you head (i.e. 1 probability) ? Or maybe it always gives you a tail (i.e. 0 probability)? Or maybe it is biased towards ahead (e.g. 0.75 probability). The point is there is some uncertainity in your estimation of this unknown quantity. 

Let's say I flipped this coin n times and it came back with r heads, and then I asked you this question:

<div>
$$P(\theta_{1} < \theta < \theta_{2} | n, r_{n})$$
</div>

Verbosely put, what's the probability that this coin gives a head (<span class="inlinecode">$\theta$</span>) is between <span class="inlinecode">$\theta_{1}$</span> and <span class="inlinecode">$\theta_{2}$</span>) given you have <span class="inlinecode">$n$</span> flips and <span class="inlinecode">$r_{n}$</span> heads. In classical/frequentist statistics, this question actually makes no sense. This is because in classical statistics, parameters (unknown quantities) are fixed and have no uncertainity in their value; They are either that value or they are not. But in a Bayesian world, we are never completely certain about any estimations. As such, all estimations of an unknown quantity (e.g. the probability that a coin gives a head) has uncertain.

# How do we represent these uncertainities?

Uncertainities are expressed as a [probability distributions]({% post_url 2016-03-17-prob-distr %}). For instance, imagine you had the following probability distribution:


The x-axis represents the plausible values that the probability of a head could take. The y-axis represents the "confidence" (this isn't entirely accurate in mathematical terms, but will suffice for this example) that the probability of a head takes this value. By expressing our uncertainity as a probability distribution, we get these additional benefits:

* The x value with the highest density peak represents the most likely value. 
* Credible intervals (CI) can be formed. For instance, [0.25 - 0.75] forms 90% CI that tells us we are 90% confident that the parameter is in this interval. This is quite different from a confidence interval from classical statistics, which is actually quite a counter-inituitive statistic (see my "[How do I Interpret a Confidence Interval? post"]({% post_url 2015-08-25-how-to-interpret-a-CI %}))
* sfsd
* There is a technique called Bayesian inferene that allows us to adapt the distribution in light of additional evidence.

# Where do these probability distributions come from?

While you could theoreticaly make your own probability distributions, 

# Conclusions

