---
title: "Joint, Marginal, and Conditional Probabilities"
date: "March 20th, 2016"
layout: post
output:
  html_document:
tags: [R, stats]
---

Probabilities represent the chances of an event x occurring. In the classic interpretation, a probability is measured by the number of times event x occurs divided by the total number of trials; In other words, the frequency of the event occurring. There are three types of probabilities: 

1. Joint Probabilities
2. Marginal Probabilities
3. Conditional Probabilities
   
In this post, we will discuss each of these probabilities. Here is an overview of what will be discussed in this post.

**Table of Contents**

<ul data-toc="body" data-toc-headings="h2,h3"></ul>



## Joint Probabilities

The first type of probability we will discuss is the joint probability which is the probability of two different events occurring at the same time. Let's use the diamonds dataset, from ggplot2, as our example dataset. The two different variables we are interested in are diamond colors and cuts. First we will measure the frequency of each type of diamond color-cut combination. We can represent these data using a "two-way table":


~~~r
library("ggplot2")
library("dplyr")
library("reshape2")
library("knitr")

diamonds.color.cut.df <-
  diamonds %>%
  group_by(color, cut) %>%
  summarize(n = n())

diamonds.color.cut.df %>%
  dcast(color ~ cut, value.nar = "n") %>%
  kable(align = "l", format = "html",
        table.attr='class="table table-striped table-hover"')
~~~

<table class="table table-striped table-hover">
 <thead>
  <tr>
   <th style="text-align:left;"> color </th>
   <th style="text-align:left;"> Fair </th>
   <th style="text-align:left;"> Good </th>
   <th style="text-align:left;"> Very Good </th>
   <th style="text-align:left;"> Premium </th>
   <th style="text-align:left;"> Ideal </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> D </td>
   <td style="text-align:left;"> 163 </td>
   <td style="text-align:left;"> 662 </td>
   <td style="text-align:left;"> 1513 </td>
   <td style="text-align:left;"> 1603 </td>
   <td style="text-align:left;"> 2834 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> E </td>
   <td style="text-align:left;"> 224 </td>
   <td style="text-align:left;"> 933 </td>
   <td style="text-align:left;"> 2400 </td>
   <td style="text-align:left;"> 2337 </td>
   <td style="text-align:left;"> 3903 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> 312 </td>
   <td style="text-align:left;"> 909 </td>
   <td style="text-align:left;"> 2164 </td>
   <td style="text-align:left;"> 2331 </td>
   <td style="text-align:left;"> 3826 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> G </td>
   <td style="text-align:left;"> 314 </td>
   <td style="text-align:left;"> 871 </td>
   <td style="text-align:left;"> 2299 </td>
   <td style="text-align:left;"> 2924 </td>
   <td style="text-align:left;"> 4884 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H </td>
   <td style="text-align:left;"> 303 </td>
   <td style="text-align:left;"> 702 </td>
   <td style="text-align:left;"> 1824 </td>
   <td style="text-align:left;"> 2360 </td>
   <td style="text-align:left;"> 3115 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I </td>
   <td style="text-align:left;"> 175 </td>
   <td style="text-align:left;"> 522 </td>
   <td style="text-align:left;"> 1204 </td>
   <td style="text-align:left;"> 1428 </td>
   <td style="text-align:left;"> 2093 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> J </td>
   <td style="text-align:left;"> 119 </td>
   <td style="text-align:left;"> 307 </td>
   <td style="text-align:left;"> 678 </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;"> 896 </td>
  </tr>
</tbody>
</table>

<span class="tblcaption"><u>Table</u>  1: Color-Cut Two Way Frequency Table.</span>

Joint probabilities can be calculated by taking the proportion of times a specific color-cut combination occurs divided by total number of all color-cut combinations (i.e. frequency):


~~~r
diamonds.color.cut.prop.df <- 
  diamonds.color.cut.df %>%
  ungroup() %>%
  mutate(prop = n / sum(n))

diamonds.color.cut.prop.df %>%
  dcast(color ~ cut, value.var = "prop") %>%
  kable(align = "l", format = "html", 
        table.attr = 'class="table table-striped table-hover"')
~~~

