---
layout: post
title:  "Getting Vim + Ctags Working with R"
date: 2017-05-13
tags: [ctags, R, vim]
---

I've been an avid [Vim](http://www.vim.org/) user for many years and think it's one of the best text editors out there. My enthusiasm for Vim, along with all its [great plugins](http://vimawesome.com/), is also one of the major reasons why I have never adopted [RStudio](https://www.rstudio.com) for R programming and instead still continue to use the [Nvim-R plugin](https://github.com/jalvesaq/Nvim-R). This wonderful plugin provides the critical feature of being able to send commands from your R script to an R session. Along with other handy features it provides, this plugin serves as a good alternative to Rstudio for those, like me, who want to stick with Vim. 

Recently, I discovered the power of Vim + Ctags that provides the ability to navigate your code with breeze. If you don't know what Ctags is, I suggest you watch this [video](https://www.youtube.com/watch?v=4f3AENLrdYo) to get a quick overview of what it provides. When I combined this with the Nvim-R plugin, I finally felt like I had converted my Vim setup into a fully integrative development environment for R; one that is comparable to RStudio. In this post, I will cover how to get Vim + Ctags working with the R programming language.

These instructions have been tested with Neovim (v0.1.4) and Ctags (v5.8).

**Table of Contents**

<ul data-toc="body" data-toc-headings="h2,h3"></ul>

## Installing Ctags

To get ctags, you can install it from a package manager. For example on OSX, we can use homebrew for this:

```
brew install ctags
```

## Configuring Ctags

Once it is installed, we need to do some configuration to get it working with the R language. First, add the following to your `~/.ctags` file:

```
--langdef=R
--langmap=r:.R.r
--regex-R=/^[ \t]*"?([.A-Za-z][.A-Za-z0-9_]*)"?[ \t]*<-[ \t]function/\1/f,Functions/
--regex-R=/^"?([.A-Za-z][.A-Za-z0-9_]*)"?[ \t]*<-[ \t][^f][^u][^n][^c][^t][^i][^o][^n]/\1/g,GlobalVars/
--regex-R=/[ \t]"?([.A-Za-z][.A-Za-z0-9_]*)"?[ \t]*<-[ \t][^f][^u][^n][^c][^t][^i][^o][^n]/\1/v,FunctionVariables/``
```

And then add the following to your `vimrc` (if you use vim) or `~/.config/nvim/init.vim` (if you use neovim):

```
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }
```

These instructions were taken from the [wiki page of the Vim plugin Tagbar](https://github.com/majutsushi/tagbar/wiki#r). Once you have this setup, you should be able to run `ctags -R .` on any folder and it will recursively go down your folders to build all the tags. Let's test it out!

## Testing Vim + Ctags with R

First, let's setup a quick R project:

```bash
mkdir -p vim_tags_subdir
printf "test_function_1 <- function() {\n  print(\"I am test function 1\")\n}\n\ntest_function_2()\n\n" > test_function_1.R
printf "other_function <- function() {\n  print(\"I am other function\")\n}" >> test_function_1.R
printf "test_function_2 <- function() {\n  print(\"I am test function 2\")\n}\n\ntest_function_1()" > vim_tags_subdir/test_function_2.R
```

You should now have a `test_function_1.R` and a `vim_tags_subdir/test_function_2.R` file. 

1. Now open `test_function_1.R` in Vim,
1. move your cursor over to the line `test_function_2()`, 
1. then press `Ctrl + ]`. 

You should see an error message similar to:

```
E433: No tags file
E426: tag not found: test_function_2
```

![No tags setup example]({{ site.url }}/assets/r-vim-ctags/no-tags-gif.gif)

Exit Vim and go back to the shell. In this folder, enter the following command:

```bash
ctags -R .
```

This should create a `tags` file in this folder now. Now re-open `test_function_1.R` and repeat the `Ctrl + ]` step. This time it should jump to the function definition found in `vim_tags_subdir/test_function_2.R`. Pretty neat hey!

![Tags working example]({{ site.url }}/assets/r-vim-ctags/with-tags-gif.gif)

## Tagbar

A cool Vim plugin that I like to use is [Tagbar](majutsushi/tagbar). This allows you to visualize all the tags in a specific file in a separate window. The benefit of this is that you get a quick overview of what is in the script (e.g. all the functions). Once you have it installed, I like to add the following to my `vimrc`:

```
" Turns on the TagBar
nnoremap <leader>tb :TagbarToggle<CR>
```

This allows me to toggle the Tagbar on and off by pressing `<leader>tb` which makes a window appear on the right side of your screen by default:

![Tagbar example]({{ site.url }}/assets/r-vim-ctags/tagbar_example.png)

Here we can see the opened `test_function_1.R` script has 2 functions (`test_function_1()`, and `other_function()`) in it that are outlined in the right Tagbar window. Tagbar works by generating these tags on the fly in memory. In other words, it doesn't actually use the `tags` file generated from `ctags -R .`. As such, it can only provide an overview of the tags in the specific file that is open and won't show you tags from other files and the rest of your project.

## Conclusion

Hopefully this post was able to demonstrate how to get setup wth Vim + Ctags in R. This powerful combination will have you flying around your code in no time!
