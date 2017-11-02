---
layout: post
title:  "Making Your Personal VIM Cheatsheet"
tags: [vim, cheatsheet]
---

First off, all credit goes to Matt Butcher ([@technosophos](https://twitter.com/technosophos)) 
and his original post on creating [vim cheatsheets](http://technosophos.com/2014/10/09/create-built-in-vim-cheatsheet.html). 
This post is really to follow-up on this concept and how I got it to work with my setup.

# What is the VIM cheatsheet and why?

The basic idea around this is you want to be able to have your own personal vim 
cheatsheet that pops up when you type:

```
:h myhelp
```

You should then get something like this:

[Image showing my snippet].

The main advantage of this is that your cheatsheet is now directly "embedded" 
into vim and you can easily bring it up anytime! So for those, like me, who 
often forget how to do "X" and "Y", it is super handy to be able to bring up a
cheatsheet to remind yourself how to do it.

# How to set it up

In Matt's original post, he instructed that one can simply add the directory to 
a location that Vim searches plugins for and it should work. Since I use 
vim-plug as my plugin manager, I thought it would be a better idea to just 
integrate it as a full plugin along with the [rest of my setup](https://github.com/tinyheero/dotfiles/blob/master/nvim.init).

To this end, I forked [Matt's original repository](https://github.com/technosophos/vim-myhelp) 
to form my own vim-myhelp [repository](https://github.com/tinyheero/vim-myhelp).
The first thing to note is that the repository is setup to mimic the structure
of a vim plugin.  The actual cheatsheet is located at `doc/myhelp.txt`. The 
format of this file adheres to..

* 