<table class="table table-striped table-hover">
 <thead>
  <tr>
   <th style="text-align:left;"> color </th>
   <th style="text-align:left;"> Fair </th>
   <th style="text-align:left;"> Good </th>
   <th style="text-align:left;"> Very Good </th>
   <th style="text-align:left;"> Premium </th>
   <th style="text-align:left;"> Ideal </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> D </td>
   <td style="text-align:left;"> 0.0030219 </td>
   <td style="text-align:left;"> 0.0122729 </td>
   <td style="text-align:left;"> 0.0280497 </td>
   <td style="text-align:left;"> 0.0297182 </td>
   <td style="text-align:left;"> 0.0525399 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> E </td>
   <td style="text-align:left;"> 0.0041528 </td>
   <td style="text-align:left;"> 0.0172970 </td>
   <td style="text-align:left;"> 0.0444939 </td>
   <td style="text-align:left;"> 0.0433259 </td>
   <td style="text-align:left;"> 0.0723582 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> 0.0057842 </td>
   <td style="text-align:left;"> 0.0168521 </td>
   <td style="text-align:left;"> 0.0401187 </td>
   <td style="text-align:left;"> 0.0432147 </td>
   <td style="text-align:left;"> 0.0709307 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> G </td>
   <td style="text-align:left;"> 0.0058213 </td>
   <td style="text-align:left;"> 0.0161476 </td>
   <td style="text-align:left;"> 0.0426214 </td>
   <td style="text-align:left;"> 0.0542084 </td>
   <td style="text-align:left;"> 0.0905451 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H </td>
   <td style="text-align:left;"> 0.0056174 </td>
   <td style="text-align:left;"> 0.0130145 </td>
   <td style="text-align:left;"> 0.0338154 </td>
   <td style="text-align:left;"> 0.0437523 </td>
   <td style="text-align:left;"> 0.0577494 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I </td>
   <td style="text-align:left;"> 0.0032443 </td>
   <td style="text-align:left;"> 0.0096774 </td>
   <td style="text-align:left;"> 0.0223211 </td>
   <td style="text-align:left;"> 0.0264739 </td>
   <td style="text-align:left;"> 0.0388024 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> J </td>
   <td style="text-align:left;"> 0.0022062 </td>
   <td style="text-align:left;"> 0.0056915 </td>
   <td style="text-align:left;"> 0.0125695 </td>
   <td style="text-align:left;"> 0.0149796 </td>
   <td style="text-align:left;"> 0.0166110 </td>
  </tr>
</tbody>
</table>

<span class="tblcaption"><u>Table</u>  2: Color-Cut Two Way Probability Table.</span>

Based on <u>Table</u>  2, we can see that certain color-cut combinations are more probable than others. 

<div class="alert alert-dismissible alert-info">
<h4>Heads Up!</h4>
For brevity and simpler mathematical notions, for the rest of this post we will use the random variable X to represent color and Y to represent cut.
</div>

For instance, a diamond with the X = G and Y = cut , <span class="inlinecode">$P(X = G, Y= ideal) = 0.09$</span>, is much more probable than a diamond with X = D and Y = fair, <span class="inlinecode">$P(X = D, Y = fair) = 0.003$</span>.

## Marginal Probabilities

The second type of probability is the marginal probability. The interesting thing about a marginal probability is that the term sounds complicated, but it's actually the probability that we are most familiar with. Basically anytime you are in interested in a single event irrespective of any other event (i.e. "marginalizing the other event"), then it is a marginal probability. For instance, the probability of a coin flip giving a head is considered a marginal probability because we aren't considering any other events. Typically, we just say probability and not the marginal part of it because this part only comes into play when we have to factor in a second event. 

To illustrate this, we will go back to our diamond color-cut combination two-way table (<u>Table</u>  2). If we are interested in say the marginal probabilty <span class="inlinecode">$P(X = D)$</span>, then basically we are asking "what is the probability of getting a diamond that is color D irrespective of its cut?" It should be initutive that we can calculate this information by simply summing up the joint probabilities of the row color D. Mathematically:

<div>
$$P(X = D) = \sum_{y \in S_{Y}}P(X = D, Y = y)$$
</div>

