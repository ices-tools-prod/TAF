2pdf data.odp
pcrop data.pdf 112:44 560:746
out data

2png -a4 -b4 -d241 data.pdf
mogrify -crop 2360x1500+132+114 data.png
optipng data.png
