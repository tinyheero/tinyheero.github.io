---
layout: post
title:  "TiddlyWiki: My Step"
tags: [bioinfo, kallisto]
---

## Introduction

Every once in a while, I encounter something in my life that makes me say "Wow,
this is the greatest thing since sliced bread." In 2017, that was TiddlyWiki. It
was exactly what I needed and wished I had known about years ago. Since then, 
I've been happily building my personal wiki, customizing it, and sharing my 
experience with others. Quite a few times now, I've had the opportunity to sit 
down and demonstrate my setup and how I use TiddlyWiki. I figured it woud be 
good to get this information down in a blog post so that it may be a resource
for others out there.

## What is TiddlyWiki? 

As described on its website as:

> a unique non-linear notebook for capturing, organising and sharing complex 
> information.

In other words, it's a personal wiki that allows for you to capture and 
organize your notes in a flexible way. The fundamental unit of a TiddlyWiki is 
"tiddlers", which are meant to store set of information.

## Getting started with TiddlyWiki

Getting started with TiddlyWiki is fairly straightforward. There are two 
approaches to do this:

* Single HTML file approach
* Node.js approach

### Single HTML approach

The single HTML approach is quick and easy way to get started. Go to 
https://tiddlywiki.com/ and download an empty copy of TiddlyWiki (`empty.html`). 
Then open the HTML file in your browser and you can basically start using 
TiddlyWiki just like that! I won't go 

Importantly, everything will get encapsulated inside 
this single HTML file allowing you to easily share your entire wiki to others.
You can also deposit this HTML file to some cloud based storage (e.g. Google 
Drive) allowing you to sync aross machines. 

Additionally, making a small change would require you to upload the entire
HTML file. The alternative approach is to install and use TiddlyWiki through the 
Node.js approach. The biggest difference will be your wiki no longer being a 
single large HTML file, but rather broken intwo 
no lon

To get setup through the Node.js approach on a Mac OSX, you can use HomeBrew
to first install Node.js:

```bash
brew install node
```

Then use the node package manager, run:

```bash
sudo npm install -g tiddlywiki
```

If all goes well, you will have tiddlywiki installed. You can confirm this with:

````bash
# Check which version of TiddlyWiki is installed on your machine
tiddlywiki --version
```
```
5.1.19
```

Now create a wiki:

```bash
tiddlywiki test_wiki --init server
```

* The node.js approach
* Stored in google drive

# Adding a table of contents

* Ordering it

# Adding a new category to the sidebar

# How to add images

* Webserver to host the images folder.

# Plugins

## Syntax highlighting

## CodeMirror

* Vim plugin. Disable of esc key.

# Table of contents 

TiddlyWiki contains several [macros](https://tiddlywiki.com/#Macros:Macros%20HelloThere%20GettingStarted%20Community). 
that can be used for generating a tree of tiddler links by analysing tags. The 
one I like the most is [toc-tabbed-external-nav](https://tiddlywiki.com/#Example%20Table%20of%20Contents%3A%20Tabbed%20External).

A minor gripe that I had with this is that there is no easy way to modify the 
tiddlers without having to directly open and edit it. I found this [gem](https://tiddlywiki.com/#Example%20Table%20of%20Contents%3A%20Tabbed%20External)
that contains a modified version of this macro to add an open and edit button.

What you have to do this is create a tiddler and then add these contents:

```
\define tocTools( to )
@@.tocTools
<$button to="$to$">{{$:/core/images/link}}</$button>
<$button to="$to$" message="tm-edit-tiddler">{{$:/core/images/edit-button}}</$button>
@@
\end

\define smokeMirrors( selected )
<$macrocall $name="tocTools" to={{$selected$}}/>
\end

\define toc-tabbed-internal-nav-gu( tag, sort:"", selectedTiddler:"$:/temp/toc/selectedTiddler", unselectedText, missingText, template:"" )
<$tiddler tiddler={{$selectedTiddler$}}>
  <div class="tc-tabbed-table-of-contents">
    <$linkcatcher to="$selectedTiddler$">
      <div class="tc-table-of-contents">
        <$macrocall $name="toc-selective-expandable" tag="""$tag$""" sort="""$sort$""" itemClassFilter=<<toc-tabbed-selected-item-filter selectedTiddler:"""$selectedTiddler$""">>/>
      </div>
    </$linkcatcher>
    <div class="tc-tabbed-table-of-contents-content">
      <<smokeMirrors $selectedTiddler$>>
      <$linkcatcher to="$selectedTiddler$">
        <$reveal state="""$selectedTiddler$""" type="nomatch" text="">
          <$transclude mode="block" tiddler="$template$">
            <h1><<toc-caption>></h1>
            <$transclude mode="block">$missingText$</$transclude>
          </$transclude>
        </$reveal>
        <$reveal state="""$selectedTiddler$""" type="match" text="">
          $unselectedText$
        </$reveal>
      </$linkcatcher>
    </div>
  </div>
</$tiddler>
```

What you are doing is defining a new macro called `toc-tabbed-internal-nav-gu`.
Tag this tiddler with the tag `$:/tags/Macro`. This makes the macro available to 
all tiddlers (if you don't do this, then the macro is only available in the 
tiddler that defined it). Now in the tiddler that you want to use the macro in, 
you call the macro as follows:

```
<<toc-tabbed-external-nav-gu "TableOfContents">>
```

Now you get two extra buttons at the top of each tab that allows you to easily
open and edit the tiddler in your river.

