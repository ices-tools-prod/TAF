## Extract results of interest, write TAF output tables

## Before: results.RData (model)
## After:  coef.csv, fit.csv (output)

library(TAF)

mkdir("output")

## Read results
load("model/results.RData")

## Extract quantities of interest
coef <- data.frame(b0=coef(fm)[1], b1=coef(fm)[2], row.names=NULL)
fit <- data.frame(fm$model, fit=fm$fit)

## Write TAF tables
write.taf(coef, dir="output")
write.taf(fit, dir="output")
