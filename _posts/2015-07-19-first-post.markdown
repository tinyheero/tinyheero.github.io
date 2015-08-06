---
layout: post
title:  "Creation of My Blog!"
date:   2015-07-19 19:53:02
categories: jekyll update
---

Welcome to the first post in my newly created blog! Looking forward to blogging about my adventures in bioinformatics, cancer, and big data research. The creation of this blog was done by using [jekyll](http://jekyllrb.com/) which provides a nice and easy way to get started with a static website that is blog-aware. All the content for this website is hosted on [github](https://github.com/tinyheero/tinyheero.github.io).

I followed the instructions posted kindly by [James Huang on his blog](http://growthalytics.com/programming/2015/07/19/setting-up-your-own-blog/).

# Adding Comments

The comments are through [Disqus](https://disqus.com/). I followed the [instructions here to do this](http://www.perfectlyrandom.org/2014/06/29/adding-disqus-to-your-jekyll-powered-github-pages/). In brief,

1. Register a site with Disqus using [https://disqus.com/websites/](https://disqus.com/websites/)
1. Grab the "universal code" and add that to a `_includes/disqus.html`
1. Then add `{{ "{% include disqus.html" }}%}` to `_layouts/post.html`. I added it right after `{{ "{{ content" }}}}`. 

By doing this, this makes the Disqus comments appear on every post. You can also add them to other `_layout/*.html` pages in the future. 

Also for escaping the liquid template tags (i.e. include disqus.html} so that they can appear in this post, refer to this [stackoverflow thread](http://stackoverflow.com/questions/3426182/how-to-escape-liquid-template-tags).

# Adding Tags

I follow the instructions posted kindly by [Charlie Park's "Tags in Jekyll"](http://charliepark.org/tags-in-jekyll/) to setup tags in Jekyll.
