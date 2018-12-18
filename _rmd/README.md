# Rendering rmarkdown to HTML

Before rendering the rmarkdown to a markdown file for Jekyll, you can inspect
how it would look as an HTML file. For instance, if your rmarkdown file was
`crux-of-bayes-statistics.Rmd`, you could run:

```
make crux-of-bayes-statistics.html
```

This would generate a `crux-of-bayes-statistics` HTM file that is 
self-contained (i.e. all images are incorporated into the HTML file).

# Rendering rmarkdown to markdown files for Jekyll

```bash
./r-to-jekyll.R --rmd-file why-bayes-statistics.Rmd
```

The images will be temporarily placed into the subfolder:

```
{{ site.url }}/assets/[RMD_FILE_NAME]
```

These will then be copied into `../assets/[RMD_FILE_NAME]`.


