---
title: "How to Do Bayesian Inference 101"
date: "March 8th, 2017"
layout: post
output:
  html_document
tags: [R, stats, bayesian]
---



Towards the end of the post [Bayes' Rule]({% post_url 2016-04-21-bayes-rule %}), 
I eluded a bit to how Bayes' rule becomes extremely powerful in Bayesian 
inference. The link happens when we start to interpret the variables of 
Bayes' rule as parameters (<span class="inlinecode">$\theta$</span>) of a model 
and observed data (<span class="inlinecode">$D$</span>):

<div>
$$\begin{align}
P(X\ |\ Y) &= \frac{P(Y\ |\ X)\ P(X)}{P(Y)} \\
P(\theta\ |\ D) &= \frac{P(D\ |\ \theta)\ P(\theta)}{P(D)}
\end{align}$$
</div>

In this post, we will learn exactly how Bayes' rule is used in Bayesian 
inference by going through a specific example of coin tossing. A lot of this 
post and examples are inspired by [John K. Kruschke's "Doing Bayesian Data Analysis"](https://sites.google.com/site/doingbayesiandataanalysis/). An incredible book that I have been using for my entry into 
world of Bayesian statistics. I would highly recommend anyone interested in 
Bayesian statistics to get this book.

<div class="alert alert-dismissible alert-warning">
<h4>Important!</h4>
Please ensure that you are familiar with Bayes' rule before continuing as this 
post will not make sense with a thorough understanding of it. If you are not 
familiar, please review my previous post on 
<a href="/2016/04/21/bayes-rule.html">Bayes' Rule</a> for details.
</div>

Here is an overview of what will be discussed in this post.

**Table of Contents**

<ul data-toc="body" data-toc-headings="h2,h3"></ul>

## The Coin Flipping Example

Consider the scenario where you found a coin on the side of a street that had an 
odd looking geometry, unlike anything you have ever seen before. It still has 
two sides (heads and a tail), and you start to wonder:

> What is probability of getting a head on a given flip with this coin?

Given your knowledge of how a typical coin is, your prior guess is that is 
should be probably 0.5. But given the strange looking geometry, you also 
entertain the idea that it could be something like 0.4 or 0.6, but think these 
values are less probable than 0.5. You then proceed to flip the coin 100 times 
(because you are really bored and have time on your hands) and you notice that 
you get 83 heads. Given this observed data now, what is your guess at the 
probability of getting a head on a given flip?

If we think back to our examples from the Bayes' Rule post, we can see that this 
particular example is not that dissimilar:

* We have a prior belief of what the probability of getting a heads is (0.5).
* We have some observed data, which is 83 heads out of 100 coin tosses.
* We need to update our belief of this probability now that we have some 
    observed data.

There is however one key difference in this particular example compared to our 
previous examples. **Our prior is not a single fixed value, but rather a series 
of different possible values. It could be 0.5 or 0.4 or 0.6....in fact it could 
be any value between 0 and 1!** Moreover, the possible values are not all 
equally likely. For instance, we have a strong belief that it could be 0.5 
(because of what we know about coins in general), and while 0.4 and 0.6 or any 
other value is possible we still think 0.5 is more probable. Visually, we could 
have something like:


{% highlight r %}
library("dplyr")

#' Generates a "Triangle" Prior Probability Distribution
#'
#' @param vals Sample space of all possible parameter values.
#' @return 2 column dataframe containing the parameter and its corresponding
#'   prior probability.
get_prior_distr <- function(vals) {
  vals_pmin <- pmin(vals, 1 - vals)

  # Normalize the prior so that they sum to 1.
  tibble::tibble(
    theta = vals,
    prior = vals_pmin / sum(vals_pmin)
  )
}

# Define the Space of all theta values
theta_vals <- seq(0, 1, 0.1)

theta_prior_distr_df <- get_prior_distr(theta_vals)

#' Plots the Prior Probability Distribution
#'
#' @param prior_distr_df Prior probability distribution dataframe from 
#'   get_prior_distr().
#' @param plot_x_labels Plot the parameter values on the x-axes that are taken
#'  from the input data.
#' @return ggplot of the prior probability distribution
plot_prior_distr <- function(prior_distr_df, plot_x_labels = TRUE) {

  theta_prior_p <- 
    prior_distr_df %>%
    ggplot(aes(x = theta, y = prior)) +
    geom_point() +
    geom_segment(aes(x = theta, xend = theta, y = prior, yend = 0)) +
    xlab(expression(theta)) +
    ylab(expression(paste("P(", theta, ")"))) +
    ggtitle("Prior Distribution") 

  if (plot_x_labels) {
    theta_vals <- prior_distr_df[["theta"]]

    theta_prior_p <- 
      theta_prior_p + 
      scale_x_continuous(breaks = c(theta_vals), labels = theta_vals)
  }

  return(theta_prior_p)
}

plot_prior_distr(theta_prior_distr_df)
{% endhighlight %}

![plot of chunk prior-distr]({{ site.url }}/assets/how-to-bayesian-infer-101/prior-distr-1.svg)

Here we have 10 different possibilities of theta and their associated probabilities. In fact, what we have just described is a probability distribution that was defined in the [Bayes' Rule]({% post_url 2016-04-21-bayes-rule %})! So if we think of our prior as a random variable, <span class="inlinecode">$\theta$</span>, then what we actually have is a prior probability distribution. What implications does this have? Well this ends up affecting how we measure the likelihood because before our likelihood was based on a single prior value. Instead, our likelihood essentially becomes a function of a series of candidate <span class="inlinecode">$\theta$</span> values. In other words, the probability of seeing the observed data is different depending on what the value of <span class="inlinecode">$\theta$</span> is. 

## Steps of Bayesian Inference 

Now that we have given this simple example of a situation, we can walk through an example of how we can answer the aforementioned question (i.e. What is probability of getting a head on a given flip with this coin?) in a Bayesian way. To do any Bayesian inference, we follow a 4 step process:

1. Identify the observed data you are working with.
1. Construct a probabilistic model to represent the data (likelihood).
1. Specify prior distributions over the parameters of your probabilistic model (prior).
1. Collect data and apply Bayes' rule to re-allocate credibility across the possible parameter values (posterior).

Let us walk through these steps one by one in the context of this example.

### Step 1: Identify the Observed Data 

In this example, we have a coin that when flipped gives us one of two possible outcomes: heads or tails. We can use the random variable, Y, to denote the outcome and assign it to 1 if it is heads and 0 if it is tails. These values are not ordinal, and merely represent a simplified way to represent heads or tails.

### Step 2: Construct a Probabilistic Model to Represent the Data

Once we have identified the observed data, our next step is to come up with a probabilistic model along with meaningful parameters that can properly describe this data. The idea here is that the model is supposed to represent some process that generated this data (i.e. generative process). For this particular example, we can represent the probability of getting a head as <span class="inlinecode">$\theta$</span>. Formally we can describe this as:

<div>
$$P(Y = 1\ |\ \theta) = \theta$$
</div>

It then follows that the probability of getting a tail is:

<div>
$$P(Y = 0\ |\ \theta) = 1 - \theta$$
</div>

These two expressions can be combined into a single expression:

<div>
$$P(Y = y\ |\ \theta) = \theta^{y}(1 - \theta)^{1 - y}$$
</div>

Notice how when <span class="inlinecode">$Y = 1$</span>, this expression becomes <span class="inlinecode">$P(Y = 1 |\ \theta) = \theta$</span>. And when <span class="inlinecode">$Y = 0$</span>, this expression becomes <span class="inlinecode">$P(Y = 0\ |\ \theta) = 1 - \theta$</span>.

This particular expression is actually the probability mass function (pmf) of the [Bernoulli distribution](https://en.wikipedia.org/wiki/Bernoulli_distribution). The Bernoulli distribution is used when we are describing a single trial (e.g. coin flip) with two possible outcomes (e.g. heads or tails). We can extend this to the situation where we have multiple independent trials very easily. First, we let <span class="inlinecode">$y_{i}$</span> represent the outcome of the i<sup>th</sup> coin flip and the set of all outcomes to be <span class="inlinecode">$D$</span>. Since each coin toss is an independent trial (i.e. the outcome of a coin toss is independent of the previous coin toss outcomes), the probability of <span class="inlinecode">D</span> is then multiplicative product of the individual outcomes:

<div>
$$\begin{align}
P(D\ |\ \theta) &= \prod_{i}{P(y_{i}\ |\ \theta)} \\
P(D\ |\ \theta) & = \theta^{\#heads}(1 - \theta)^{\#tails}
\end{align}$$
</div>

This expression is actually the probability mass function (pmf) for the [binomial distribution](https://en.wikipedia.org/wiki/Binomial_distribution). As we are dealing with multiple coin flips here, the binomial distribution serves as the perfect model for this data. As such, we can use the pmf of the binomial distribution to be our **likelihood function for Bayes' rule**.

<div class="alert alert-dismissible alert-warning">
<h4>Cool Fact</h4>
The Bernoulli distribution is just a special case of the binomial distribution when there is only one trial.
</div>

### Step 3: Specify Prior Distributions 

Now that we have specified a probabilistic model to represent the coin toss, we have to consider the parameters of this model. The model is comprised of a single binomial distribution pmf which is parameterized by a single <span class="inlinecode">$\theta$</span>. So we need to define some possible values that <span class="inlinecode">$\theta$</span> can take.

For this example, we will restrict our parameter values to discrete values of <span class="inlinecode">$\theta = 0, \theta = 0.1, ..., \theta = 1.0$</span>. And we believe that certain parameters are more likely. For instance, the probability of the coin being "fair" <span class="inlinecode">$\theta = 0.5$</span> is more likely than a coin being unfair. So we could define a probability distribution as follows:


{% highlight r %}
plot_prior_distr(theta_prior_distr_df)
{% endhighlight %}

![plot of chunk prior-distr-triangle]({{ site.url }}/assets/how-to-bayesian-infer-101/prior-distr-triangle-1.svg)

This is called a "prior distribution" and defines the possibilities of <span class="inlinecode">$\theta$</span> and their associated probabilities.

### Step 4: Collect Data and Application of Bayes' Rule

The final step is that we use the observed data and apply Bayes' rule to generate the posterior distribution. Let us start with the simplest scenario which is a single coin toss which has the outcome of a head. We now use Bayes' rule to generate a posterior for each <span class="inlinecode">$\theta$</span> value:


{% highlight r %}
#' Get the Likelihood Probability Distribution
#'
#' Generates a likelihood probability distribution dataframe
#'
#' @param theta_vals Vector of theta values for the binomial distribution.
#' @param num_heads Number of heads.
#' @param num_tails Number of tails.
#' @return Dataframe of the likelihood probability distribution.
get_likelihood_df <- function(theta_vals, num_heads, num_tails) {
  likelihood.vals <- dbinom(num_heads, num_heads + num_tails, theta_vals)
  likelihood_df <- 
    tibble::tibble(
      theta = theta_vals,
      likelihood = likelihood.vals
    )

  return(likelihood_df)
}

#' Get Posterior Probability Distribution
#' 
#' Generate a posterior probability distribution dataframe.
#'
#' @param likelihood_df Likelihood distribution dataframe from 
#'   get_likelihood_df().
#' @param theta_prior_distr_df Prior distribution dataframe from 
#'   get_prior_distr().
#' @return Dataframe with 4 columns:
#'   * theta: Theta value.
#'   * likelihood: Binomial likelihood of the observed data with the specific 
#'       theta.
#'   * prior: Prior of the theta value.
#'   * post_prob: Pposterior probability
get_posterior_df <- function(likelihood_df, prior_distr_df) {

  likelihood_prior_df <- 
    dplyr::left_join(likelihood_df, prior_distr_df, by = "theta")

  marg_likelihood <- 
    likelihood_prior_df %>%
    dplyr::mutate(
      likelihood_theta = .data[["likelihood"]] * .data[["prior"]]
    ) %>%
    dplyr::pull("likelihood_theta") %>%
    sum()

  posterior_df <- 
    dplyr::mutate(
      likelihood_prior_df, 
      post_prob = (likelihood * prior) / marg_likelihood
    )

  return(posterior_df)
}

#' Plots Likelihood Probability Distribution
plot_likelihood_prob_distr <- function(likelihood_df) {
  likelihood_df %>%
  ggplot(aes(x = theta, y = likelihood)) +
  geom_point() +
  geom_segment(aes(x = theta, xend = theta, y = likelihood, yend = 0)) +
  xlab(expression(theta)) +
  ylab(expression(paste("P(D|", theta, ")"))) +
  ggtitle("Likelihood Distribution")
}

#' Plots Posterior Probability Distribution
plot_posterior_prob_distr <- function(posterior_df, theta_vals) {
  posterior_df %>%
  ggplot(aes(x = theta, y = post_prob)) +
  geom_point() +
  geom_segment(aes(x = theta, xend = theta, y = post_prob, yend = 0)) +
  xlab(expression(theta)) +
  ylab(expression(paste("P(", theta, "|D)"))) +
  ggtitle("Posterior Distribution")
}

likelihood_df <- get_likelihood_df(theta_vals, 1, 0)
posterior_df <- get_posterior_df(likelihood_df, theta_prior_distr_df)
{% endhighlight %}


{% highlight r %}
plot_grid(
  plot_prior_distr(theta_prior_distr_df),
  plot_likelihood_prob_distr(likelihood_df),
  plot_posterior_prob_distr(posterior_df, theta_vals),
  nrow = 3
)
{% endhighlight %}

![plot of chunk posterior-prob-distr]({{ site.url }}/assets/how-to-bayesian-infer-101/posterior-prob-distr-1.svg)

Notice how the posterior probability distribution is different from the prior 
distribution. Specifically, the probability mass has shifted to higher 
<span class="inlinecode">$\theta$</span> values. This makes sense since that the 
outcome was head suggesting that the coin favours heads. Hence, 
<span class="inlinecode">$\theta$</span> values supporting a bias towards head 
outcomes will be favoured and thus we see the mass of the posterior distribution 
shifting towards that direction.

Importantly to note is that despite all data supporting heads, high 
<span class="inlinecode">$\theta$</span> values in the posterior distribution 
(e.g. 0.9 and 1) do not have a lot of probability. This makes sense since a 
single data point should not skew our prior belief of the probability of a head. 
If we had more data points, we might change our beliefs. This intuition makes 
sense and illustrates a key concept in Bayesian inference:

<div class="alert alert-dismissible alert-warning">
<h4>Key Concept</h4>
The posterior is a compromise between the prior and likelihood. Specifically:
<ul>
<li>When there are less data points, the distribution is skewed towards the prior distribution.</li>
<li>When there are more data points, the distribution is skewed towards the likelihood distribution.</li>
</ul>
</div>

This compromise is best demonstrated with more data. Let us see what happens 
when we have 20 coin toss and with a total of 15 heads.


{% highlight r %}
likelihood_df <- get_likelihood_df(theta_vals, 15, 5)
posterior_df <- get_posterior_df(likelihood_df, theta_prior_distr_df)

plot_grid(
  plot_prior_distr(theta_prior_distr_df), 
  plot_likelihood_prob_distr(likelihood_df) +
    labs(subtitle = "15 Heads with 20 Coin Tosses"),
  plot_posterior_prob_distr(posterior_df, theta_vals) +
    labs(subtitle = "15 Heads with 20 Coin Tosses"),
  nrow = 3,
  align = "v"
)
{% endhighlight %}

![plot of chunk posterior-prob-distr-sample-size]({{ site.url }}/assets/how-to-bayesian-infer-101/posterior-prob-distr-sample-size-1.svg)

Notice in this situation how the mass has shifted even more to the right side and in particular the majority of it is on 0.7 and 0.8. This makes sense again because the data suggest that <span class="inlinecode">$\theta$</span> should be around 0.75. The reason why we do not see mass at 0.75 is because we restricted our parameter space to discrete values of <span class="inlinecode">$\theta = 0, \theta = 0.1, ..., \theta = 1.0$</span>. We can easily expand our parameter space to a larger "grid":


{% highlight r %}
new_theta_vals <- seq(0, 1, 0.001)
new_prior_distr_df <- get_prior_distr(new_theta_vals)
new_likelihood_df <- get_likelihood_df(new_theta_vals, 15, 5)
new_posterior_df <- get_posterior_df(new_likelihood_df, new_prior_distr_df)

plot_grid(
  plot_prior_distr(new_prior_distr_df, plot_x_labels = FALSE), 
  plot_likelihood_prob_distr(new_likelihood_df) +
    labs(subtitle = "15 Heads with 20 Coin Tosses"),
  plot_posterior_prob_distr(new_posterior_df, new_theta_vals) +
    labs(subtitle = "15 Heads with 20 Coin Tosses"),
  nrow = 3
)
{% endhighlight %}

![plot of chunk posterior-prob-distr-grid]({{ site.url }}/assets/how-to-bayesian-infer-101/posterior-prob-distr-grid-1.svg)
 
With more data points, we note that the posterior starts to resemble the 
likelihood. Let us take this one more step with 1000 data points and 750 heads:


{% highlight r %}
new_theta_vals <- seq(0, 1, 0.001)
new_likelihood_df <- get_likelihood_df(new_theta_vals, 750, 250)
new_posterior_df <- get_posterior_df(new_likelihood_df, new_prior_distr_df)

p1 <- plot_prior_distr(new_prior_distr_df, plot_x_labels = FALSE)

p2 <- 
  plot_likelihood_prob_distr(new_likelihood_df) +
  labs(subtitle = "750 Heads with 1000 Coin Tosses")

p3 <- 
  plot_posterior_prob_distr(new_posterior_df, new_theta_vals) +
  labs(subtitle = "750 Heads with 1000 Coin Tosses")

plot_grid(p1, p2, p3, nrow = 3, align = "v")
{% endhighlight %}

![plot of chunk posterior-prob-distr-grid-more-data]({{ site.url }}/assets/how-to-bayesian-infer-101/posterior-prob-distr-grid-more-data-1.svg)

Here is the posterior is almost exactly the same as the likelihood. 

It's also a good idea to check that the posterior probability distribution is a 
proper probability distribution by checking that it sums/integrates to:


{% highlight r %}
sum(new_posterior_df[["post_prob"]])
{% endhighlight %}



{% highlight text %}
## [1] 1
{% endhighlight %}

## Conclusions

In this post, I have introduced how one can make use of Bayes' rule to do 
Bayesian inference. Remember that the happens when we start to interpret the 
variables of Bayes' rule as parameters (<span class="inlinecode">$\theta$</span>) 
of a model and observed data (<span class="inlinecode">$D$</span>):

<div>
$$\begin{align}
P(X\ |\ Y) &= \frac{P(Y\ |\ X)\ P(X)}{P(Y)} \\
P(\theta\ |\ D) &= \frac{P(D\ |\ \theta)\ P(\theta)}{P(D)}
\end{align}$$
</div>

I have provided an overview of the 4 key steps to any Bayesian inference, and 
how the posterior distribution represents a compromise between the prior and 
likelihood. In this example, the prior distribution was chosen arbitrary and we 
calculated the posterior distribution by exhaustively calculating each value. 
This was possible because our parameter space was small, but does not scale well 
to larger parameter spaces. In follow-up posts, I will discuss how we can use an 
analytical approach to solve this, which in turn depends on our selection of a 
prior distribution. Moreover, I will discuss why Bayesian statistics is 
difficult and how a class of methods called Markov chain Monte Carlo (MCMC) can 
help us deal with this!

* 2020-12-15: Removed superfluous code in the `get_likelihood_df` function.
    Thanks [Ben](https://disqus.com/by/disqus_bennyp/) for pointing this out.
* 2019-09-19: Fixed the calculation of the marginal probability by multiplying 
    the likelihood by the prior. This results in a proper posterior probability
    distribution that integrates to 1. Thanks [Jose Tabora](https://disqus.com/by/disqus_cKBlo84jcJ/) 
    for pointing out the original posterior probability distribution wasn't 
    proper.

## References

* [Doing Bayesian Data Analysis: A Tutorial with R, JAGS, and Stan](https://sites.google.com/site/doingbayesiandataanalysis/)
* [Points of significance: Bayesian statistics](www.nature.com/nmeth/journal/v12/n5/full/nmeth.3368.html)

## R Session


{% highlight text %}
## ─ Session info ───────────────────────────────────────────────────────────────
##  setting  value                       
##  version  R version 4.0.3 (2020-10-10)
##  os       macOS Sierra 10.12.6        
##  system   x86_64, darwin16.7.0        
##  ui       unknown                     
##  language (EN)                        
##  collate  en_GB.UTF-8                 
##  ctype    en_GB.UTF-8                 
##  tz       Europe/London               
##  date     2020-12-15                  
## 
## ─ Packages ───────────────────────────────────────────────────────────────────
##  package     * version  date       lib source        
##  argparse    * 2.0.3    2020-10-19 [1] CRAN (R 4.0.3)
##  assertthat    0.2.1    2019-03-21 [1] CRAN (R 4.0.3)
##  backports     1.1.10   2020-09-15 [1] CRAN (R 4.0.3)
##  Cairo       * 1.5-12.2 2020-07-07 [1] CRAN (R 4.0.3)
##  callr         3.5.1    2020-10-13 [1] CRAN (R 4.0.3)
##  cli           2.1.0    2020-10-12 [1] CRAN (R 4.0.3)
##  colorspace    1.4-1    2019-03-18 [1] CRAN (R 4.0.3)
##  cowplot     * 1.1.0    2020-09-08 [1] CRAN (R 4.0.3)
##  crayon        1.3.4    2017-09-16 [1] CRAN (R 4.0.3)
##  desc          1.2.0    2018-05-01 [1] CRAN (R 4.0.3)
##  devtools      2.3.2    2020-09-18 [1] CRAN (R 4.0.3)
##  digest        0.6.27   2020-10-24 [1] CRAN (R 4.0.3)
##  dplyr       * 1.0.2    2020-08-18 [1] CRAN (R 4.0.3)
##  ellipsis      0.3.1    2020-05-15 [1] CRAN (R 4.0.3)
##  evaluate      0.14     2019-05-28 [1] CRAN (R 4.0.3)
##  fansi         0.4.1    2020-01-08 [1] CRAN (R 4.0.3)
##  farver        2.0.3    2020-01-16 [1] CRAN (R 4.0.3)
##  findpython    1.0.5    2019-03-08 [1] CRAN (R 4.0.3)
##  fs            1.5.0    2020-07-31 [1] CRAN (R 4.0.3)
##  generics      0.0.2    2018-11-29 [1] CRAN (R 4.0.3)
##  ggplot2     * 3.3.2    2020-06-19 [1] CRAN (R 4.0.3)
##  glue        * 1.4.2    2020-08-27 [1] CRAN (R 4.0.3)
##  gtable        0.3.0    2019-03-25 [1] CRAN (R 4.0.3)
##  highr         0.8      2019-03-20 [1] CRAN (R 4.0.3)
##  jsonlite      1.7.1    2020-09-07 [1] CRAN (R 4.0.3)
##  knitr       * 1.30     2020-09-22 [1] CRAN (R 4.0.3)
##  labeling      0.4.2    2020-10-20 [1] CRAN (R 4.0.3)
##  lifecycle     0.2.0    2020-03-06 [1] CRAN (R 4.0.3)
##  magrittr      2.0.1    2020-11-17 [1] CRAN (R 4.0.3)
##  memoise       1.1.0    2017-04-21 [1] CRAN (R 4.0.3)
##  munsell       0.5.0    2018-06-12 [1] CRAN (R 4.0.3)
##  pillar        1.4.6    2020-07-10 [1] CRAN (R 4.0.3)
##  pkgbuild      1.1.0    2020-07-13 [1] CRAN (R 4.0.3)
##  pkgconfig     2.0.3    2019-09-22 [1] CRAN (R 4.0.3)
##  pkgload       1.1.0    2020-05-29 [1] CRAN (R 4.0.3)
##  prettyunits   1.1.1    2020-01-24 [1] CRAN (R 4.0.3)
##  processx      3.4.4    2020-09-03 [1] CRAN (R 4.0.3)
##  ps            1.4.0    2020-10-07 [1] CRAN (R 4.0.3)
##  purrr         0.3.4    2020-04-17 [1] CRAN (R 4.0.3)
##  R6            2.4.1    2019-11-12 [1] CRAN (R 4.0.3)
##  remotes       2.2.0    2020-07-21 [1] CRAN (R 4.0.3)
##  rlang         0.4.8    2020-10-08 [1] CRAN (R 4.0.3)
##  rprojroot     1.3-2    2018-01-03 [1] CRAN (R 4.0.3)
##  scales        1.1.1    2020-05-11 [1] CRAN (R 4.0.3)
##  sessioninfo   1.1.1    2018-11-05 [1] CRAN (R 4.0.3)
##  stringi       1.5.3    2020-09-09 [1] CRAN (R 4.0.3)
##  stringr       1.4.0    2019-02-10 [1] CRAN (R 4.0.3)
##  testthat      2.3.2    2020-03-02 [1] CRAN (R 4.0.3)
##  tibble        3.0.4    2020-10-12 [1] CRAN (R 4.0.3)
##  tidyselect    1.1.0    2020-05-11 [1] CRAN (R 4.0.3)
##  usethis       1.6.3    2020-09-17 [1] CRAN (R 4.0.3)
##  vctrs         0.3.4    2020-08-29 [1] CRAN (R 4.0.3)
##  withr         2.3.0    2020-09-22 [1] CRAN (R 4.0.3)
##  xfun          0.18     2020-09-29 [1] CRAN (R 4.0.3)
## 
## [1] /usr/local/lib/R/4.0/site-library
## [2] /usr/local/Cellar/r/4.0.3/lib/R/library
{% endhighlight %}
