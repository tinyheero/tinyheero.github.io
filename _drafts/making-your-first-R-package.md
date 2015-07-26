---
layout: post
title:  "Making Your First R Package"
date:   2015-07-19 19:53:02
categories: jekyll update
---

This post is inspired by a hilarious tweet that David Robinson made on June 19th, 2015:

<blockquote class="twitter-tweet" data-partner="tweetdeck"><p lang="en" dir="ltr">&quot;I wish I&#39;d left this code across scattered .R files instead of combining it into a package&quot; said no one ever <a href="https://twitter.com/hashtag/rstats?src=hash">#rstats</a> <a href="http://t.co/udeNH4T67H">http://t.co/udeNH4T67H</a></p>&mdash; David Robinson (@drob) <a href="https://twitter.com/drob/status/611885584584441856">June 19, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

I finally decided it was time to take the next step and start wrapping all my utility functions, that are scattered across numerous .R files, into R packages. Now why would I or anyone else do this? A few key reasons:

1. **Code Organization**: I am always trying to figure out where that "function" I wrote months, weeks, or even days ago is. It is scattered in one of my .R files in one of my PhD projects. Often times, I end up just re-writing it because it is faster than searching all my .R files. An R package would help in organizing where my functions go.
1. **Consistent documentation**: I can barely remember what half of my functions do let alone the inputs and outputs. An R package provides a great consistent documentation and actually encourages you to document them.
1. **Code Distribution**: 

There are already two wonderful resources that explain how to make your first R package:

