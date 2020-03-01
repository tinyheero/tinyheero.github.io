---
title:  "Use the .data and .env Pronouns to Disambiguate Your Tidyverse Code"
date: "March 1st, 2020"
layout: post
output:
  html_document:
    toc: true
    toc_float: true
    number_sections: true
tags: [R, tidyverse]
---



As someone who has been writing [tidyverse](https://www.tidyverse.org/) code for
a few years, I've always found it difficult to bring the concept of
[tidyeval](https://tidyeval.tidyverse.org/) into a production-level environment.
The recent [rstudio::conf 2020](https://resources.rstudio.com/rstudio-conf-2020)
talk by Lionel Henry titled ["Interactivity and Programming in the tidyverse"](https://resources.rstudio.com/rstudio-conf-2020/interactivity-and-programming-in-the-tidyverse-lionel-henry) shed some much
needed light on how to write safe production-level tidyverse code.

I wanted to use this blog post to highlight Lionel's tip on the usage of `.data`
and `.env` pronouns in your tidyverse code to disambiguate your code. I've
already been using the [`.data` pronoun for quite some time](https://stackoverflow.com/questions/49651253/dplyr-data-pronoun-vs-quosure-approach), but didn't realize that it wasn't enough by itself. However,
if you use it in combination with the `.env` pronoun, this will ensure that you
don't produce unanticipated results in your R code!

# Data Masking

Lionel Henry starts the talk by discussing the idea of "data masking" which 
allows you to "blend data with the workspace". In essence, it enables you to do
something like:


{% highlight r %}
dplyr::filter(mtcars, cyl == carb)
{% endhighlight %}



{% highlight text %}
##    mpg cyl disp  hp drat   wt qsec vs am gear carb
## 1 19.7   6  145 175 3.62 2.77 15.5  0  1    5    6
## 2 15.0   8  301 335 3.54 3.57 14.6  0  1    5    8
{% endhighlight %}

Here the `dplyr::filter` function knows that you are filtering for rows where
the "cyl" column matches the "carb" column. Data masking allows us to refer to 
the columns "cyl" and "carb" in the dataframe `mtcars` without having to 
explicitly list the column names like this:


{% highlight r %}
dplyr::filter(mtcars, mtcars[["cyl"]] == mtcars[["carb"]])
{% endhighlight %}



{% highlight text %}
##    mpg cyl disp  hp drat   wt qsec vs am gear carb
## 1 19.7   6  145 175 3.62 2.77 15.5  0  1    5    6
## 2 15.0   8  301 335 3.54 3.57 14.6  0  1    5    8
{% endhighlight %}

Similarly, if you do this:


{% highlight r %}
num_cyl <- 6
dplyr::filter(mtcars, cyl == num_cyl)
{% endhighlight %}



{% highlight text %}
##    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## 2 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## 3 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## 4 18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## 5 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## 6 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## 7 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
{% endhighlight %}

The `dplyr::filter` function knows that you are filtering for rows where the 
"cyl" column matches the value stored in the `num_cyl` variable because there is 
no column name called "num_cyl". This is great because it simplifies your code 
when you are exploring the data.

# Unexpected Data Masking

Now what do you expect to happen with this piece of code?


{% highlight r %}
carb <- 6
dplyr::filter(mtcars, cyl == carb)
{% endhighlight %}



{% highlight text %}
##    mpg cyl disp  hp drat   wt qsec vs am gear carb
## 1 19.7   6  145 175 3.62 2.77 15.5  0  1    5    6
## 2 15.0   8  301 335 3.54 3.57 14.6  0  1    5    8
{% endhighlight %}

You might have expected it to return all rows where the `cyl` column had a value 
of 6 as this was the number the `carb` variable was set to. However in this 
case, the `mtcars` dataframe had a column name called "carb" and this actually 
took precedence over the value in the variable. To me, this produced 
unanticipated results due to unexpected data masking.

This is generally not a big issue when you are using R in interactive mode. You
would know which variables are in your workspace and what the column names are
in your dataframe. Additionally, if you ran into this issue where you had a
column name that matched a variable name, you could just rename the column name
or variable and just move on.

However when writing production level R code, you might not have this luxury.
You really want to be disambiguous in what values the R code should be using.
So what's the solution? 

# Introducing the .data and .env Pronouns

This is where the `.data` and `.env` pronouns come into play. The pronouns refer 
to data in your dataframe and workspace respectively. In this case:


{% highlight r %}
carb <- 6
dplyr::filter(mtcars, .data[["cyl"]] == .env[["carb"]])
{% endhighlight %}



{% highlight text %}
##    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## 2 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## 3 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## 4 18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## 5 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## 6 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## 7 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
{% endhighlight %}

would produce the intended results. The `.data[["cyl"]]` tells `dplyr::filter`
to filter on the "cyl" column in the `mtcars` dataframe. The `.env[["carb"]]`
indicates that we should be filtering on the value stored in the workspace
variable `carb` and NOT the "carb" column in `mtcars`. 

If we wanted to filter for rows where the "cyl" and "carb" column values matched 
, then we would do this:


{% highlight r %}
dplyr::filter(mtcars, .data[["cyl"]] == .data[["carb"]])
{% endhighlight %}



{% highlight text %}
##    mpg cyl disp  hp drat   wt qsec vs am gear carb
## 1 19.7   6  145 175 3.62 2.77 15.5  0  1    5    6
## 2 15.0   8  301 335 3.54 3.57 14.6  0  1    5    8
{% endhighlight %}

This principle should also be applied to your functions. The `.env` pronoun
also takes into account lexical scoping:


{% highlight r %}
cyl_val <- 6

filter_df_by_cyl <- function(in_df, cyl_val) {
  dplyr::filter(in_df, .data[["cyl"]] == .env[["cyl_val"]])
}

filter_df_by_cyl(mtcars, 8)
{% endhighlight %}



{% highlight text %}
##     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1  18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## 2  14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## 3  16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## 4  17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## 5  15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## 6  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## 7  10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## 8  14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## 9  15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
## 10 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## 11 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## 12 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## 13 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
## 14 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
{% endhighlight %}

Here it filters by the value 8 and not 6 as it determines the value from the 
`cyl_val` variable in the function environment and not the global environment.

# Conclusions

In summary, make sure to use the `.data` and `env` pronouns in your R code!
I have gotten into the habit of doing this regardless of whether I am writing 
production-level code or not. As far as I can tell, there is no harm in being 
explicit in my R code aside from the extra few characters you have to type. If 
you don't do it, you might get unexpected data masking that could produce 
results you might not know are wrong. In a production-level environment, you 
can't afford this type of mistake.

I would also highly recommend watching the [full presentation by Lionel Henry](https://resources.rstudio.com/rstudio-conf-2020)
to get more tips on safely using tidyverse code in a production-level 
environment.

# References

* [Interactivity and Programming in the Tidyverse - Lionel Henry](https://resources.rstudio.com/rstudio-conf-2020/interactivity-and-programming-in-the-tidyverse-lionel-henry)
* [Tidy evaluation](https://tidyeval.tidyverse.org/)
