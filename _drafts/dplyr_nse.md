---
layout: post
title:  "NSE"
---

* http://justanotherdatablog.blogspot.ca/2015/03/dplyr-use-cases-non-interactive-mode.html


```{r}
filter_crit <- interp(~ !is.na(code) & !is.na(time) & !is.na(sampleID) &
                      biopsy == biopsy.type,
                      .values = list(code = as.name(endpointCode),
                                      time = as.name(endpoint),
                                      biopsy.type = arguments$biopsyType))
```
