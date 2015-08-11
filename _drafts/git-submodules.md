---
layout: post
title:  "Working with Git Submodules"
---

# High-Level Post Summary

* Introduction to what a git submodule is
* Learn how to work with git submodules

Git submodules provide a nifty way to integrate a git repository within a git repository. The first time I encountered git submodules was when I was browsing [Heng Li's fermikit git repository](https://github.com/lh3/fermikit).

![Screenshot of fermikit on github]({{ site.url }}/assets/git-submodules/fermikit-github.png)

Notice how the files have a @ symbol folowed by some random value after. This actually indicates a git submodule within this git repository. For instance, the bfc file is actually a folder containing the [bfc git repository](https://github.com/lh3/bfc). The seemingly random value after the @ symbol is a git hash that indicates a specific commit of the bcf git repository. You can intepret this as meaning this commit of fermikit depends on the "a73dad2" commit of the bcf repository.

This post will provide a short introduction into how to use git submodules. For a more detailed reference, I refer you to the [official git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) page.

Ok so let's see how we can actually add git submodules to our git repository.

# Adding Git Submodules

Adding a git submodule can be done using the following command:

```
git submodule add /url/to/git/repo my-git-submodule
```

This will create a folder called 


Using git submodules provides a great way of including 
