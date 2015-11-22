---
layout: post
title:  "Rendering Math Equations when Kniting a Rmarkdown for a Jekyll Site"
tags: [rmarkdown, mathjax]
---

In some of the posts I've written in my blog (e.g. [Using Mixture Models for Clustering in R]({% post_url 2015-10-13-mixture-model %})), I've first written them in rmarkdown and used [knitr](http://yihui.name/knitr/) to convert them into a markdown file to be subsequently processed by jekyll. Nicole White made a [fantastic post on how to publish an rmarkdown file for a jekyll blog](http://nicolewhite.github.io/2015/02/07/r-blogging-with-rmarkdown-knitr-jekyll.html) and this is what helped me at first. 
 
One aspect that isn't mentioned is whether math equations, rendered using Mathjax, will work in a jekyll site. As it turns out, it's not super straightforward and often doesn't render. **The fundamental problem is that jekyll markdown parsers will first attempt to parse the equations which often messes them up before MathJax can intepret them**. The problem is further complicated by the fact that different jekyll markdown parsers will handle the equation blocks slightly differently.

This post will explain how to setup your rmarkdown and jekyll site to handle the rendering of math equations. The instructions below have been tested to work for the jekyll redcarpet markdown parser, but the principle should extend to other parsers.

# Step 1: Add the Mathjax Javascript Library

The first thing you need to do is add the Mathjax javascript library to your jekyll site. You'll need to find in your jekyll site where the html head is defined and add the following line of code to it.

```{html}
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
```

This makes it so that the Mathjax javascript library is loaded on your jekyll site.

# Step 2: "Protecting" Your Display Equations

In rmarkdown, to write a display equation you would use:

```
$$ f(x) = \sum_{k=1}^{K}\alpha_{k} $$
```

Depending on your jekyll markdown parser, this may or may not render in your jekyll website. For instance, if your markdown parser is kmarkdown (default) then this would render like this:

$$ f(x) = \sum_{k=1}^{K}\alpha_{k} $$

But if your parser is redcarpet with no extensions, then this will NOT render (NOTE: if you enable the `no_intra_emphasis` extension for redcarpet then it will work). 

The issue is because the markdown parser tries to parse it and ends up messing up the output. The best way to get around this to work for all markdown parsers is to "protect" your display equations by wrapping them in a `<div>` block as suggested in this [thread](http://stackoverflow.com/questions/10987992/using-mathjax-with-jekyll):

```
<div>
$$ f(x) = \sum_{k=1}^{K}\alpha_{k} $$
</div>
```

Doing this makes it so that the markdown parser doesn't try to parse these display equations before MathJax.

# Step 3: Using "jQuery" for Inline Equations

Inline equations are bit trickier to get working. In rmarkdown, you would write an inline equation like this:

```
$f(x) = \sum_{k=1}^{K}\alpha_{k}$
```

This won't render because Mathjax does not recognize the tag `$...$` at all and thus doesn't try to parse them. After scouring the internet, I found this [resource (section 5)](http://blog.hupili.net/articles/site-building-using-Jekyll.html) that provides a bit of insight into how to get around this.

The strategy is to use [jQuery](https://jquery.com/) to recognize these inline equations and then specifically get Mathjax to re-typeset them for us. To get jQuery to recognize these inline equation, you can wrap the inline equations in some unique inline identifier:

```{html}
<span class="inlinecode">$f(x) = \sum_{k=1}^{K}\alpha_{k}f_{k}(x)$</span>
```

Here I wrapped the inline equation using an html span element with class inlinecode. Next, I [downloaded jQuery](http://jquery.com/download/) (specifically jquery-1.11.3.min.js for me) and then added this file to my jekyll site at `js/jquery-1.11.3.min.js`. Then I added a javascript file, `js/jq_mathjax_parse.js` that used jQuery to perform the re-typesetting ([this is modified code](https://github.com/hupili/blog/blob/3662d015ad8c169ea2a5352a053d974c9697ebd9/assets/themes/twitter-hpl/custom/jq_mathjax_parse.js).

```{js}
$(document).ready(function(){
  $(".inlinecode").map(function(){
    match = /^\$(.*)\$$/.exec($(this).html());
    if (match){
      $(this).replaceWith("\\(" + match[1] + "\\)");
      MathJax.Hub.Queue(["Typeset",MathJax.Hub,$(this).get(0)]);
    }
  });
});
```

Specifically, the javascript will look for html elements with the class inlinecode, retrieve what is inside the element, and then re-typeset it. With the `js/jquery-1.11.3.min.js` and `js/jq_mathjax_parse.js` javascript files, I next added these two files to my `_includes/head.html` file. This means `_includes/head.html` file should have 3 additional lines now (including the one before):

```{js}
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/javascript" src={{ "{{ '/js/jquery-1.11.3.min.js' | prepend: site.baseurl "}}}}></script>
<script type="text/javascript" src={{ "{{ '/js/jq_mathjax_parse.js' | prepend: site.baseurl "}}}}></script>
```

# Step 4: Setup the "no_intra_emphasis" extension

For the redcarpet markdown parser, you will also need to set the "no_intra_emphasis" extension in your `_config.yml` file:

```{yaml}
markdown: redcarpet
redcarpet:
    extensions: ["no_intra_emphasis"]
```

This ensures that underscores (\_) will not generate `<em>` tags which messes up the Mathjax

# Step 5: Knit your Rmarkdown to Markdown

Once you've wrapped your equations properly and setup your javascripts files, you are now ready to knit your Rmarkdown to a markdown. I ended up following the instructions posted by [Nicole White](http://nicolewhite.github.io/2015/02/07/r-blogging-with-rmarkdown-knitr-jekyll.html) to do this. How I like to do this is have a folder called `_rmd` which contains all the rmarkdown documents that I have and a script called `r-to-jekyll.R`. This script contains the contents (taken from Nicole White's post):

```{r}
#!/usr/bin/env Rscript
library("knitr")

# Get the filename given as an argument in the shell.
args = commandArgs(TRUE)
filename = args[1]

# Check that it's a .Rmd file.
if(!grepl(".Rmd", filename)) {
  stop("You must specify a .Rmd file.")
}

# Knit and place in _posts.
dir = paste0("../_posts/", Sys.Date(), "-")
output = paste0(dir, sub('.Rmd', '.md', filename))
knit(filename, output)

# Copy .png files to the images directory.
fromdir = "{{ site.url }}/assets"
todir = "../assets"

pics = list.files(fromdir, ".png")
pics = sapply(pics, function(x) paste(fromdir, x, sep="/"))
file.copy(pics, todir)

unlink("{{ site.url }}", recursive = TRUE)
```

What this does is it will knit a rmarkdown file (.Rmd), given as the first arugment, into a markdown (.md) and place the output file into the `_posts` directory with the current date as a prefix. Importantly, it will leave all the "equation wrappers" in place so that the jekyll markdown parser won't touch them. It will additionally copy all the images it generates into the `assets` folder so that the post is ready to go.

# References

* http://gastonsanchez.com/blog/opinion/2014/02/16/Mathjax-with-jekyll.html
* http://stackoverflow.com/questions/10759577/underscore-issues-jekyll-redcarpet-github-flavored-markdown
* https://github.com/hupili/blog/blob/3662d015ad8c169ea2a5352a053d974c9697ebd9/assets/themes/twitter-hpl/custom/jq_mathjax_parse.js
* http://blog.hupili.net/articles/site-building-using-Jekyll.html
