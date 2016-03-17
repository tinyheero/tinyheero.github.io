---
layout: post
title:  "Do You Understand Random Variables?"
tags: [stats, randvar]
---

A random variable can be a confusing concept because it is not like a **traditional variable** that you may have been exposed to before. I will be honest and say that I never really understood them until I started doing some more digging into them. This post hopes to clarify exactly what a random variable. Here is an overview of what will be discussed in this post.

**Table of Contents**

<ul data-toc="body" data-toc-headings="h2,h3"></ul>

## What Exactly is a Random Variable?

A random variable is actually a function that map the outcomes of a random process to a numeric value. For instance, let's say we have the random process of flipping a coin where the coin can only have one of two outcomes - head or a tail. We could use the random variable X (random variables are typically denoted with capital letters) to represent the outcomes of a coin flip. Here is one possible random variable:

* X = 1 if the flip of the coin is a head
* X = 0 if the flip of the coin is a tail

There isn't anything special about the numeric values I chose here. I could have done the following:

* X = 500 if the flip of the coin is a head
* X = 25 if the flip of the coin is a tail

And this would still be a random variable. But the numeric values in the first random variable are more intuitive of course. As another example, let's say we have a random process of flipping a coin 5 times. We can assign a random variable X that maps the number of heads we get from the 5 coin flips to numeric values:

* X = 0 if no heads
* X = 1 if 1 head
* X = 2 if 2 heads
* X = 3 if 3 heads
* X = 4 if 4 heads
* X = 5 if 5 heads

<div class="alert alert-dismissible alert-info">
<h4>Why is it a Random Process?</h4>
The flipping of a coin is a random process because each flip of the coin can produce either a heads or a tail and is essentially a random event. If we had some weird biased coin that had both sides being head, then the flipping of this coin would be a deterministic process since we would always get a head every flip.
</div>

## Why Random Variables?

Now that we have defined what a random variable is, the next logical question is why are we even doing this? The major reason for declaring random variables is because it provides us a way to ask questions about the random process in a concise mathematical way. If we go back to the random process of flipping 5 coins and use the random variable X to map the number of heads we get, then we can easily represent questions about the process like this:

1. <span class="inlinecode">$P(X = 2)$</span>
1. <span class="inlinecode">$P(X < 4)$</span>
1. <span class="inlinecode">$P(X > 1)$</span>

These 3 questions equate to:

1. What is the probability of getting exactly 2 heads?
1. What is the probability of getting less than 4 heads?
1. What is the probability of getting more than 1 head?

If we didn't do it this way, the alternative to represent these questions could have been something like this:

* P(Probability of getting exactly 2 heads when we flip a coin 5 times)
* P(Probability of getting < 4 heads when we flip a coin 5 times)
* P(Probability of getting > 1 head when we flip a coin 5 times)

## Discrete vs. Continuous Random Variables

The other important thing that is worth mentioning is distinguishing between a discrete and a continuous random variable. In the examples mentioned above, the numeric values that the random variable mapped to were all discrete values (0, 1, 2, 3, 4, 5). This makes all the above random variables discrete random variables. This is contrasted to a continuous random variable that maps outcomes to continuous numeric values.

## Summary

Hopefully this post sheds a bit of light on what random variables are and why we use them. In some follow-up posts (e.g. probability distributions), the utility of random variables will hopefully become even more clear. So stay tuned!

## References

* [Random variables - Probability and Statistics - Khan Academy](https://youtu.be/3v9w79NhsfI)
* [What is the difference between discrete data and continuous data?](http://stats.stackexchange.com/questions/206/what-is-the-difference-between-discrete-data-and-continuous-data)
