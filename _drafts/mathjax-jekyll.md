---
layout: post
title:  ""
---

In some of the posts I've written in my blog, I've first written them in rmarkdown and then converted them into a markdown file to be subsequently processed by jekyll. Nicole White made a [fantastic post on how to publish an rmarkdown file for a jekyll blog](http://nicolewhite.github.io/2015/02/07/r-blogging-with-rmarkdown-knitr-jekyll.html) and this is what helped me at first. 

One aspect that isn't mentioned is how rmarkdown equations (rendered with Mathjax) don't work out of the box. This post will cover how you can get your rmarkdown latex equations working in jekyll.

# Add Mathjax Javascript

The first thing you need to do is add the Mathjax javascript to your jekyll site. You'll need to find in your jekyll site where the head is defined and add the following line of code to it.

```
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
```

# Getting Display Equations to Render

In rmarkdown, to write a display equation you would use:

```
$$ f(x) = \sum_{k=1}^{K}\alpha_{k} $$
```

Depending on your jekyll markdown parser, this may or may not render in your jekyll website. For instance, if your markdown parser is kmarkdown (default) then you will have no problems. But if your parser is redcarpet, then this will not render. The issue is because the markdown parser tries to parse it and messing up the output. The best way to get around this to work for all markdown parsers is to "protect" your display equations by wrapping them in a `<div>` block:

```
<div>
$$ f(x) = \sum_{k=1}^{K}\alpha_{k} $$
</div>
```

# Getting Inline Equations to Render

Inline equations are bit trickier to get working. In rmarkdown, you would write an inline equation like this:

```
$f(x) = \sum_{k=1}^{K}\alpha_{k}$
```

This won't render because Mathjax does not recognize `$...$`. Rather for inline 





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

* http://nicolewhite.github.io/2015/02/07/r-blogging-with-rmarkdown-knitr-jekyll.html
* http://gastonsanchez.com/blog/opinion/2014/02/16/Mathjax-with-jekyll.html
* http://stackoverflow.com/questions/10759577/underscore-issues-jekyll-redcarpet-github-flavored-markdown
* https://github.com/hupili/blog/blob/3662d015ad8c169ea2a5352a053d974c9697ebd9/assets/themes/twitter-hpl/custom/jq_mathjax_parse.js
* http://blog.hupili.net/articles/site-building-using-Jekyll.html
