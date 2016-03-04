---
layout: post
title:  "How do I Interpret a Confidence Interval?"
date: 2015-08-25
tags: [stats]
---

A confidence interval is a range that indicates the uncertainity of a population parameter estimate. So what does this actually mean? Say someone said the following statement: 

> Our 90% confidence interval (CI) shows that the frequency of *EZH2* mutations in the lymphoma patient population is between 20% and 30%.

The correct way to interpret this statement is:

> There is a 90% chance that this **particular** confidence interval of [20% - 30%] contains the true population mutation frequency of *EZH2* in lymphoma patients.

This is slightly different from the following **incorrect** interpretation:

> There is a 90% chance that the true population mutation frequency of *EZH2* lies somewhere between 20% and 30%. 

Why is this an incorrect interpretation? The reason is because of how we define the "population mean". Generally speaking, the central purpose of statistics is to learn a certain trait about a population.  In the ideal world, we would measure this trait in every single individual in the population. For instance, ideally you would go out and search for every single lymphoma patient and find out if they have an *EZH2* mutation.

This is generally an impossible task due to practical reasons (e.g. time, cost).  Therefore, what is done instead is sampling a subset of the population (defined as a "sample") of some n size. Then we try to draw inferences about the population based on this sample. The hope is that this sample can estimate the statistics of the entire population.

Since there is only one population, the population mean is actually just a single value that doesn't change no matter how many times you sample from it. **So it makes no sense to assign some population parameter a probability of lying in some range; It either does or doesn't.**

Since the CI can't be applied to a population parameter, this means:

> A CI can only be generated based on some sampling of data from the population

As we use the sample data to estimate some population parameter, we can also generate and use a CI to show the uncertainity of this estimate. **Importantly, CIs are an observed interval. This means that it is calculated based on the observed sample data and can change between different samples.** Therefore if we were to perform another sampling, the generated CI for this sample will be different than the previous one. Moreover, if we were to perform 100 different samplings, then some of these CIs will contain the population mean and some won't. In fact if we collect all the 90% CI that we generate, it turns out 90% of them will contain the population mean.

Ultimately, you want your CI to be a small range which indicates that you are confident that your sampling data contains the population mean and likely reflects the population. 

# References

* [Interpreting Confidence Intervals an interactive visualization](http://rpsychologist.com/d3/CI/)
