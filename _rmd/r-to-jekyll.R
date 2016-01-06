#!/usr/bin/env Rscript
library("knitr")

# Get the filename given as an argument in the shell.
args <- commandArgs(TRUE)
filename <- args[1]
imgdir <- args[2]

# Check that it's a .Rmd file.
if(!grepl(".Rmd", filename)) {
  stop("You must specify a .Rmd file.")
}

# Knit and place in _posts.
dir = paste0("../_posts/", Sys.Date(), "-")
output = paste0(dir, sub(".Rmd", ".md", filename))
knit(filename, output)

# Copy .png files to the images directory.
fromdir <- paste0("{{ site.url }}/assets/", imgdir, "/")
todir <- paste0("../assets/", imgdir, "/")

pics = list.files(fromdir)
pics = sapply(pics, function(x) paste(fromdir, x, sep="/"))
file.copy(pics, todir, overwrite = TRUE)

#unlink("{{ site.url }}", recursive = TRUE)