Where <span class="inlinecode">$S_{Y}$</span> represents all the possible values of the random variable Y. In other words, we are holding X constant (<span class="inlinecode">$X = D$</span>) while iterating over all the possible Y values and summing up the joint probabilities.

We can calculate the marginal probability of all the different colors. We can also calculate the marginal probability of cut by using the same logic and summing up the joint probabilities of the columns. For instance, to calculate <span class="inlinecode">$P(Y = Fair)$</span>,

<div>
$$P(Y = Fair) = \sum_{x \in S_{X}}P(X = x, Y = Fair)$$
</div>

Let's add the marginal probabilities to the two way table now:


~~~r
color.marginal.df <- 
  diamonds.color.cut.prop.df %>%
  group_by(color) %>%
  summarize(marginal = sum(prop))

cut.marginal.df <- 
  diamonds.color.cut.prop.df %>%
  group_by(cut) %>%
  summarize(marginal = sum(prop))

diamonds.color.cut.prop.df %>%
  dcast(color ~ cut, value.var = "prop") %>%
  left_join(color.marginal.df, by = "color") %>%
  bind_rows(
    cut.marginal.df %>%
    mutate(color = "marginal") %>%
    dcast(color ~ cut, value.var = "marginal")
  ) %>%
  kable(align = "l", format = "html",
        table.attr = 'class="table table-striped table-hover"')
~~~

<table class="table table-striped table-hover">
 <thead>
  <tr>
   <th style="text-align:left;"> color </th>
   <th style="text-align:left;"> Fair </th>
   <th style="text-align:left;"> Good </th>
   <th style="text-align:left;"> Very Good </th>
   <th style="text-align:left;"> Premium </th>
   <th style="text-align:left;"> Ideal </th>
   <th style="text-align:left;"> marginal </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> D </td>
   <td style="text-align:left;"> 0.0030219 </td>
   <td style="text-align:left;"> 0.0122729 </td>
   <td style="text-align:left;"> 0.0280497 </td>
   <td style="text-align:left;"> 0.0297182 </td>
   <td style="text-align:left;"> 0.0525399 </td>
   <td style="text-align:left;"> 0.1256025 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> E </td>
   <td style="text-align:left;"> 0.0041528 </td>
   <td style="text-align:left;"> 0.0172970 </td>
   <td style="text-align:left;"> 0.0444939 </td>
   <td style="text-align:left;"> 0.0433259 </td>
   <td style="text-align:left;"> 0.0723582 </td>
   <td style="text-align:left;"> 0.1816277 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> 0.0057842 </td>
   <td style="text-align:left;"> 0.0168521 </td>
   <td style="text-align:left;"> 0.0401187 </td>
   <td style="text-align:left;"> 0.0432147 </td>
   <td style="text-align:left;"> 0.0709307 </td>
   <td style="text-align:left;"> 0.1769003 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> G </td>
   <td style="text-align:left;"> 0.0058213 </td>
   <td style="text-align:left;"> 0.0161476 </td>
   <td style="text-align:left;"> 0.0426214 </td>
   <td style="text-align:left;"> 0.0542084 </td>
   <td style="text-align:left;"> 0.0905451 </td>
   <td style="text-align:left;"> 0.2093437 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H </td>
   <td style="text-align:left;"> 0.0056174 </td>
   <td style="text-align:left;"> 0.0130145 </td>
   <td style="text-align:left;"> 0.0338154 </td>
   <td style="text-align:left;"> 0.0437523 </td>
   <td style="text-align:left;"> 0.0577494 </td>
   <td style="text-align:left;"> 0.1539488 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I </td>
   <td style="text-align:left;"> 0.0032443 </td>
   <td style="text-align:left;"> 0.0096774 </td>
   <td style="text-align:left;"> 0.0223211 </td>
   <td style="text-align:left;"> 0.0264739 </td>
   <td style="text-align:left;"> 0.0388024 </td>
   <td style="text-align:left;"> 0.1005191 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> J </td>
   <td style="text-align:left;"> 0.0022062 </td>
   <td style="text-align:left;"> 0.0056915 </td>
   <td style="text-align:left;"> 0.0125695 </td>
   <td style="text-align:left;"> 0.0149796 </td>
   <td style="text-align:left;"> 0.0166110 </td>
   <td style="text-align:left;"> 0.0520578 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> marginal </td>
   <td style="text-align:left;"> 0.0298480 </td>
   <td style="text-align:left;"> 0.0909529 </td>
   <td style="text-align:left;"> 0.2239896 </td>
   <td style="text-align:left;"> 0.2556730 </td>
   <td style="text-align:left;"> 0.3995365 </td>
   <td style="text-align:left;"> NA </td>
  </tr>
