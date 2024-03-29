% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/os.R
\name{os}
\alias{os}
\alias{os.linux}
\alias{os.macos}
\alias{os.windows}
\alias{os.unix}
\title{Operating System}
\usage{
os()

os.linux()

os.macos()

os.windows()

os.unix()
}
\value{
\code{os} returns the name of the operating system, typically \code{"Linux"},
\code{"Darwin"}, or \code{"Windows"}.

\code{os.linux}, \code{os.macos}, \code{os.unix}, and \code{os.windows}
return \code{TRUE} or \code{FALSE}.
}
\description{
Determine operating system name.
}
\note{
The macOS operating system identifies itself as \code{"Darwin"}.

Both Linux and macOS are \code{os.unix}.

These shorthand functions can be useful when writing workaround solutions in
platform-independent scripts.
}
\examples{
\donttest{
os()
os.linux()
os.macos()
os.unix()
os.windows()
}

}
\seealso{
\code{\link{Sys.info}} is the underlying function used to extract the
operating system name.

\code{\link{TAF-package}} gives an overview of the package.
}
