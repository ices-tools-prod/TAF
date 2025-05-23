% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/draft.data.R
\name{draft.data}
\alias{draft.data}
\title{Draft DATA.bib}
\usage{
draft.data(originator = NULL, year = format(Sys.time(), "\%Y"),
  title = NULL, period = NULL, access = "Public", source = NULL,
  file = "", append = FALSE,
  data.files = dir(taf.boot.path("initial/data")),
  data.scripts = dir(boot.dir(), pattern = "\\\\.R$"))
}
\arguments{
\item{originator}{who prepared the data, e.g. a working group acronym.}

\item{year}{year of the analysis when the data were used. The default is the
current year.}

\item{title}{description of the data, including survey names or the like.}

\item{period}{a string of the form \code{"1990-2000"}, indicating the first
and last year that the data cover, separated by a simple dash.
Alternatively, a single number if the data cover only one year. If the
data do not cover specific years, this metadata field can be
suppressed using \code{period = FALSE}.}

\item{access}{data access code: \code{"OSPAR"}, \code{"Public"}, or
\code{"Restricted"}.}

\item{source}{where the data are copied/downloaded from. This can be a URL,
filename, or a special value: \code{"file"}, \code{"folder"}, or
\code{"script"}.}

\item{file}{optional filename to save the draft metadata to a file. The value
\code{TRUE} can be used as shorthand for \code{"boot/DATA.bib"}.}

\item{append}{whether to append metadata entries to an existing file.}

\item{data.files}{data files to consider. The default is all folders and
files inside \verb{boot/initial/data}.}

\item{data.scripts}{boot data scripts to consider. The default is all
\verb{*.R} files in the \verb{boot} folder.}
}
\value{
Character vector of class \verb{Bibtex}.
}
\description{
Create an initial draft version of a \file{DATA.bib} metadata file.
}
\details{
Typical usage is to specify \code{originator}, while using the default values
for the other arguments. Most data files have the same originator, which can
be specified to facilitate completing the entries after creating the initial
draft.

The data access codes come from \url{https://vocab.ices.dk/?ref=1435}.

The special values \verb{source = "file"}, \verb{source = "folder"}, and
\verb{source = "script"} are described on the
\href{https://github.com/ices-taf/doc/wiki/Bib-entries}{TAF Wiki}, along with
other metadata information.

The default value \code{file = ""} prints the initial draft in the console,
instead of writing it to a file. The output can then be pasted into a file to
edit further, without accidentally overwriting an existing metadata file.
}
\note{
This function is intended to be called from the top directory of a TAF
analysis. It looks for data files inside \verb{boot/initial/data} folder and
data scripts inside \verb{boot}.

After creating the initial draft, the user can complete the description of
each data entry inside the \verb{title} field and look into each file to
specify the \verb{period} that the data cover.
}
\examples{
\dontrun{
# Print in console
draft.data("WGEF", 2015)

# Export to file
draft.data("WGEF", 2015, file=TRUE)

# Empty entry, to complete by hand
draft.data(data.files="")
}

}
\seealso{
\code{\link{period}} pastes two years to form a \code{period} string.

\code{\link{draft.software}} creates an initial draft version of a
\verb{SOFTWARE.bib} metadata file.

\code{\link{taf.boot}} reads and processes metadata entries.

\code{\link{TAF-package}} gives an overview of the package.
}
