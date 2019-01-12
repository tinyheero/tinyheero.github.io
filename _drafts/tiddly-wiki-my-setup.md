---
layout: post
title:  "TiddlyWiki: My Step"
tags: [bioinfo, kallisto]
---

## Introduction

So what is TiddlyWiki? It is describe on its website as:

> a unique non-linear notebook for capturing, organising and sharing complex information.

In other words, it's a personal wiki that allows for you to capture notes in an extremely flexible way.

## Getting started with TiddlyWiki

Getting started with TiddlyWiki is fairly straightforward. You download an empty copy of TiddlyWiki (`empty.html`) to create what is called the "single file version". Then open that into your browser and you can start using TiddlyWiki just like that! Everything will get encapsulated inside this single HTML file. You can then deposit this to some cloud based storage (e.g. Google Drive) giving you syncing aross machines.

However, I would instead recommending installing and using TiddlyWiki through the Node.js approach. The biggest 


On Mac OSX, you can do this with:

```bash
brew install node
```

```bash
sudo npm install -g tiddlywiki
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

[toc-tabbed-external-nav](https://tiddlywiki.com/#Example%20Table%20of%20Contents%3A%20Tabbed%20External)

One minor issue that I had with this [macro](https://tiddlywiki.com/#Macros:Macros%20HelloThere%20GettingStarted%20Community). 
is that there is no easy way to modify the tiddlers without having to directly 
open and edit it. I found this [gem](https://tiddlywiki.com/#Example%20Table%20of%20Contents%3A%20Tabbed%20External)
that contains a modified version of this macro to add an open and edit button 
macro. 

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

