---
layout: post
title:  "Making Your First R Package"
date:   
categories: jekyll update
---

This post is inspired by a hilarious tweet that David Robinson made:

<blockquote class="twitter-tweet" data-partner="tweetdeck"><p lang="en" dir="ltr">&quot;I wish I&#39;d left this code across scattered .R files instead of combining it into a package&quot; said no one ever <a href="https://twitter.com/hashtag/rstats?src=hash">#rstats</a> <a href="http://t.co/udeNH4T67H">http://t.co/udeNH4T67H</a></p>&mdash; David Robinson (@drob) <a href="https://twitter.com/drob/status/611885584584441856">June 19, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

I finally decided it was time to take the next step and start wrapping all my utility functions, that are scattered across numerous .R files, into R packages that were are well-documented. There are wonderful resources that already exist to explain how to make your first R package. For instance:

* [Hilary Parker's "Writing an R package from scratch"](http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/) - This was the resource that helped me get started on making my first R package. It involves you creating your R package from bare bones and is a fantastic introduction.  
* [Hadley Wickham's "R packages"](http://r-pkgs.had.co.nz/) - This is the most comprehensive resource of how to generate an R package. 

This post, aims to be "in-between" these two resources. Giving a slightly more detailed explanation on creating packages from scratch while not going into the great depth that "R packages" does. 

You'll benefit from this post, if you've read Hilary Parker's post but what to know about details such as:

* How do I add external package dependencies?
* Where do I put data that my package needs?

This will be a primer on these details without going into the extensive depth in "R packages".

RStudio provides a great interface for creating R packages. However I am not a RStudio user (vim and vimrplugin suits all my needs), thus I will be showing how everything works in the R console and the specific code to use (which I assume is what RStudio is running for you in the background). 

# Setup

Hadley Wickham's has provided the R community with [devtools](https://cran.r-project.org/web/packages/devtools/index.html) which is an R package that helps us build R packages. We will need to install this package if you want to make your life easier:

```{r}
install.packages("devtools")
```

At the time of this post, I am using devtools version 1.7.0.

# Creating the Framework for your First Package

The first thing you want to do is create the framework for your R package, we can do this using devtools:
	
```{r}
devtools::create("myfirstpackage")
```

This ends up creating a folder with the same name as your package name with 4 files inside the folder:

* DESCRIPTION: This is where all the meta-data about your package goes. Rather than try to explain the contents, I will refer you to [Hadley's detailed explanation on the contents of this file](http://r-pkgs.had.co.nz/description.html)
* myfirstpackage.Rproj: This is a RStudio specific file. As I do not use RStudio, I will not comment on this file as I never use it.
* NAMESPACE: In short, this file indicates needs to be exposed to users or not. From my experience, I've never edited this file as devtools takes care of the changes as you'll see below. 
* R: This is where all your R code goes for your package.

You now have the bare bones of your first R package. So let's start adding some functions!

# How do I Add My R Functions?

All your R functions that you want in your R package belong in the R directory. You can create an .R file that has the same name as the function you want in it. For instance, let's create a file called `touch R/load_mat.R` and add the following content to the file:

```{r}
load_mat <- function(infile){
  in.dt <- data.table::fread(infile, header = TRUE)
  in.dt <- in.dt[!duplicated(in.dt[, 1]), ]
  in.mat <- as.matrix(in.dt[, -1, with = FALSE])
  rownames(in.mat) <- unlist(in.dt[, 1, with = FALSE])
  in.mat
}
```

This is a simple function that takes in a file and convert it into a matrix with the proper column and row names based on the format of the in file. Each .R file can have multiple functions in them. So:

```{r}
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
```

In general, try to group together related functions into the same .R file (e.g. if you have a bunch of loading functions then putting them in load.R would be a good idea). 

## External Dependencies

You'll see that the `load_mat()` function actually depends on the data.table::fread() function to read in files super quickly. Notice how I did NOT do something like this:

```{r}
library("data.table")
load_mat <- function(infile){
  in.dt <- fread(infile, header = TRUE)
  in.dt <- in.dt[!duplicated(in.dt[, 1]), ]
  in.mat <- as.matrix(in.dt[, -1, with = FALSE])
  rownames(in.mat) <- unlist(in.dt[, 1, with = FALSE])
  in.mat
```

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

## How do I Document My Functions?


 
# Miscellaneous 

There was recently a twitter thread about using ["pipes"](https://cran.r-project.org/web/packages/magrittr/index.htm) in R functions. 
 
	

