## Run analysis, write model results

## Before: ezekiel.csv (data)
## After:  results.RData (model)

library(TAF)

mkdir("model")

## Read data
ezekiel <- read.taf("data/ezekiel.csv")

## Fit model
fm <- lm(dist~speed, data=ezekiel)

## Save results
save(fm, file="model/results.RData")
