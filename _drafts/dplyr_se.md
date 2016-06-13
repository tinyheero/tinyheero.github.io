---
layout: post
title:  "NSE"
---

* http://justanotherdatablog.blogspot.ca/2015/03/dplyr-use-cases-non-interactive-mode.html

# arrange, group\_by

```{r}
arrange_(.dots = c("test", "test2"))
group_by_(.dots = c("test", "test2"))
```

# select

```{r}
select_(.dots = c("test", "test2"))
```

# mutate

```{r}
mutate_call <- lazyeval::interp(~ a + b, a = as.name("col1"), b = as.name("col2"))
mtcars %>% 
	mutate_(.dots = setNames(list(mutate_call), "new_col_name"))

# Multiple mutates
mutate_call <- list(
  lazyeval::interp(~ a + b, a = as.name("col1"), b = as.name("col2")),
  lazyeval::interp(~ factor(c), c = as.name("col3"))
  )
mtcars %>% 
	mutate_(.dots = setNames(mutate_call, c("new_col_name", "col3")))
```

# rename

```{r}
rename_(dat, .dots = c("new_name1" = "old_name1",
                       "new_name2" = "old_name2"))

```


```{r}
filter.crit <- interp(~ !is.na(code) & !is.na(time) & !is.na(sampleID) &
                      biopsy == biopsy.type,
                      .values = list(code = as.name(endpointCode),
                                      time = as.name(endpoint),
                                      biopsy.type = arguments$biopsyType))

filter_(.dots = filter.crit)
```
