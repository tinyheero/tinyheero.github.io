---
title: "Bayes' Rule"
date: "April 21st, 2016"
layout: post
output:
  html_document
tags: [R, stats, bayesian]
---

In a previous post on [Joint, Marginal, and Conditional Probabilities]({% post_url 2016-03-20-basic-prob %}), we learned about the 3 different types of probabilities. One famous probability rule that is built on these probabilities (specifically the conditional probability) is called "Bayes' Rule" which forms the basis of bayesian statistics. In this post, we will learn about how to derive this rule and its utility.

Here is an overview of what will be discussed in this post.

**Table of Contents**

<ul data-toc="body" data-toc-headings="h2,h3"></ul>



## Deriving Bayes' Rule

Bayes' rules can be derived by starting with the conditional probability of <span class="inlinecode">$P(X\ |\ Y)$</span> which is represented as:

<div>
$$P(X\ |\ Y) = \frac{P(X, Y)}{P(Y)}$$
</div>

By multiplying this with <span class="inlinecode">$P(Y)$</span>, we get:

<div>
$$P(X\ |\ Y)\ P(Y) = P(X, Y)$$
</div>

We can also perform this same algebraic manipulation for <span class="inlinecode">$P(Y\ |\ X)$</span>:

<div>
$$\begin{align}
P(Y\ |\ X) &= \frac{P(X, Y)}{P(X)} \\
P(Y\ |\ X)\ P(X) &= P(X, Y)
\end{align}$$
</div>

Notice how we now have two alternative representations of the joint probability <span class="inlinecode">$P(X, Y)$</span> which we can equate to each other:

<div>
$$\begin{align}
P(X\ |\ Y)\ P(Y) &= P(X, Y) \\
P(Y\ |\ X)\ P(X) &= P(X, Y) \\
P(X\ |\ Y)\ P(Y) &= P(Y\ |\ X)\ P(X) 
\end{align}$$
</div>

If we now divide by <span class="inlinecode">$P(Y)$</span>:

<div>
$$P(X\ |\ Y) = \frac{P(Y\ |\ X)\ P(X)}{P(Y)},\ if\ P(Y) \neq 0$$
</div>

This is defined as the Bayes' rule. Essentially what we have done is relate two different, but related conditional probability equations to each other. 

## From Prior Belief to Updated Belief (Posterior)

At first glance, Bayes' rule seems pretty simple and might not be obvious as to why it is so useful. I mean all we've done is just rewritten the conditional probability equation right? While that is true, the power comes from how you intepret the rule and define the variables. 

Let's say we have a hypothesis (<span class="inlinecode">$\theta$</span>) and some data (Y) to support or oppose this hypothesis. If we make our X (from above) equal to <span class="inlinecode">$\theta$</span>, then our Bayes' rule becomes:

<div>
$$P(\theta\ |\ Y) = \frac{P(Y\ |\ \theta)\ P(\theta)}{P(Y)}$$
</div>

So what does this mean? Well <span class="inlinecode">$P(\theta)$</span> represents our "prior" belief of what the hypothesis is before we see any data. This prior is informed by our "expert" opinion on the hypothesis and thus is subjective. But the beauty of this rule, is that it allows us to relate this prior, <span class="inlinecode">$P(\theta)$</span>, to an "updated belief" of the hypothesis <span class="inlinecode">$P(\theta\ |\ Y)$</span> once we have some data to consider. In Bayesian terms, this "updated belief" is called the posterior.

For the rest of this post, I will be using <span class="inlinecode">$P(\theta)$</span> to represent the hypothesis in the Bayes' rule. Now, let's see this rule in action.

### Using Bayes' Rule Example #1: Playing Cards

<div class="alert alert-dismissible alert-info">
<h4>Reference</h4>
This example is shamelessly borrowed from <a href="https://brilliant.org/wiki/bayes-theorem/">Brilliant - Bayes' Theorem and Conditional Probability</a>.
</div>

Say we are playing cards and we have a prior probability that there is a <span class="inlinecode">$\frac{1}{13}$</span> chance of getting a King card. How do we know this? Well our expert knowledge tells us that there are 52 cards in a deck with a total of 4 suits (hearts, diamonds, clubs, and jacks). Each suit has its own Jack, Queen, King (i.e. face card), and so there must be 4 Kings in total. Therefore, <span class="inlinecode">$\frac{4}{52} = \frac{1}{13}$</span>. 

But now say, we also have the data that the card we have in hand is a face card. What then is the probability of getting a King now? What we really are asking is what is our updated belief (posterior), <span class="inlinecode">$P(H\ |\ E)$</span>, in getting a King in light of this new information. We can use Bayes' Rule to help us solve this. Let's break down the individual components of Bayes' rule here:

* <span class="inlinecode">$P(\theta = King) = \frac{1}{13}$</span>.
* <span class="inlinecode">$P(Y = Face\ card)$</span> = As there are 3 face cards per suit and there are 4 suits, then this is <span class="inlinecode">$\frac{12}{52} = \frac{3}{13}$</span>
* <span class="inlinecode">$P(Y = Face\ card\ |\ \theta = King)$</span> = Since every single King card is a face card, this probability has to be 1.

