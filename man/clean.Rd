% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clean.R
\name{clean}
\alias{clean}
\title{Clean TAF Directories}
\usage{
clean(dirs = c("data", model.dir(), "output", "report"), force = FALSE)
}
\arguments{
\item{dirs}{directories to delete.}

\item{force}{passed to \code{clean.boot} if any of the \code{dirs} is
\code{"boot"}.}
}
\value{
No return value, called for side effects.
}
\description{
Remove TAF directories: \verb{data}, \verb{model}, \verb{output}, and
\verb{report}.
}
\details{
The \verb{model} directory may also be named \verb{method} and is cleaned in
the same way.
}
\note{
The purpose of removing the directories is to make sure that subsequent TAF
scripts start by creating new empty directories.

If any of the \code{dirs} is \code{"boot"}, it is treated specially and
\code{clean.boot} is called to clean the \verb{boot} directory.

In other words, \code{clean("boot")} and \code{clean.boot()} are
interchangeable, the latter providing a slightly clearer interface that was
introduced in version 4.2.0.
}
\examples{
\dontrun{
clean()
clean.boot()
}

}
\seealso{
\code{\link{clean.boot}} cleans the boot directory.

\code{\link{mkdir}} and \code{\link{rmdir}} create and remove empty
directories.

\code{\link{TAF-package}} gives an overview of the package.
}
