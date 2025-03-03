## Prepare plots and tables for report

## Before: fit.csv (output)
## After:  fit.csv, fit.png (report)

library(TAF)

mkdir("report")

## Read output
coef <- read.taf("output/coef.csv")
fit <- read.taf("output/fit.csv")

## Plot
taf.png("fit")
plot(dist~speed, fit, xlab="Speed (mph)", ylab="Stopping distance (ft)")
lines(fit~speed, fit)
dev.off()

## Tables with rounded numbers
coef <- round(coef, 3)
fit <- round(fit, 3)
write.taf(coef, dir="report")
write.taf(fit, dir="report")