</tbody>
</table>

<span class="tblcaption"><u>Table</u>  3: Color-Cut Two Way Probability Table with Marginal Probabilities. The marginal probability of each cut is represented in the last row whereas the marginal probability of each color ir represented in the last column.</span>

## Conditional Probability

The final type of probability is the conditional probability. A conditional probability is the probability of an event X occurring when a secondary event Y is true. Mathematically, it is represented as <span class="inlinecode">$P(X \ |\ Y)$</span>. This is read as "probability of X given/conditioned on Y".

For example, if someone asked you the probability of getting a diamond with the G color, <span class="inlinecode">$P(X = G)$</span>, we can use <u>Table</u>  3 to find the marginal probability of this event. But what if you had an additional layer of information where you knew that the diamond was also of ideal cut? This becomes a conditional probability since we have an event that is already true. A conditional probability can be calculated as follows:

<div>
$$P(X\ |\ Y) = \frac{P(X, Y)}{P(Y)}$$
</div>

Recall that the marginal probability is simply summing up the joint probabilities while holding one variable constant. So we can further breakdown this equation as follows:

<div>
$$P(X\ |\ Y) = \frac{P(X, Y)}{\sum_{x \in S_{X}}P(X = x, Y)}$$
</div>

So for us to work this out for our particular question, we need two pieces of information:

1. <span class="inlinecode">$P(Y = ideal)$</span>: Marginal probability of Y = ideal.
1. <span class="inlinecode">$P(X = G, Y = ideal)$</span>: Joint probability of X = G and Y = ideal.

So we can calculate the conditional probability as follows:

<div>
$$P(X = G\ |\ Y = ideal) = \frac{P(X = G, Y = ideal)}{\sum_{x \in S_{X}}P(X = x, Y = ideal)}$$
</div>

So the conditional probability would be in this case:


~~~r
joint.prob <- 
  diamonds.color.cut.prop.df %>%
  filter(color == "G", cut == "Ideal") %>%
  .$prop

marg.prob <- 
  cut.marginal.df %>%
  filter(cut == "Ideal") %>%
  .$marginal

cond.prob <- joint.prob / marg.prob
cond.prob
~~~

~~~
## [1] 0.2266252
~~~

So basically if we didn't factor in any other information, our <span class="inlinecode">$P(X = G)$</span> was
0.2093437.
But once we factored in an additional level of information which was Y = ideal, our probability changed to 0.2266252. Put another way, we had a "reallocation of our belief" in an event once we factored in additional information. 

## Defining a Joint Probability Equation

In the conditional and marginal probabilities section, we defined the mathematical equations for them. We can now define a mathematical equation for joint probabilities which actually uses both the conditional and marginal probability equations. Starting with the conditional probability equation, we can do a bit of algebraic manipulation for defining joint probabilities now:

<div>
$$\begin{align}
P(X\ |\ Y) &= \frac{P(X, Y)}{P(Y)} \\
P(X\ |\ Y)\ P(Y) &= P(X, Y) \\
P(X\ |\ Y)\ \sum_{x \in S_{X}}P(X = x, Y) &= P(X, Y) \\
\end{align}$$
</div>

## What about Continuous Random Variables?

In this post's example dataset of diamonds, we used the random variables X and Y to represent diamond colors and cuts respectively. Both of which are discrete random variables. If dealing with continuous random variables, these probabilities still exist with the exception that we are dealing with integrals instead of summations. For instance, the mathematical representation of marginal probabilities for continuous variables becomes an integral:

<div>
$$P(X = D) = \int_{}P(X = D, Y = y)\ dY$$
</div>

## Frequentist vs. Bayesian View

