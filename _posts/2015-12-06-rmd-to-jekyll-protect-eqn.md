---
layout: post
title:  "R Markdown to Jekyll: \"Protecting\" Your Math Equations"
tags: [rmarkdown, mathjax, R]
---

In some of the posts I've written in my blog (e.g. [Using Mixture Models for Clustering in R]({% post_url 2015-10-13-mixture-model %})), I've first written them in R markdown and used [knitr](http://yihui.name/knitr/) to convert them into a markdown file to be subsequently processed by Jekyll. Nicole White made a [fantastic post on how to publish an R markdown file for a Jekyll blog](http://nicolewhite.github.io/2015/02/07/r-blogging-with-rmarkdown-knitr-jekyll.html) and this is what helped me at first. 
 
One aspect that isn't mentioned is whether math equations, rendered using MathJax, will work in a Jekyll. As it turns out, it's not super straightforward and often doesn't render. **The fundamental problem is that Jekyll markdown parsers will first attempt to parse the equations which often messes them up before MathJax can intepret them**. The problem is further complicated by the fact that different Jekyll markdown parsers will handle the equation blocks slightly differently.

One solution would be to knit your R markdown to markdown and then **manually** edit the markdown to fix any issues that may prop up when Jekyll processes it. But this would mean if I re-knitted the R markdown, I would have to manually re-apply those changes to the corresponding markdown again. Striving to be lazy, I spent a bit of time trying to figure out how I could write and seamlessly transfer my R markdown, and importantly my equations, to Jekyll without any manual editing.

This post will explain how to setup your R markdown and Jekyll site to handle the rendering of math equations. The instructions below have been tested to work with the Jekyll redcarpet markdown parser, but these principles should extend to other parsers.

# Step 1: Add the MathJax Javascript Library

The first thing you need to do is add the MathJax javascript library to your Jekyll site. You'll need to find in your Jekyll site where the html head is defined (for me this was `_includes/head.html` and add the following line of code to it.

~~~html
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
~~~

This makes it so that the MathJax javascript library is loaded on your Jekyll site.

# Step 2: "Protecting" Your Display Equations

In R markdown, to write a display equation you would use:

~~~
$$f(x) = \sum_{k=1}^{K}\alpha_{k}$$
~~~

Depending on your Jekyll markdown parser, this may or may not render in your Jekyll website. For instance, if your markdown parser is kmarkdown (default) then this would render like this:

$$ f(x) = \sum_{k=1}^{K}\alpha_{k} $$

But if your parser is redcarpet with no extensions, then this will NOT render (NOTE: if you enable the `no_intra_emphasis` extension for redcarpet then it will work). 

The issue is because the markdown parser tries to parse it and ends up messing up the output. The best way to get around this to work for all markdown parsers is to "protect" your display equations by wrapping them in a `<div>` block as suggested in this [thread](http://stackoverflow.com/questions/10987992/using-mathjax-with-jekyll):

~~~
<div>
$$f(x) = \sum_{k=1}^{K}\alpha_{k}$$
</div>
~~~

Doing this makes it so that the markdown parser doesn't try to parse these display equations before MathJax.

# Step 3: "Protecting" Your Inline Equations

Inline equations are bit trickier to get working. In R markdown, you would write an inline equation like this:

~~~
$f(x) = \sum_{k=1}^{K}\alpha_{k}$
~~~

This won't render because MathJax does not recognize the tag `$...$` at all and thus doesn't try to parse them. After scouring the internet, I found this [resource (section 5)](http://blog.hupili.net/articles/site-building-using-Jekyll.html) that provides a bit of insight into how to get around this.

The strategy is to use [jQuery](https://jquery.com/) to recognize these inline equations and then specifically get MathJax to re-typeset them. To get jQuery to recognize these inline equations, you can wrap the inline equations in some unique inline identifier:

~~~html
<span class="inlinecode">$f(x) = \sum_{k=1}^{K}\alpha_{k}f_{k}(x)$</span>
~~~

Here I wrapped the inline equation using an html span element with the css class inlinecode. Next, I [downloaded jQuery](http://jquery.com/download/) (specifically jquery-1.11.3.min.js for me) and then added this file to my Jekyll site at `js/jquery-1.11.3.min.js`. Then I added a javascript file, `js/jq_mathjax_parse.js` that used jQuery to perform the re-typesetting ([this is a modified version of the code listed here)](https://github.com/hupili/blog/blob/3662d015ad8c169ea2a5352a053d974c9697ebd9/assets/themes/twitter-hpl/custom/jq_mathjax_parse.js).

~~~js
$(document).ready(function(){
  $(".inlinecode").map(function(){
    match = /^\$(.*)\$$/.exec($(this).html());
    if (match){
      $(this).replaceWith("\\(" + match[1] + "\\)");
      MathJax.Hub.Queue(["Typeset",MathJax.Hub,$(this).get(0)]);
    }
  });
});
~~~

What happens is that the javascript will look for html elements with the css class inlinecode, retrieve the value inside the element, and then re-typeset it. With the the `js/jquery-1.11.3.min.js` and `js/jq_mathjax_parse.js` javascript files saved in their proper location, I added these two files to my `_includes/head.html` file. This means the `_includes/head.html` file should have 3 additional lines now (including the line added in Step 1: Add the MathJax Javascript Library):

~~~
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/javascript" src={{ "{{ '/js/jquery-1.11.3.min.js' | prepend: site.baseurl "}}}}></script>
<script type="text/javascript" src={{ "{{ '/js/jq_mathjax_parse.js' | prepend: site.baseurl "}}}}></script>
~~~

# Step 4: Setup the "no_intra_emphasis" extension

For the redcarpet markdown parser, you will also need to set the "no_intra_emphasis" extension in your `_config.yml` file:

~~~yaml
markdown: redcarpet
redcarpet:
    extensions: ["no_intra_emphasis"]
~~~

This ensures that underscores "\_" in your equations will not generate `<em>` tags which causes problems for MathJax.

# Step 5: Knit your R Markdown to Markdown

Once you've wrapped your equations properly and setup your javascript files, you are now ready to knit your R markdown into a markdown. I ended up following the instructions posted by [Nicole White](http://nicolewhite.github.io/2015/02/07/r-blogging-with-rmarkdown-knitr-jekyll.html) to do this. How I like to do this is to have a `_rmd` folder which contains all the R markdown documents that I have and a script called `r-to-jekyll.R`. This script contains the following contents (taken from [Nicole White's post](http://blog.hupili.net/articles/site-building-using-Jekyll.html)):

~~~r
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
~~~

What this does is it will knit a R markdown file (.Rmd), given as the first arugment, into a markdown (.md) and place the output file into the `_posts` directory with the current date as a prefix. Importantly, it will leave all the "equation wrappers" in place so that the Jekyll markdown parser won't touch them. It will additionally copy all the images it generates into the `assets` folder so that the post is ready to go.

And that's it! If you follow these instructions, you should be able (at least with redcarpet as your Jekyll markdown parser) to seamlessly transfer all your math equations in R markdown into a markdown file for Jekyll! 

# References

* [Blogging About R Code with R Markdown, Knitr, and Jekyll](http://nicolewhite.github.io/2015/02/07/r-blogging-with-rmarkdown-knitr-jekyll.html)
	* Nicole White's post that got me started on how to convert my R markdown for Jekyll. The `r-to-jekyll.R` script that I highlighted was taken from this blog post.
* [Mathjax with Jekyll](http://gastonsanchez.com/blog/opinion/2014/02/16/Mathjax-with-jekyll.html)
	* Good instructions on how to get MathJax working with Jekyll.
* [Stack Overflow question regarding underscores in equations](http://stackoverflow.com/questions/10759577/underscore-issues-jekyll-redcarpet-github-flavored-markdown)
* [Site Building Using Jekyll](http://blog.hupili.net/articles/site-building-using-Jekyll.html)
	* How I got inline equations working. In particular, the [original piece of javascript code.](https://github.com/hupili/blog/blob/3662d015ad8c169ea2a5352a053d974c9697ebd9/assets/themes/twitter-hpl/custom/jq_mathjax_parse.js)
