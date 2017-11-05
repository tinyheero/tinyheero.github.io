---
layout: post
title:  "Making Your Personal Vim Cheatsheet"
date:   2017-11-04 
tags: [vim]
---

First off, major credit goes to Matt Butcher ([@technosophos](https://twitter.com/technosophos)) 
and his original post on creating [Vim cheatsheets](http://technosophos.com/2014/10/09/create-built-in-Vim-cheatsheet.html). 
This post is to follow-up on this concept and how I got it to work with my 
setup.

## What is the Vim cheatsheet and why?

The basic idea around this is you want to be able to have your own personal Vim 
cheatsheet that pops up when you type:

```
:h myhelp
```

You should then get something like this:

![myhelp cheatsheet]({{ site.url }}/assets/vim-cheatsheets/cheatsheet.png)

**The main advantage of this is that your cheatsheet is now directly "embedded" 
into Vim and you can easily bring it up anytime!** So for those, like me, who 
often forget how to do "X" and "Y", it is super handy to be able to bring up a
cheatsheet to remind yourself how to do it.

If you have tags setup properly, you'll be able to jump to certain section in 
the cheatsheet. For instance, when I type `:h myhelp-config-reload` it jumps 
me to:

![myhelp config reload]({{ site.url }}/assets/vim-cheatsheets/myhelp-config-reload.png)

## How to set it up

In Matt's original post, he instructed that one can simply add the directory to 
a location that Vim searches plugins for and it should work. Since I use 
[vim-plug as my plugin manager](https://github.com/junegunn/vim-plug), I thought 
it would be a better idea to just integrate it as a full plugin along with the 
[rest of my setup](https://github.com/tinyheero/dotfiles/blob/master/nvim.init).

To this end, I forked [Matt's original repository](https://github.com/technosophos/vim-myhelp) 
to form my own [vim-myhelp repository](https://github.com/tinyheero/vim-myhelp).
Then in my Vim config file located `~/.config/nvim/init.vim` I added the 
following (NOTE: Neovim's config file is in different location thatn Vim):

```
Plug 'tinyheero/vim-myhelp' " Personal vim-cheatsheet
```

In the appropriate plugin section (See my [configuration file](https://github.com/tinyheero/dotfiles/blob/master/nvim.init) 
for the context). After this I reloaded the configuration file, then installed
cheatsheet plugin (`:PlugInstall`).

After this, I was able to bring up my personal cheatsheet with `:h myhelp`!

## How to edit the cheatsheet and setup tags

The cheatsheet/plugin is stored at `~/.config/nvim/plugged/vim-myhelp`
(this will be dependent on your Vim setup and where you set plugins to be installed).
The first thing to note is that the repository is setup to mimic the structure
of a Vim plugin. The actual cheatsheet is located in at `doc/myhelp.txt`. 

The format of this file should adhere to the [Vim help text syntax](http://vimdoc.sourceforge.net/htmldoc/helphelp.html).
You can also bring up help on the help syntax by typing `:h helphelp`! (The
section "3. Writing help files" is where a description of how to write these
files starts"). The only additional thing to mention is that you can setup tags
by surrounding a label with asterisks. For instance, in my cheatsheet I had the
tag: 

```
*myhelp-config-reload*
```

This is what allowed me to jump to this "section" when I ran 
`:h myhelp-config-reload`.

Another neat thing you can do is setup a hot-link by including any tags in 
bars (|). For example:

```
|myhelp-config-reload|
```

Any edits to the file will be immediately reflected once you restart Vim and 
open the cheatsheet again. If you add new tags, you will need to rebuild the 
tag file by using the command:

```
:helpt ~/.config/nvim/plugged/vim-myhelp
```

## Conclusions

You can find my cheatsheet in my [vim-myhelp GitHub repo](https://github.com/tinyheero/vim-myhelp).
Hopefully this post gives you some insights into how I setup my personal VIM
cheatsheet. Now you will always have a quick way to bring up stuff you always 
forget in Vim!
