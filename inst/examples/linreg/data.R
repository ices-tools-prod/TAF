## Preprocess data, write TAF data tables

## Before: ezekiel.txt (boot/data)
## After:  ezekiel.csv (data)

library(TAF)

mkdir("data")

## Read data
ezekiel <- read.table("boot/data/ezekiel.txt", header=TRUE)

## Write TAF table
write.taf(ezekiel, "data/ezekiel.csv")
