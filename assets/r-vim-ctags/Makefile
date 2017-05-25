all : no-tags-gif.gif with-tags-gif.gif

no-tags-gif.gif : no-tags-gif-1.png no-tags-gif-2.png no-tags-gif-3.png
	convert -delay 100 -loop 0 $^ $@

with-tags-gif.gif : no-tags-gif-1.png no-tags-gif-2.png with-tags-4.png
	convert -delay 100 -loop 0 $^ $@
