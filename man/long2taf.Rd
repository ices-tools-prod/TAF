% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/long2taf.R
\name{long2taf}
\alias{long2taf}
\title{Convert Long Table to TAF Format}
\usage{
long2taf(x)
}
\arguments{
\item{x}{a data frame in long format.}
}
\value{
A data frame in TAF format.
}
\description{
Convert a table from long format to TAF format.
}
\note{
TAF stores tables as data frames, usually with a year column as seen in stock
assessment reports. The long format is more convenient for analysis and
producing plots.
}
\examples{
long2taf(catage.long)

}
\seealso{
\code{\link{catage.long}} and \code{\link{catage.taf}} describe the long and
TAF formats.

\code{\link{taf2long}} converts a TAF table to long format.

\code{\link{TAF-package}} gives an overview of the package.
}