Now we just fill this in into the Bayes' Equation:

<div>
$$\begin{align}
P(\theta = King\ |\ Y = Face\ card) &= \frac{1 * \frac{1}{13}}{\frac{3}{13}} \\
P(\theta = King\ |\ Y = Face\ card) &= \frac{1}{3}
\end{align}$$
</div>

Basically we started with a prior belief, <span class="inlinecode">$P(\theta = King) = \frac{1}{13}$</span>, but with new information regarding the card being a face card we are more confident that the card is a King now, <span class="inlinecode">$P(\theta = King\ |\ Y = Face\ card) = \frac{1}{3}$</span>.

### Using Bayes' Rule Example #2: Disease Testing

As another example, we will use disease testing to illustrate Bayes' rule. Say we know that in the general populance, the chances that a person will have a certain disease is 0.001. We also know that the test has a true positive rate of 95% chance and a false positive rate of 1%. If a person gets the test and it comes back as positive, what are the chances that the person actually has the disease. Let's first setup our variables here:

* <span class="inlinecode">$P(\theta = disease)$</span>: This is our prior belief on the probability of having the disease. This is 0.001.
* <span class="inlinecode">$P(Y = positive\ |\ \theta = disease)$</span>: This is the probability of the test being positive given the person has the disease. In other words, the true positive rate which is 0.95.
* <span class="inlinecode">$P(Y = positive)$</span>: This is the probability of the test being positive irrespective of whether the person has the disease or not. So this would include all true positive events and false positive events. So it would be summation of the two joint probabilities: 

    <div>
    $$\begin{align}
    P(Y = Positive) &= P(Y = Positive, \theta = Disease) + P(Y = Positive, \theta \neq Disease) \\
    P(Y = Positive) &= 0.95 * 0.001 + 0.01 * (1-0.01) \\
    P(Y = Positive) &= 0.01094
    \end{align}$$
    </div>

So we can now use Bayes' rule:

<div>
$$\begin{align}
P(\theta = Disease\ |\ Y = Positive) &= \frac{P(Y = Positive\ |\ \theta = Disease)\ P(\theta = Disease)}{P(Y = Positive)} \\
P(\theta = Disease\ |\ Y = Positive) &= \frac{0.95 * 0.001}{0.01094} \\
P(\theta = Disease\ |\ Y = Positive) &= 0.087
\end{align}$$
</div>

Notice how despite the fact that the true positive rate of the test is 0.95, the probability that the person has the disease is actually only 0.087. This is because our prior that a given person has the disease, 0.001, greatly influences this.

## Revisiting the Bayes' Rule

So far, we've defined the the prior probability, <span class="inlinecode">$P(\theta)$</span>, and posterior probability, <span class="inlinecode">$P(\theta\ |\ Y)$</span>, but the other components of the Bayes' rule have names themselves that you should be aware of. 

* <span class="inlinecode">$P(Y\ |\ \theta)$</span>: Likelihood. This is the probability of the data being generated given the hypothesis.
* <span class="inlinecode">$P(Y)$</span>: Marginal likelihood or evidence. This is just the overall probability of the data after we marginalize out all the possible hypothesis.

If we look at the Bayes' rule again:

<div>
$$P(\theta\ |\ Y) = \frac{P(Y\ |\ \theta)\ P(\theta)}{P(Y)}$$
</div>

We can see that the posterior probability and likelihood are almost the same except for the fact the variables have been inverted. It's important to note that these two components, in general, are NOT equivalent to each other. For instance, consider the following likelihood:

<div>
$$P(Y = Sidewalk\ is\ wet\ |\ \theta = Rained\ last\ night)$$
</div>

The probability that the sidewalk is wet given that it rained last night is pretty high. Now consider the posterior:

<div>
$$P(\theta = Rained\ last\ night\ |\ Y = Sidewalk\ is\ wet)$$
</div>

Intuitively, you should be thinking this isn't as high because there are many reasons that could explain why the sidewalk is wet (e.g. someone spilled a drink, someone was watering the lawn).

## Summary

Here in this post we've shown how to derive the Bayes' rule from the conditional probability equation. The power in the rule comes from how we intepret the variables specifically when we start thinking about it in terms of hypotheses and data to support the hypotheses. We can extend this application of Bayes' rule to Bayesian data analysis where the hypotheses become the parameters of our model and the data is our observed data which we try to explain using the parameters of our model. This is a fairly advanced topic which we will save for another post!

## References

* [Brilliant Bayes' Theorem and Conditional Probability](https://brilliant.org/wiki/bayes-theorem/)
* [What is the difference between Bayes Theorem and conditional probability and how do I know when to apply them?](https://www.quora.com/What-is-the-difference-between-Bayes-Theorem-and-conditional-probability-and-how-do-I-know-when-to-apply-them)
* [Count Bayesie - Bayes' Theorem with Lego](https://www.countbayesie.com/blog/2015/2/18/bayes-theorem-with-lego)
