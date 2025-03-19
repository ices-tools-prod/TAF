library(png)

taf.pixels <- tolower(as.raster(readPNG("../vignettes/figs/diagram.png")))

save(taf.pixels, file="../data/taf.pixels.RData", compress="xz")
