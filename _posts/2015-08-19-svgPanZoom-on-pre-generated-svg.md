---
layout: post
title:  "Using svgPanZoom on a Pre-generated SVG"
date:   2015-08-19
tags: [R, svgPanZoom]
---

[@timelyportfolio](twitter.com/timelyportfolio) has provided the R community with the fantastic [svgPanZoom R htmlwidget](https://github.com/timelyportfolio/svgPanZoom) which leverages off the [svg-pan-zoom Javascript library](https://github.com/ariutta/svg-pan-zoom) to allow for panning and zooming of SVG in html documents.

On the Github page, there are several examples on how to use the widget for different R graphic types (e.g. ggplot). But all of the examples show how to use the widget in the context of generating the plot dynamically. How would you use the widget when say you have a pre-generated SVG? 

For instance, let's say I wanted to create a pan and zoom on this figure that was generated using a combination of R and [Inkscape](https://inkscape.org):

![Copy Number Landscape of RCOR1 Paper]({{ site.url }}/assets/copy_number_landscape.svg)

[This is Figure 1 from Chan et al. Blood. 2015](http://www.bloodjournal.org/content/125/6/959)

The documentation on the `svgPanZoom` function gives us an idea on how to do this. The argument svg states:

> svg - SVG as XML, such as return from 'svgPlot'

Since SVG is nothing more than just XML, we simply have to load the SVG as a single character value:

~~~r
library("svgPanZoom")
file.name <- "/path/to/svg"
in.svg <- readChar(file.name, nchars = file.info(file.name)$size)
svgPanZoom(in.svg, controlIconsEnabled = TRUE)
~~~

You can see the **[output of this here](http://rpubs.com/fongchun/svgPanZoom-pre-generated-svg).**

> The Rmarkdown code is slightly different because I've placed the SVG on my Github and thus am loading the SVG directly from the web. The Rmarkdown just serves to demonstrate the output.
