# Rendering rmarkdown to markdown files for Jekyll

```bash
./r-to-jekyll.R --rmd-file why-bayes-statistics.Rmd
```

The images will be temporarily placed into the subfolder:

```
{{ site.url }}/assets/[RMD_FILE_NAME]
```

These will then be copied into `../assets/[RMD_FILE_NAME]`.


