library(png)
taf.pixels <- tolower(as.raster(readPNG("png/diagram.png")))
save(taf.pixels, file="taf.pixels.RData", compress="xz")
