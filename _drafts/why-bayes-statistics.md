---
layout: post
title:  "Why Bayesian Statistics?"
tags: [conda]
---

The term you will have undoubtly encountered the term Bayesian statistics at some point. It is What makes it so 
Having done my 

The crux of Bayesian statistics is centered around representing uncertainity about an unknown quantity. To illustrate this, imagine I had the following coin (this is a Canadian penny):

![Canadian penny](https://upload.wikimedia.org/wikipedia/en/f/f8/Canadian_Penny_-_Obverse.png)

If I flipped this coin, what is the probability that the coin lands on a head? You most likely guessed 0.5, which is a reasonable guess. But what if I told you that I got this coin from a magic shop? You'll probably have some doubts that it is 0.5 now. It could be anything now. Maybe it's a trick coin and always gives you head (i.e. 1 probability) ? Or maybe it always gives you a tail (i.e. 0 probability)? Or maybe it is biased towards ahead (e.g. 0.75 probability). The point is there is some uncertainity in your estimation of this unknown quantity. 

Let's say I flipped this coin 100 times (n) and it came back with 82 heads (r), and then I asked you this question:

<div>
$$P(\theta_{1} < \theta < \theta_{2} | n, r_{n})$$
</div>

Verbosely put, what's the probability that this coin gives a head (<span class="inlinecode">$\theta$</span>) is between <span class="inlinecode">$\theta_{1}$</span> and <span class="inlinecode">$\theta_{2}$</span>) given you have n flips and <span class="inlinecode">r$</span> heads. In classical/frequentist statistics, this question actually makes no sense. This is because in classical statistics, parameters (unknown quantities) are fixed and have no uncertainity in their value; They are either that value or they are not. But in a Bayesian world, we are never completely certain about 



The premise of

* Not a new field

