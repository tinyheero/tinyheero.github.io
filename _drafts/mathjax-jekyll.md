---
layout: post
title:  "Maintaining Math Equations when Converting a Rmarkdown Document for a Jekyll Blog"
tags: [rmarkdown, mathjax]
---

In some of the posts I've written in my blog (e.g. [Using Mixture Models for Clustering in R]({% post_url 2015-10-13-mixture-model %})) I've first written them in rmarkdown and then converted them into a markdown file to be subsequently processed by jekyll. Nicole White made a [fantastic post on how to publish an rmarkdown file for a jekyll blog](http://nicolewhite.github.io/2015/02/07/r-blogging-with-rmarkdown-knitr-jekyll.html) and this is what helped me at first. 

One aspect that isn't mentioned is how to get the math equations specified in rmarkdown rendered in a jekyll site. This post will attempt to address this issue.

# Step 1: Add the Mathjax Javascript Library

The first thing you need to do is add the Mathjax javascript library to your jekyll site. You'll need to find in your jekyll site where the html head is defined and add the following line of code to it.

```
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
```

This makes it so that the Mathjax javascript library is loaded on your jekyll site.

# Step 2: "Protecting" Your Display Equations

. **The fundamental problem is that jekyll markdown parsers will first attempt to parse the equations which often messes them up before MathJax can intrepret them**. The problem is further complicated by the fact that different jekyll markdown parsers will handle the equation blocks slightly different. 



In rmarkdown, to write a display equation you would use:

```
$$ f(x) = \sum_{k=1}^{K}\alpha_{k} $$
```

Depending on your jekyll markdown parser, this may or may not render in your jekyll website. For instance, if your markdown parser is kmarkdown (default) then this would render like this:

$$ f(x) = \sum_{k=1}^{K}\alpha_{k} $$

But if your parser is redcarpet with no extensions, then this will not render (NOTE: if you enable the `no_intra_emphasis` extension for redcarpet then it will work). 

The issue is because the markdown parser tries to parse it and ends up messing up the output. The best way to get around this to work for all markdown parsers is to "protect" your display equations by wrapping them in a `<div>` block as suggested in this [thread](http://stackoverflow.com/questions/10987992/using-mathjax-with-jekyll):

```
<div>
$$ f(x) = \sum_{k=1}^{K}\alpha_{k} $$
</div>
```

Doing this makes it so that the markdown parser doesn't try to parse these display equations before MathJax.

# Step 3: Using Jquery for Inline Equations

Inline equations are bit trickier to get working. In rmarkdown, you would write an inline equation like this:

```
$f(x) = \sum_{k=1}^{K}\alpha_{k}$
```

This won't render because Mathjax does not recognize the tag `$...$` at all and thus doesn't try to parse them. After scouring the internet, I found this [resource](http://blog.hupili.net/articles/site-building-using-Jekyll.html) that provides a bit of insight into how to get around this.

What we can do is use jquery to recognize these inline equations and then specifically get Mathjax to re-typeset them for us. What we can do is wrap our inline equations in some unique inline identifier like:

```
<span class="inlinecode">$f(x) = \sum_{k=1}^{K}\alpha_{k}f_{k}(x)$</span>
```

Here we have wrapped out equation 

Now we need to get jquery to recognize all the values wrapped in 

Rather for inline 


Several 

Once you knit your rmarkdown to a markdown file, the 

 me, I added the following line of code to my `_includes/head.html` file.


And then for inline equations we would use:

```
$ equation $
```

If you were to convert the rmarkdown to a markdown, the markdown parser you are using (redcarpet for my case) will try to parse it and end up messing with it. For instance, if you are markdown parser is kmra

Depending on your markdown parser, The end result is that 

I am not the only person to encounter such issues:


I was able to find a solution by doing the following

#

# References

* http://gastonsanchez.com/blog/opinion/2014/02/16/Mathjax-with-jekyll.html
* http://stackoverflow.com/questions/10759577/underscore-issues-jekyll-redcarpet-github-flavored-markdown
* https://github.com/hupili/blog/blob/3662d015ad8c169ea2a5352a053d974c9697ebd9/assets/themes/twitter-hpl/custom/jq_mathjax_parse.js
* http://blog.hupili.net/articles/site-building-using-Jekyll.html
