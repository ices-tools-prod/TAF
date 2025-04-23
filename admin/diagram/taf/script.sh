# Convert to PDF and compress
2pdf diagram.odp
pcrop diagram.pdf 87:264 303:696
2pdf out.pdf
pmerge out_.pdf
rm out_.pdf
out diagram

# Convert to PNG and compress
2png -d300 diagram.pdf
mogrify -crop 1800x900+1094+1217 diagram.png
optipng diagram.png
