#!/usr/bin/env Rscript
library("argparse")
library("knitr")

parser <- ArgumentParser(description = "Convert Rmarkdown to Jekyll Markdown")

parser$add_argument("--imgdir", nargs = 1, type = "character", 
                    help = "Set the directory name that stores the images.")

parser$add_argument("filename", nargs = 1, type = "character", 
                    help = "Rmarkdown filename")

if (interactive()){
  opt <- c("--imgdir", "gmm-em")
  filename <- "gmm-em.Rmd"
  arguments <- parser$parse_args(c(filename, opt))
} else {
  arguments <- parser$parse_args()
}

filename <- arguments$filename

# Check that it's a .Rmd file.
if (!grepl(".Rmd", filename)) {
  stop("You must specify a .Rmd file.")
}

# Knit and place in _posts.
dir <- paste0("../_posts/", Sys.Date(), "-")
output <- paste0(dir, sub(".Rmd", ".md", filename))

# Since May 2016, default markdown parser is kmarkdown which uses ~~~ as the
# default fenced block marker
render_markdown(fence_char = "~")
knit(filename, output)

# Copy image files to the images directory.
if (!is.null(arguments$imgdir)) {
  fromdir <- paste0("{{ site.url }}/assets/", arguments$imgdir, "/")
  todir <- paste0("../assets/", arguments$imgdir, "/")
} else {
  fromdir <- paste0("{{ site.url }}/assets/")
  todir <- paste0("../assets/", arguments$imgdir)
}

# Create asset folder if doesn't exist
if (!file.exists(todir)) {
	dir.create(todir)
}

pics <- list.files(fromdir)
pics <- sapply(pics, function(x) paste(fromdir, x, sep="/"))
file.copy(pics, todir, overwrite = TRUE)

#unlink("{{ site.url }}", recursive = TRUE)
