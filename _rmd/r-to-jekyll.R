#!/usr/bin/env Rscript
#
# Contributors: Fong Chun Chan

script_description <- "
Convert Rmarkdown to Jekyll Markdown
"

script_author <- "Fong Chun Chan <a.name@achillestx.com>"
script_examples <- "
Examples:

    {script_name} \\
      --rmd-file gmm-em.Rmd \\
      --img-dir gmm-em \\
"

# Warnings should be escalated to errors:
options(warn = 2)

# The libraries to load. This should be as minimal as possible.
loaded_libs <- c("argparse", "glue")

# Required library packages
required_libs <- c(loaded_libs)

# If any packages aren't installed, list them and stop
missing_libs <-
  required_libs[!required_libs %in% rownames(installed.packages())]
if (length(missing_libs) > 0)
  stop(paste(c("Missing required libraries:", missing_libs), collapse = " "))

# Load the necessary packages (only do this in scripts, not library code)
for (lib in loaded_libs)
  suppressPackageStartupMessages(library(lib, character.only = TRUE))

if (interactive()) {
  parameters <-
    list(
      "rmd_file" = "crux-of-bayes-statistics.Rmd",
      "img_dir" = "crux-of-bayes-statistics"
    )
}

#' Main function
#'
#' This function should do little more than co-ordinate the other functions.
#' That way, the logic of the script (in the other functions) can be tested
#' independently of the parameter parsing.
#' 
#' @param cli_args Input from commandArgs(TRUE)
#' @return NULL
main <- function(cli_args) {
  # Parse the CLI arguments:
  parameters <- parser_args(cli_args)

  # Knit and place in _posts.
  out_dir <- paste0("../_posts/", Sys.Date(), "-")
  output_file <- paste0(out_dir, sub(".Rmd", ".md", parameters$rmd_file))

  # Specify a temporarily location to store these images that is relative to 
  # to the current run directory. These images will all be moved into the top
  # level assets folder.
  tmp_img_dir <- file.path("{{ site.url }}", "assets", parameters$img_dir, "/")

  # Since May 2016, default markdown parser is kmarkdown which uses ~~~ as the
  # default fenced block marker
  knitr::opts_chunk$set(fig.path = tmp_img_dir)
  knitr::render_jekyll() #fence_char = "~")
  knitr::knit(input = parameters$rmd_file, output = output_file)

  # Copy image files to the images directory.
  todir <- paste0("../assets/", parameters$img_dir, "/")

  # Create asset folder if doesn't exist
  if (! file.exists(todir)) {
    dir.create(todir)
  }

  pics <- list.files(tmp_img_dir)
  pics <- sapply(pics, function(x) paste(tmp_img_dir, x, sep="/"))
  file.copy(pics, todir, overwrite = TRUE)
  message(glue("Images copied to {todir}"))
  return(invisible(NULL))
  #unlink("{{ site.url }}", recursive = TRUE)
}

#' Parse command-line arguments
#'
#' @param cli_args Input from commandArgs(TRUE)
#' @return List of parameters parsed from the command-line.
parser_args <- function(cli_args) {
  
  # See https://stackoverflow.com/a/27492072 for details of escaping backslashes
  # To escape the \\ in the examples section
  script_description <- gsub("\\\\", "\\\\\\\\", script_description)
  script_examples <- gsub("\\\\", "\\\\\\\\", script_examples)
  
  # To maintain newlines following JSON serialization to python's argparse
  script_description <- gsub("\n", "\\\\n\\\\\n", script_description) # nolint
  script_examples <- gsub("\n", "\\\\n\\\\\n", script_examples) # nolint
  
  # Identify how the user called the script
  full_commandline_arguments <- commandArgs(trailingOnly = FALSE)
  script_name <- sub(
    "--file=", "",
    full_commandline_arguments[grep("--file=", full_commandline_arguments)]
  )
  
  script_examples <- glue(script_examples)
  
  parser <- argparse::ArgumentParser( # nolint
    description = script_description,
    epilog = script_examples,
    formatter_class = "argparse.RawTextHelpFormatter"
  )
  
  parser$add_argument(
    "--rmd-file", 
    nargs = 1, 
    type = "character",
    required = TRUE,
    help = "Rmarkdown file"
  )

  parser$add_argument(
    "--img-dir", 
    nargs = 1, 
    type = "character",
    help = 
      paste(
        "Set the directory name that stores the images associated with the",
        "--rmd--file. This directory will be a subfolder of the assets folder.",
        "If not set, the default value will be name of the --rmd-file"
      )
  )
 
  parameters <- parser$parse_args(cli_args)
  
  # Validate the parameters
  
  if (parameters$rmd_file != "-" 
    && ! file.exists(parameters$rmd_file)
   ) {
    stop("Rmarkdown file doesn't exist.")
  }

  # Check that it's a .Rmd file.
  if (!grepl(".Rmd", parameters$rmd_file)) {
    stop("You must specify a .Rmd file.")
  }

  if (is.null(parameters$img_dir)) {
    parameters$img_dir <- sub(".Rmd$", "", parameters$rmd_file)
    message(glue::glue("Setting --img-dir to {parameters$img_dir}"))
  }
 
  return(parameters)

}

if (! exists("testing")) {
  main(commandArgs(TRUE))
}
