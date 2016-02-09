---
layout: post
title:  "Working with Git Submodules"
date:   2015-08-12 09:28:00
tags: [git]
---

Git submodules provide a nifty way to integrate a git repository within a git repository. The first time I encountered git submodules was when I was browsing [Heng Li's fermikit git repository](https://github.com/lh3/fermikit).

![Screenshot of fermikit on github]({{ site.url }}/assets/fermikit-github.png)

Notice how the files have a @ symbol folowed by some random value. This actually indicates a git submodule within this git repository. For instance, the bfc file is actually a folder containing the [bfc git repository](https://github.com/lh3/bfc). The seemingly random value after the @ symbol is a git hash that indicates a specific commit of the bcf git repository. This basically means this current commit of fermikit depends on the "a73dad2" commit of the bcf repository.

While this may seem fairly sophisticated, it's actually not too difficult to get this kind of setup for your own git repository. This post will provide a primer on how to get started with using git submodules. 

# Setup

All the code in this post was performed with the following git version: 

~~~
git --version
git version 1.9.3 (Apple Git-50)
~~~

Let's first create some local git repositories just for demonstration purposes. 

1. Create the top-level git repository:

    ~~~bash
    mkdir ~/git-toplevel-repo
    cd ~/git-toplevel-repo
    git init
    ~~~

1. Create another git repository that will serve as the git submodule. 

    ~~~bash
    mkdir ~/git-submodule-repo
    cd ~/git-submodule-repo
    git init
    touch README
    git add README
    git commit -m "Adding README File"
    ~~~

# Adding Git Submodules

Adding a git submodule can be done using `git submodule add`. Let's use the git-toplevel-repo as the top-level repository and add the git-submodule-repo as the submodule:

~~~bash
cd ~/git-toplevel-repo
git submodule add ~/git-submodule-repo
~~~

This will create a folder with the same name as the repository name (i.e. git-submodule-repo) and also checkout the latest commit of the repository into this folder. If you now do a `git status`, you should see:

~~~
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

		new file:   .gitmodules
		new file:   git-submodule-repo
~~~

The git-submodule-repo folder has been added and already staged. Additionally, you will notice how a .gitmodules file has been added. If you do a `cat .gitmodules`

~~~
[submodule "git-submodule-repo"]
  path = git-submodule-repo
  url = /Users/fcchan/git-submodule-repo
~~~

This file will actually contain information regarding all the submodules that you have add to your git repository. Let's do a quick `git commit` now so that we can move onto the next section:

~~~
git commit -m "First Commit"
~~~

# Managing Your Git Submodules

So what happens when your git submodule changes? For instance, if you go into the git-submodule-repo and add a file:

~~~bash
cd ~/git-submodule-repo
touch TEST
git add TEST
git commit -m "Adding TEST"
~~~

Now, if you enter the submodule folder from the top-level git repository and run: 

~~~
cd ~/git-toplevel-repo/git-submodule-repo
git pull

remote: Counting objects: 3, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 2 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (2/2), done.
From /Users/fcchan/git-submodule-repo
   ebba154..d931029  master     -> origin/master
Updating ebba154..d931029
Fast-forward
 TEST | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 TEST
~~~

You will see that the TEST file is added. Now if you go to the top-level git repository folder and run `git status`:

~~~
cd ~/git-toplevel-repo
git status

On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   git-submodule-repo (new commits)
~~~

Git is able to identify that the git submodule has new commits to it and indicates this to you. In order to indicate that your top-level git repository should reference this specific commit of the submodule, you need to run `git add git-submodule-repo`. This ensures that if you were to clone this top-level repository (details of this below), then it will point to the git-submodule-repo commit that contains the TEST file. So let's do this:

~~~
git add git-submodule-repo
git commit -m "Updating Submodule Commit"
~~~

# Cloning a Git Repository with Git Submodules

Now let's experiment with cloning a git repository that contains a git submodule:

~~~
git clone ~/git-toplevel-repo ~/git-clone-test
~~~

If you actually go into the `git-clone-test` folder, you will see the git-submodule-repo folder. **But it is empty! Where are my README and TEST files?**

This was counter-initutive to me the first time I did this, but the key is you need to first initialize the submodules and then run an update:

~~~
cd ~/git-clone-test
git submodule init
git submodule update
~~~

Now you should be able to see the TEST and README files in the git-submodule-repo folder.

# Summary

That's it! Hopefully, you now have the basics on how to get started with using git submodules

For a more detailed reference, I would recommend the following references:

* [Official Git Submodule Documentation](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
* [Git Submodules: Adding, Using, Removing, Updating - By Chris Jean](https://chrisjean.com/git-submodules-adding-using-removing-and-updating/)

