library(png)
diagram.pixels <- tolower(as.raster(readPNG("diagram.png")))
save(diagram.pixels, file="diagram.pixels.RData", compress="xz")
