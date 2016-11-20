---
layout: post
title:  "Creation of My Site/Blog!"
date:   2015-07-19 19:53:02
categories: jekyll update
---

Welcome to the first post in my newly created site/blog! Looking forward to blogging about my adventures in bioinformatics, cancer, and big data research. The creation of this blog was done by using [jekyll](http://jekyllrb.com/) which provides a nice and easy way to get started with a static website that is blog-aware. All the content for this website is hosted on [github](https://github.com/tinyheero/tinyheero.github.io).

I followed the instructions posted kindly by [James Huang on his blog](http://growthalytics.com/programming/2015/07/19/setting-up-your-own-blog/). Below are details on how I got some additional features working on my site.

<ul data-toc="body" data-toc-headings="h2,h3"></ul>

## Adding Comments

The comments are through [Disqus](https://disqus.com/). I followed the [instructions here to do this](http://www.perfectlyrandom.org/2014/06/29/adding-disqus-to-your-jekyll-powered-github-pages/). In brief,

1. Register a site with Disqus using [https://disqus.com/websites/](https://disqus.com/websites/)
1. Grab the "universal code" and add that to a `_includes/disqus.html`
1. Then add `{{ "{% include disqus.html" }}%}` to `_layouts/post.html`. I added it right after `{{ "{{ content" }}}}`. 

By doing this, this makes the Disqus comments appear on every post. You can also add them to other `_layout/*.html` pages in the future. 

Also for escaping the liquid template tags (i.e. include disqus.html} so that they can appear in this post, refer to this [stackoverflow thread](http://stackoverflow.com/questions/3426182/how-to-escape-liquid-template-tags).

## Adding Tags

I followed the instructions posted at [http://www.minddust.com/post/tags-and-categories-on-github-pages/](http://www.minddust.com/post/tags-and-categories-on-github-pages/) for generating plugin-free tags. I had to go plugin-free because this blog is hosted on Github pages. 

For a plugin version of tags, I would recommend following the instructions posted kindly by [Charlie Park's "Tags in Jekyll"](http://charliepark.org/tags-in-jekyll/).

## Adding Math Equations

For adding math equations, this [excellent blog post covers how it can be done](http://gastonsanchez.com/opinion/2014/02/16/Mathjax-with-jekyll/). 

For some of my posts (e.g. ["Using Mixture Models for Clustering in R"]({% post_url 2015-10-13-mixture-model %})), I first write them in Rmarkdown and then convert them into markdown. I made a separate post called ["R Markdown to Jekyll: "Protecting" Your Math Equations"]({% post_url 2015-12-06-rmd-to-jekyll-protect-eqn %}) that discusses how I did this.

## Adding Table of Contents

If you are using Kramdown as your markdown parser, then [Sean Buscay has posted a solution for this already](http://www.seanbuscay.com/blog/jekyll-toc-markdown/). 

But since I am using redcarpet, this solution was applicable to me. Thankfully, I was able to find the [Table of Contents jQuery Plugin](http://ndabas.github.io/toc/). After downloading the latest release, unzipping resulted in two javascript files:

* jquery.toc.js
* jquery.toc.min.js

I put both of these javascript in the `js` folder. Then in my `_includes/head.html` file, I added the following line of code:

```
<script type="text/javascript" src={{ "{{ '/js/jquery.toc.min.js' | prepend: site.baseurl "}}}}></script>
```

This makes it so that this javascript is loaded on each post. Now in your posts, place the following piece of code where you want the table of contents to be:

```{html}
<ul data-toc="body" data-toc-headings="h2,h3"></ul>
```

In this case, any `h2` or `h3` headers will appears in the table of contents. 

## Adding Google Analytics

I followed the simple instructions ["Google Analytics for Jekyll"](https://desiredpersona.com/google-analytics-jekyll/) to add google analytics in just a few minutes!

#### Updates

* Nov 19, 2016 - Added section on "Adding Google Analytics"
* Jan 12, 2016 - Added instructions on how I got math equations and table of contents to appear in my posts.