* [Hilary Parker's "Writing an R package from scratch"](http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/) - This was the resource that helped me get started on making my first R package. It involves you creating your R package from bare bones and is a fantastic introduction.  
* [Hadley Wickham's "R packages"](http://r-pkgs.had.co.nz/) - This is the most comprehensive resource of how to generate an R package. 

This post discusses the typical workflow that I use to generate R packages. It also aims to provide information that is "in-between" the two aforementioned resources; Giving a slightly more detailed explanation on creating packages from scratch while not going into the great depth that "R packages" does. 

RStudio provides a great interface for creating R packages. However I am not a RStudio user (vim and [Vim-R-plugin](http://www.vim.org/scripts/script.php?script_id=2628) suits all my needs), thus I will be showing how everything works in the R console and the specific code to use (which I assume is what RStudio is running for you in the background). 

# Setup

Hadley Wickham has provided the R community with [devtools](https://cran.r-project.org/web/packages/devtools/index.html) which is an R package that helps us build R packages. We will need to install this package if you want to make your life easier:

{% highlight R %}
install.packages("devtools")
{% endhighlight %}

You'll also need roxygen2 for documenting your functions (see below).

{% highlight R %}
install.packages("roxygen2")
{% endhighlight %}

At the time of this post, I am using the versions 1.7.0 and 4.1.0 for devtools and roxygen2 respectively. 

# Creating the Framework for your First Package

The first thing you want to do is create the framework for your R package, we can do this using devtools:
	
{% highlight R %}
devtools::create("myfirstpackage")
{% endhighlight %}

This ends up creating a folder with the same name as your package name with 4 files inside the folder:

* DESCRIPTION: This is where all the meta-data about your package goes. Rather than try to explain the contents, I will refer you to [Hadley's detailed explanation on the contents of this file](http://r-pkgs.had.co.nz/description.html)
* myfirstpackage.Rproj: This is a RStudio specific file. As I do not use RStudio, I will not comment on this file as I never use it.
* NAMESPACE: In short, this file indicates what needs to be exposed to users or not of your R package. From my experience, I've never edited this file as devtools takes care of the changes as you'll see below. 
* R: This is where all your R code goes for your package.

You now have the bare bones of your first R package. First start by filling out the details in the DESCRIPTION file. When that is done, we can start adding some functions!

# How do I Add My R Functions?

All your R functions that you want in your R package belong in the R directory. You can create an .R file that has the same name as the function you want in it. For instance, let's create a file called `touch R/load_mat.R` and add the following content to the file:

{% highlight R %}
load_mat <- function(infile){
  in.dt <- data.table::fread(infile, header = TRUE)
  in.dt <- in.dt[!duplicated(in.dt[, 1]), ]
  in.mat <- as.matrix(in.dt[, -1, with = FALSE])
  rownames(in.mat) <- unlist(in.dt[, 1, with = FALSE])
  in.mat
}
{% endhighlight %}

This is a simple function that takes in a file and convert it into a matrix with the proper column and row names based on the format of the in file. Each .R file can have multiple functions in them. So:

{% highlight R %}
load_mat <- function(infile){
  in.dt <- data.table::fread(infile, header = TRUE)
  in.dt <- in.dt[!duplicated(in.dt[, 1]), ]
  in.mat <- as.matrix(in.dt[, -1, with = FALSE])
  rownames(in.mat) <- unlist(in.dt[, 1, with = FALSE])
  in.mat
}

load_mat2 <- function(infile){
   ...
}
{% endhighlight %}

In general, try to group together related functions into the same .R file (e.g. if you have a bunch of loading functions then putting them in load.R would be a good idea). One important thing to note here, is you need to add the `@export` tag above your function to indicate this function to be "exposed" to users to use. For example:

{% highlight R %}
#' @export
load_mat <- function(infile){
  in.dt <- data.table::fread(infile, header = TRUE)
  in.dt <- in.dt[!duplicated(in.dt[, 1]), ]
  in.mat <- as.matrix(in.dt[, -1, with = FALSE])
  rownames(in.mat) <- unlist(in.dt[, 1, with = FALSE])
  in.mat
}
{% endhighlight %}

The `#' @export` syntax is actually an Roxygen tag which we will discuss below. By doing this, this ensures that the `load_mat()` function gets added to the NAMESPACE (when you run `devtools::document()`) to indicate that it needs to be exposed.

## External Dependencies

You'll see that the `load_mat()` function actually depends on the data.table::fread() function to read in files super quickly. Notice how I did NOT do something like this:

{% highlight R %}
library("data.table")
load_mat <- function(infile){
  in.dt <- fread(infile, header = TRUE)
  in.dt <- in.dt[!duplicated(in.dt[, 1]), ]
  in.mat <- as.matrix(in.dt[, -1, with = FALSE])
  rownames(in.mat) <- unlist(in.dt[, 1, with = FALSE])
  in.mat
{% endhighlight %}

In other words, specifically load the data.table package and thus save me the step of having to use the `data.table::fread()`. Doing this is actually a big no-no in R package as using a `library()` in an R function can globally effect the availability of functions. To re-iterate:

> Never use library() or require() in a R package!

If your R functions require functions from external packages, the way to do this is to use the ["double colon" approach](https://stat.ethz.ch/R-manual/R-devel/library/base/html/ns-dblcolon.html). You also need to indicate that your R package depends on these external packages. To do this, you will need you add this information your DESCRIPTION file under the Imports content. For this case, we need the data.table R package, so we added the following to our DESCRIPTION file:

```
Imports:
	data.table (>= 1.9.4)
```

Notice how I also specified the version of the data.table. Basically I am saying that this package I am building require the data.table package and specifically a version of it that is >= 1.9.4. You can have indicate multiple external dependencies by just adding them in the next line:

```
Imports:
	data.table (>= 1.9.4),
	dplyr
```

Notice how I didn't specify any version for dplyr which simply indicates the package some version of dplyr. Also remember the comma between each dependency. I've burned a few times by that!

# How do I Document My Functions?

So how do you get that nice documentation in R when I go `?load_mat`. We can leverage off the [roxygen2](https://cran.r-project.org/web/packages/roxygen2/index.html) which provides a very simple way of documenting our functions and then produces `man/load_mat.Rd` files which is what we see when we go `?load_mat`. Both [Hilary (Step 3: Add documentation)](http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/) and [Hadley (Object documentation)](http://r-pkgs.had.co.nz/man.html) discuss at length and I refer you to there pages. 

For instance, here is how you might document the `load_mat()` function:

{% highlight R %}
#' Load a Matrix
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param infile Path to the input file
#' @return A matrix of the infile
#' @export
load_mat <- function(infile){
  in.dt <- data.table::fread(infile, header = TRUE)
  in.dt <- in.dt[!duplicated(in.dt[, 1]), ]
  in.mat <- as.matrix(in.dt[, -1, with = FALSE])
  rownames(in.mat) <- unlist(in.dt[, 1, with = FALSE])
  in.mat
}
{% endhighlight %}

Once you've got your documentation completed, you can simply run:

{% highlight R %}
devtools::document()
{% endhighlight %}

This will generate the `load_mat.Rd` files in the man folder:

```
% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/load.R
\name{load_mat}
\alias{load_mat}
\title{Load a Matrix}
\usage{
load_mat(infile)
}
\arguments{
\item{infile}{Path to the input file}
}
\value{
A matrix of the infile
}
\description{
This function loads a file as a matrix. It assumes that the first column
contains the rownames and the subsequent columns are the sample identifiers.
Any rows with duplicated row names will be dropped with the first one being
kepted.
}
```

You will get one for each function in your R package.

> Each time you add new documentation to your R function, you need to run `devtools::document()` again to re-generate the .Rd files.

# What if my Package Requires Data for some Functions?

So what if some of your functions require data for them to work? For instance, in one of the [projects that I was involved in we produced a model that returned the scores that would indicate the risk of classical Hodgkin lymphoma patients for overall survival](http://www.ncbi.nlm.nih.gov/pubmed/23182984). I have subsequently worked on producing a companion R package, [CHL26predictor](https://github.com/tinyheero/CHL26predictor), for producing these scores. One of the things that my package required was the feature coefficients from the model so that I could generate the scores. These feature coefficients were sitting in a .tsv file and I want to get these values in my R package without having to hard-code the coefficients into my code.

Thankfully, there are some mechanisms to do this. Your data can exist in 3 locations in your R package folder: 1) data, 2) R/sysdata.rda, and 3) inst/extdata. I will discuss about 1) and 3) as I have used those both approaches. 

## Making Binary Data Available

The data folder is meant to store binary data (in .rda format) that is made available to users. The easiest way to do this use the `devtools::use_data()` function on whatever R object you have. For instance:

{% highlight R %}
x <- c(1:10)
devtools::use_data(x)
{% endhighlight %}

This ends up creating and saving the x object into data/x.rda. When you load up your package, the x variable will be available for you to use. You can this one step further, by actually providing the code that generated the binary data. To do this, the standard thing to do is create a `data-raw` folder. Then create a file .R file with the same name as your binary data. Inside this .R files, you put the exact same code as above. This gives you a record of how the binary data is generated.

You don't want to include these .R files in the actual R package. So what we do is place the `data-raw` folder into the `.Rbuildignore` file. This ensures that when we build and install the package (see below) we ignore the folder `data-raw`.

## Making Raw Data Available

Sometimes you actually need to make raw data available to users for your package. For instance, you may have some loading functions that you want to demonstrate. You'll need the raw (i.e. tsv files) to demonstrate how these functions work. The best way to do this is to put the raw data in the folder `inst/extdata`. When the package gets installed, the data becomes available through the `system.file()` function. For instance if I had the file  `inst/extdata/model-coef.tsv`, once the package is installed I can access this file by going:

{% highlight R %}
system.file("extdata", "model-coef.tsv", package = "myfirstpackage")
{% endhighlight %}

# Making Vignettes

Vignettes are extremely important to give people a high-level understanding of what your R package can. To get started with generating a vignette, you can use the `devtools::use_vignette()` function for this. For instance,

{% highlight R %}
devtools::use_vignette("introduction")
{% endhighlight %}

This will create a vignette/introduction.Rmd file. This is a vignette template Rmarkdown file that you can then use to fill out steps on how you can use your package. 

# How do I Install/Use My R Package?

Ok so that we have:

1. Our functions (.R files) the R folder
2. Documentation (.Rd) files in in the man folder
3. Data (binary and/or raw) in the data and inst/extdata 

How do we actually install and use our package? We can use the `devtools::load_all()` function which will load your R package into memory exposing all the functions and data that we highlighted above. However as soon as you close your R session, the package will no longer be available.

To actually install your package, you use the `devtools::install()` function which installs your R package into your R system library. Then you will be able to load up your package with:

{% highlight R %}
library("myfirstpackage")
{% endhighlight %}

Along with all the data that comes with the package!

# How do I Distribute my R Package

There are several avenues in how you can distribute. The easiest way is to distribute it through Github right now. There is a set of core files you need to have committed. An example of something basic can be my [tinyutils R package](https://github.com/tinyheero/tinyutils). The core files are the following: 

* R/\*.R files 
* man/\*.Rd files
* DESCRIPTION
* NAMESPACE

If you have data, you can also add those files to the repository. Once this is all done and you've pushed it to GitHub, anyone can install it using the following command:

{% highlight R %}
devtools::install_github("yourusername/myfirstpackage")
{% endhighlight %}

That's it! Now anyone can use your wonderful package! 

## What about My Vignettes? 

So how should you make your vignettes available to the public? What I've done is commit both the .rmd and generated .html file to my GitHub repository. GitHub won't directly render the .html file, but you can use the [GitHub HTML Preview service](http://htmlpreview.github.io/). Basically, you just give it the url of your html file from your GitHub and it will render. For instance, here is the preview of my html vignette:

[http://htmlpreview.github.io/?https://github.com/tinyheero/CHL26predictor/blob/master/vignettes/introduction.html](http://htmlpreview.github.io/?https://github.com/tinyheero/CHL26predictor/blob/master/vignettes/introduction.html)

# Summary and What's Next?

Hopefully this post has inspired you to get started on your first R package. I strongly believe putting your functions in R packages is the optimal way to maintain your code as well as distribute it. As I mentioned in the beginning of the post, there are so many times where I've had to search all over the place to look for a function that I'd written a while ago; Only to give up and just re-write it. By investing a bit more time in packaging your code into R packages, you gain at least these benefits:

1. A central location where you know your R functions are (instead of being scattered across all sorts of .R files all over your system)
1. A consistent documentation of your code (hands up if you've written a function and then came back 1 week later and asked yourself "what does this function do again?)
1. Version control.
1. Ability to easily distribute your code to others and for scientific publications.

If you've made it to the end of this post, and are wondering what's next? Then a few things that I would suggest are:

1. READ [Hadley Wickham's "R packages"](http://r-pkgs.had.co.nz/). As mentioned at the beginning, this is the most comprehensive resource on making R packages. It will cover everything mentioned in this post and much more in far greater detail. 
1. Think about taking your package to the next step and submit your R packages to popular central hubs like [CRAN](https://cran.r-project.org/) or Bioconductor (bioinformatics R packages).

# Miscellaneous 

There was recently a twitter thread about using ["pipes"](https://cran.r-project.org/web/packages/magrittr/index.htm) in R functions. 
