
for f in ["base16_colors", "base16_default", "base16_greyscale", "base16_summerfruit", "laederon"]
	"let f=fnamemodify(f, ':t:r')
	exec "AirlineTheme " . f
	redraw
	echo f
	exe getchar()
endfor

