% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/convert.spaces.R
\name{convert.spaces}
\alias{convert.spaces}
\title{Convert Spaces}
\usage{
convert.spaces(file, sep = "_")
}
\arguments{
\item{file}{filename, e.g. \code{"file name.csv"}, \code{"*.csv"}, or
\code{"dir/*"}.}

\item{sep}{character to use instead of spaces.}
}
\value{
\code{TRUE} for success, \code{FALSE} for failure, invisibly.
}
\description{
Convert spaces in filenames.
}
\note{
This function treats \file{\%20} in filenames as a space and converts to
\code{sep}.
}
\examples{
\dontrun{
write(pi, "A B.txt")
convert.spaces("A B.txt")

# Many files
convert.spaces("boot/initial/data/*")
}

}
\seealso{
\code{\link{file.rename}} is the base function to rename files.

\code{\link{TAF-package}} gives an overview of the package.
}
