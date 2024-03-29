% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/source.all.R
\name{source.all}
\alias{source.all}
\alias{sourceAll}
\title{Run All TAF Scripts}
\usage{
source.all(...)
}
\arguments{
\item{\dots}{passed to \code{\link{source.taf}}.}
}
\value{
Logical vector, indicating which scripts ran without errors.
}
\description{
Run core TAF scripts in current directory.
}
\note{
TAF scripts that will be run if they exist are: \verb{utilities.R},
\verb{data.R}, \verb{model.R}, \verb{output.R}, and \verb{report.R}.

The \verb{model.R} script may also be named \verb{method.R} and is treated in
the same way.
}
\examples{
\dontrun{
source.all()
}

}
\seealso{
\code{\link{source.taf}} runs a TAF script.

\code{\link{make.all}} runs all TAF scripts as needed.

\code{\link{clean}} cleans TAF directories.

\code{\link{TAF-package}} gives an overview of the package.
}
