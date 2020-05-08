---
title: "Safely Selecting Data Frame Columns in Your Tidyverse Code"
date: "May 8th, 2020"
layout: post
output:
  html_document:
    toc: true
    toc_float: true
    number_sections: true
tags: [R, tidyverse]
---



In my previous post ["Use of the .data and .env Pronouns to Disambiguate Your Tidyverse Code"]({% post_url 2020-03-01-use-data-env-pronouns-tidyverse %}), 
I discussed how using the `.data` and `.env` pronouns should be used to write 
production-grade R code. The post was inspired by Lionel Henry's talk titled 
["Interactivity and Programming in the tidyverse"](https://resources.rstudio.com/rstudio-conf-2020/interactivity-and-programming-in-the-tidyverse-lionel-henry).

In that same talk, the `all_of` function was introduced as a method to safely 
select column names from data frames. In this post, I will discuss how one should
use this function and the `.data` pronoun to safely select column names in
production-grade R code.

# Setup

First, I will do some setting up of my environment for the rest of the post:


{% highlight r %}
# Set mtcars to tibble to control the maximum number of printed rows. This is
# just to make the post easier to follow
library("magrittr")
library("tibble")
options(tibble.print_max = 6, tibble.print_min = 6)
mtcars <- as_tibble(mtcars)
{% endhighlight %}

# Safely Selecting a Single Column

As I mentioned from my last post, "data masking" enables you to "blend data with 
the workspace". This allows for you to easily select a single column from a 
data frame like this:


{% highlight r %}
dplyr::select(mtcars, mpg)
{% endhighlight %}



{% highlight text %}
## # A tibble: 32 x 1
##     mpg
##   <dbl>
## 1  21  
## 2  21  
## 3  22.8
## 4  21.4
## 5  18.7
## 6  18.1
## # … with 26 more rows
{% endhighlight %}

Here the `dplyr::select` function knows you are trying to select the "mpg" 
column from the `mtcars` data frame. If you use a variable to store the column 
name you want to select:


{% highlight r %}
col_to_select <- "mpg"
dplyr::select(mtcars, col_to_select)
{% endhighlight %}



{% highlight text %}
## Note: Using an external vector in selections is ambiguous.
## ℹ Use `all_of(col_to_select)` instead of `col_to_select` to silence this message.
## ℹ See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
## This message is displayed once per session.
{% endhighlight %}



{% highlight text %}
## # A tibble: 32 x 1
##     mpg
##   <dbl>
## 1  21  
## 2  21  
## 3  22.8
## 4  21.4
## 5  18.7
## 6  18.1
## # … with 26 more rows
{% endhighlight %}

**N.B: We'll ignore the note regarding the usage of `all_of` for now and come back
to this at the end of the post.**

The `dplyr::select` figures out you are selecting the column name that is stored
in the `col_to_select` variable and not a phantom column called "col_to_select"
(since it doesn't exist). Now what happens when you do something like this?


{% highlight r %}
gear <- "mpg"
dplyr::select(mtcars, gear)
{% endhighlight %}



{% highlight text %}
## # A tibble: 32 x 1
##    gear
##   <dbl>
## 1     4
## 2     4
## 3     4
## 4     3
## 5     3
## 6     3
## # … with 26 more rows
{% endhighlight %}

Due to data masking, the "gear" column name takes precedence over the value 
stored in the `gear` variable. There are two ways to deal with this. You can 
explicitly refer to the column name by double quoting the column name.


{% highlight r %}
gear <- "mpg"

# Ignores the `gear` variable.
dplyr::select(mtcars, "gear")
{% endhighlight %}



{% highlight text %}
## # A tibble: 32 x 1
##    gear
##   <dbl>
## 1     4
## 2     4
## 3     4
## 4     3
## 5     3
## 6     3
## # … with 26 more rows
{% endhighlight %}

If you want to use a variable to store the column name, then the safest thing to 
do is to combine it with the `.data` pronoun:


{% highlight r %}
gear <- "mpg"
dplyr::select(mtcars, .data[[gear]])
{% endhighlight %}



{% highlight text %}
## # A tibble: 32 x 1
##     mpg
##   <dbl>
## 1  21  
## 2  21  
## 3  22.8
## 4  21.4
## 5  18.7
## 6  18.1
## # … with 26 more rows
{% endhighlight %}

# Safely Selecting Multiple Columns

If you want to safely select multiple columns, then you should start by double
quoting the columns names to make it explicit:


{% highlight r %}
dplyr::select(mtcars, "mpg", "carb")
{% endhighlight %}



{% highlight text %}
## # A tibble: 32 x 2
##     mpg  carb
##   <dbl> <dbl>
## 1  21       4
## 2  21       4
## 3  22.8     1
## 4  21.4     1
## 5  18.7     2
## 6  18.1     1
## # … with 26 more rows
{% endhighlight %}

If you want to use a variable to select multiple columns, you should create a 
character vector storing the different column names: 


{% highlight r %}
cols_to_select <- c("mpg", "carb")
dplyr::select(mtcars, cols_to_select)
{% endhighlight %}



{% highlight text %}
## # A tibble: 32 x 2
##     mpg  carb
##   <dbl> <dbl>
## 1  21       4
## 2  21       4
## 3  22.8     1
## 4  21.4     1
## 5  18.7     2
## 6  18.1     1
## # … with 26 more rows
{% endhighlight %}

Here the `dplyr::select` function is smart enough to figure out that you are
asking for multiple columns stored in the `cols_to_select` variable. However,
what happens if you have something like this?


{% highlight r %}
gear <- c("mpg", "carb")
dplyr::select(mtcars, gear)
{% endhighlight %}



{% highlight text %}
## # A tibble: 32 x 1
##    gear
##   <dbl>
## 1     4
## 2     4
## 3     4
## 4     3
## 5     3
## 6     3
## # … with 26 more rows
{% endhighlight %}

Similar to the scenario where we were selecting a single column, data masking
results in the "gear" column name taking precedence over the values in the 
`gear` variable. This ends up creating an unexpected result. This is where the
`all_of` function comes in:


{% highlight r %}
gear <- c("mpg", "carb")
dplyr::select(mtcars, all_of(gear))
{% endhighlight %}



{% highlight text %}
## # A tibble: 32 x 2
##     mpg  carb
##   <dbl> <dbl>
## 1  21       4
## 2  21       4
## 3  22.8     1
## 4  21.4     1
## 5  18.7     2
## 6  18.1     1
## # … with 26 more rows
{% endhighlight %}

The function means to literally select "all of" the columns that are stored in 
the character vector variable. By using `all_of`, you guard yourself against
any data masking.

# `.data` vs. `all_of`

Near the beginning of the post, we saw the following note when using a variable
with the `dplyr::select` function:


{% highlight r %}
col_to_select <- "mpg"
dplyr::select(mtcars, col_to_select)
{% endhighlight %}



{% highlight text %}
## # A tibble: 32 x 1
##     mpg
##   <dbl>
## 1  21  
## 2  21  
## 3  22.8
## 4  21.4
## 5  18.7
## 6  18.1
## # … with 26 more rows
{% endhighlight %}

Based on this, it seems that using the function `all_of` is the recommended way 
to select columns when using a variable even when it's only a single column. 
In other words,


{% highlight r %}
col_to_select <- "mpg"
dplyr::select(mtcars, all_of(col_to_select))
{% endhighlight %}



{% highlight text %}
## # A tibble: 32 x 1
##     mpg
##   <dbl>
## 1  21  
## 2  21  
## 3  22.8
## 4  21.4
## 5  18.7
## 6  18.1
## # … with 26 more rows
{% endhighlight %}

This is as valid as using the `.data` pronoun. My personal preference is to 
stick to using the `.data` pronoun when I only want to select a single column
and use `all_of` when my character vector has multiple values in it. This simply
makes it more obvious to me what I should be expecting from `dplyr::select` 
call.

# Conclusions

In conclusion, my recommendations for safely selecting data frame columns in the 
tidyverse are as follows:

* Be explicit in the single and multiple column selections by double quoting the 
    column names.
* If you want to use a variable to store a single column name, then combine it 
    with the `.data` pronoun.
* If you want to use a variable to store a character vector of multiple column 
    names, then use the `all_of` function.


{% highlight r %}
devtools::session_info()
{% endhighlight %}



{% highlight text %}
## ─ Session info ───────────────────────────────────────────────────────────────
##  setting  value                       
##  version  R version 3.6.2 (2019-12-12)
##  os       macOS Sierra 10.12.6        
##  system   x86_64, darwin16.7.0        
##  ui       unknown                     
##  language (EN)                        
##  collate  en_GB.UTF-8                 
##  ctype    en_GB.UTF-8                 
##  tz       Europe/London               
##  date     2020-05-08                  
## 
## ─ Packages ───────────────────────────────────────────────────────────────────
##  package     * version date       lib source        
##  argparse    * 2.0.1   2019-03-08 [1] CRAN (R 3.6.2)
##  assertthat    0.2.1   2019-03-21 [1] CRAN (R 3.6.2)
##  backports     1.1.6   2020-04-05 [1] CRAN (R 3.6.2)
##  callr         3.4.3   2020-03-28 [1] CRAN (R 3.6.2)
##  cli           2.0.2   2020-02-28 [1] CRAN (R 3.6.2)
##  crayon        1.3.4   2017-09-16 [1] CRAN (R 3.6.2)
##  desc          1.2.0   2018-05-01 [1] CRAN (R 3.6.2)
##  devtools      2.3.0   2020-04-10 [1] CRAN (R 3.6.2)
##  digest        0.6.25  2020-02-23 [1] CRAN (R 3.6.2)
##  dplyr         0.8.5   2020-03-07 [1] CRAN (R 3.6.2)
##  ellipsis      0.3.0   2019-09-20 [1] CRAN (R 3.6.2)
##  evaluate      0.14    2019-05-28 [1] CRAN (R 3.6.2)
##  fansi         0.4.1   2020-01-08 [1] CRAN (R 3.6.2)
##  findpython    1.0.5   2019-03-08 [1] CRAN (R 3.6.2)
##  fs            1.4.1   2020-04-04 [1] CRAN (R 3.6.2)
##  glue        * 1.4.0   2020-04-03 [1] CRAN (R 3.6.2)
##  jsonlite      1.6.1   2020-02-02 [1] CRAN (R 3.6.2)
##  knitr       * 1.28    2020-02-06 [1] CRAN (R 3.6.2)
##  lifecycle     0.2.0   2020-03-06 [1] CRAN (R 3.6.2)
##  magrittr    * 1.5     2014-11-22 [1] CRAN (R 3.6.2)
##  memoise       1.1.0   2017-04-21 [1] CRAN (R 3.6.2)
##  pillar        1.4.3   2019-12-20 [1] CRAN (R 3.6.2)
##  pkgbuild      1.0.6   2019-10-09 [1] CRAN (R 3.6.2)
##  pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 3.6.2)
##  pkgload       1.0.2   2018-10-29 [1] CRAN (R 3.6.2)
##  prettyunits   1.1.1   2020-01-24 [1] CRAN (R 3.6.2)
##  processx      3.4.2   2020-02-09 [1] CRAN (R 3.6.2)
##  ps            1.3.2   2020-02-13 [1] CRAN (R 3.6.2)
##  purrr         0.3.4   2020-04-17 [1] CRAN (R 3.6.2)
##  R6            2.4.1   2019-11-12 [1] CRAN (R 3.6.2)
##  Rcpp          1.0.4.6 2020-04-09 [1] CRAN (R 3.6.2)
##  remotes       2.1.1   2020-02-15 [1] CRAN (R 3.6.2)
##  rlang         0.4.5   2020-03-01 [1] CRAN (R 3.6.2)
##  rprojroot     1.3-2   2018-01-03 [1] CRAN (R 3.6.2)
##  sessioninfo   1.1.1   2018-11-05 [1] CRAN (R 3.6.2)
##  stringi       1.4.6   2020-02-17 [1] CRAN (R 3.6.2)
##  stringr       1.4.0   2019-02-10 [1] CRAN (R 3.6.2)
##  testthat      2.3.2   2020-03-02 [1] CRAN (R 3.6.2)
##  tibble      * 3.0.1   2020-04-20 [1] CRAN (R 3.6.2)
##  tidyselect    1.0.0   2020-01-27 [1] CRAN (R 3.6.2)
##  usethis       1.6.0   2020-04-09 [1] CRAN (R 3.6.2)
##  utf8          1.1.4   2018-05-24 [1] CRAN (R 3.6.2)
##  vctrs         0.2.4   2020-03-10 [1] CRAN (R 3.6.2)
##  withr         2.1.2   2018-03-15 [1] CRAN (R 3.6.2)
##  xfun          0.12    2020-01-13 [1] CRAN (R 3.6.2)
## 
## [1] /usr/local/Cellar/r/3.6.2/lib/R/library
{% endhighlight %}

# References

* [Interactivity and Programming in the Tidyverse - Lionel Henry](https://resources.rstudio.com/rstudio-conf-2020/interactivity-and-programming-in-the-tidyverse-lionel-henry)