One last thing worth mentioning is that in introduction of this post I made a statement regarding the "classic interpretation" of probability. Specifically this "classic interpretation" is referred to the [frequentist view of probability](https://en.wikipedia.org/wiki/Frequentist_probability). In this view, probabilities are based purely on objective, random experiments with the assumption that given enough trials ("long run") the relative frequency of event x will equal to the true probability of x. Notice how all of the probabilities we reported in this post were based purely on the frequency. 

If you've done any statistics or analytics, you'll likely have come across the term "[bayesian statistics](https://en.wikipedia.org/wiki/Bayesian_statistics)". In brief, bayesian statistics differs from the frequentists view in that it incorporates subjective probability which is the "degree of belief" in an event. This degree of belief is called the "prior probability distribution" and is incorporated along with the data from random experiments when determining probabilities. Bayesian statistics will be discussed in a separate post.

## References

* [Frequentist Probability - Wikipedia](https://en.wikipedia.org/wiki/Frequentist_probability)
* [Nicholas School Statistics Review - Joint, Marginal and Conditional Probabilities](http://sites.nicholas.duke.edu/statsreview/probability/jmc/)
* [Chapter 4 - Doing Bayesian Data Analysis - A Tutorial with R, JAGS, and Stan](https://sites.google.com/site/doingbayesiandataanalysis/)
* [Explained Visually - Conditional probability](http://setosa.io/ev/conditional-probability/)

## R Session


~~~
## Session info --------------------------------------------------------------
~~~

~~~
##  setting  value                       
##  version  R version 3.2.2 (2015-08-14)
##  system   x86_64, darwin13.4.0        
##  ui       unknown                     
##  language (EN)                        
##  collate  en_CA.UTF-8                 
##  tz       America/Vancouver           
##  date     2016-03-22
~~~

~~~
## Packages ------------------------------------------------------------------
~~~

~~~
##  package    * version    date       source        
##  argparse   * 1.0.1      2014-04-05 CRAN (R 3.2.2)
##  assertthat   0.1        2013-12-06 CRAN (R 3.2.2)
##  captioner  * 2.2.3.9000 2015-09-16 local         
##  colorspace   1.2-6      2015-03-11 CRAN (R 3.2.2)
##  DBI          0.3.1      2014-09-24 CRAN (R 3.2.2)
##  devtools     1.9.1      2015-09-11 CRAN (R 3.2.2)
##  digest       0.6.9      2016-01-08 CRAN (R 3.2.2)
##  dplyr      * 0.4.3      2015-09-01 CRAN (R 3.2.2)
##  evaluate     0.8        2015-09-18 CRAN (R 3.2.2)
##  findpython   1.0.1      2014-04-03 CRAN (R 3.2.2)
##  formatR      1.2.1      2015-09-18 CRAN (R 3.2.2)
##  getopt       1.20.0     2013-08-30 CRAN (R 3.2.2)
##  ggplot2    * 2.0.0      2015-12-18 CRAN (R 3.2.2)
##  gtable       0.1.2      2012-12-05 CRAN (R 3.2.2)
##  highr        0.5.1      2015-09-18 CRAN (R 3.2.2)
##  knitr      * 1.12.7     2016-02-09 local         
##  lazyeval     0.1.10     2015-01-02 CRAN (R 3.2.2)
##  magrittr     1.5        2014-11-22 CRAN (R 3.2.2)
##  memoise      0.2.1      2014-04-22 CRAN (R 3.2.2)
##  munsell      0.4.3      2016-02-13 CRAN (R 3.2.2)
##  plyr         1.8.3      2015-06-12 CRAN (R 3.2.2)
##  proto      * 0.3-10     2012-12-22 CRAN (R 3.2.2)
##  R6           2.1.2      2016-01-26 CRAN (R 3.2.2)
##  Rcpp         0.12.3     2016-01-10 CRAN (R 3.2.2)
##  reshape2   * 1.4.1      2014-12-06 CRAN (R 3.2.2)
##  rjson        0.2.15     2014-11-03 CRAN (R 3.2.2)
##  scales       0.3.0      2015-08-25 CRAN (R 3.2.2)
##  stringi      1.0-1      2015-10-22 CRAN (R 3.2.2)
##  stringr      1.0.0      2015-04-30 CRAN (R 3.2.2)
~~~
