---
layout: post
title:  "Do You Understand Random Variables?"
tags: [stats, randvar]
---

A random variable can be a confusing concept because it is not like a traditional variable that you may have been exposed to before. I will be honest and say that I never really understood them until I started doing some more digging into them. This post hopes to clarify exactly what a random variable. Here is an overview of what will be discussed in this post.

**Table of Contents**

<ul data-toc="body" data-toc-headings="h2,h3"></ul>

## What Exactly is a Random Variable?

A random variable is actually a function that map the outcomes of a random process to a numeric value. For instance, let's say we have the random process of flipping a coin and we use the random variable X (random variables are typically denoted with capital letters) to represent the outcomes of the coin flip. For example, here is one possible random variable:

* X = 1 if the flip of the coin is a head
* X = 0 if the flip of the coin is a tail

There isn't anything special about the numeric values I chose here. I could have done the following:

* X = 500 if the flip of the coin is a head
* X = 25 if the flip of the coin is a tail

And this would still be a random variable. But the numeric values in the first random variable are more intuitive of course. 

As another example, let's say we have a random process of flipping a coin 5 times. We can assign a random variable Y (just to show there is nothing special about using X) that maps the number of heads we get from the 5 coin flips to numeric values:

* Y = 0 if no heads
* Y = 1 if 1 head
* Y = 2 if 2 heads
* Y = 3 if 3 heads
* Y = 4 if 4 heads
* Y = 5 if 5 heads

<div class="alert alert-dismissible alert-info">
<h4>Important</h4>
The flipping of a coin is a random process because each flip of the coin can produce either a heads or a tail and is essentially a random event. If we had some weird biased coin that had both sides being head, then the flipping of this coin would be a deterministic process since we would always get a head every flip.
</div>

## Why Random Variables?

Now that we have defined what a random variable is, the next logical question is why are we even doing this? The major reason for declaring random variables is because it provides us a way to easily use mathematical notations. If go back to the random process of flipping 5 coins and using the random variable Y to map the number of heads we get, then we can easily represent questions about the process like this:

1. P(Y = 2)
1. P(Y < 4)
1. P(Y > 1)

These 3 questions equivalent to:

1. What is the probability of getting exactly 2 heads?
1. What is the probability of getting less than 4 heads?
1. What is the probability of getting more than 1 head? 

If we didn't do it this way, the alternative would have been something like this:

* P(The probability of getting exactly 2 heads when we flip a coin 5 times)
* P(The probability of getting < 4 heads when we flip a coin 5 times)
* P(The probability of getting > 1 head when we flip a coin 5 times)

## Traditional vs. Random Variable

* traditional variables are typically represented by lowercase letters (e.g. x, y)
* traditional variables can be solved for (e.g. x + 10 = 15); we don't solve for random variables
* traditional variables can be used to observed how a value changes as function of the variable (e.g. y = x + 2)
* random variables can take on many different values, and we are often interested in knowing what the probability of a random variable taking on a specific value.


## Summary

## References

* [Random variables - Probability and Statistics - Khan Academy](https://youtu.be/3v9w79NhsfI)
