#' Boot TAF Analysis
#'
#' Process metadata files \file{SOFTWARE.bib} and \file{DATA.bib} to set up
#' software and data files required for the analysis.
#'
#' @param software whether to process \verb{SOFTWARE.bib}.
#' @param data whether to process \verb{DATA.bib}.
#' @param clean whether to \code{\link{clean}} directories during the boot
#'        procedure.
#' @param force whether to remove existing \verb{boot/data},
#'        \verb{boot/library}, and \verb{boot/software} directories before the
#'        boot procedure.
#' @param taf a convenience flag where \code{taf = TRUE} sets \code{software},
#'        \code{data}, \code{clean}, and \code{force} to \code{TRUE}, as is done
#'        on the TAF server. Any other value of \code{taf} is ignored.
#' @param quiet whether to suppress messages reporting progress.
#' @param ... passed to \code{process.entry}.
#'
#' @details
#' If \code{clean = TRUE} then:
#' \enumerate{
#' \item \code{\link{clean.software}} and \code{\link{clean.library}} are run if
#'       \file{SOFTWARE.bib} is processed.
#' \item \code{\link{clean.data}} is run if \file{DATA.bib} is processed.
#' }
#'
#' The default behavior of \code{taf.boot} is to skip downloading of remote
#' files (GitHub resources, URLs, boot scripts) and also skip installing R
#' packages from GitHub if the files seem to be already in place. This is done
#' to speed up the boot procedure as much as possible. To override this and
#' guarantee that all data and software files are updated, pass \code{force =
#' TRUE} to download and install everything declared in \verb{SOFTWARE.bib} and
#' \verb{DATA.bib}.
#'
#' @return Logical vector indicating which metadata files were processed.
#'
#' @note
#' This function should be called from the top directory of a TAF analysis. It
#' looks for a directory called \file{boot} and prepares data files and software
#' according to metadata specifications.
#'
#' The boot procedure consists of the following steps:
#' \enumerate{
#' \item If a \verb{boot/SOFTWARE.bib} metadata file exists, it is processed.
#' \item If a \verb{boot/DATA.bib} metadata file exists, it is processed.
#' }
#'
#' After the boot procedure, software and data have been documented and are
#' ready to be used in the subsequent analysis. Specifically, the procedure
#' populates up to three new directories:
#' \itemize{
#' \item \verb{boot/data} with data files.
#' \item \verb{boot/library} with R packages compiled for the local platform.
#' \item \verb{boot/software} with software files, such as R packages in
#'       \verb{tar.gz} source code format.
#' }
#'
#' From version 4.2 onwards, the term \emph{boot} is preferred for what used to
#' be called \emph{bootstrap}, mainly to avoid confusion with statistical
#' bootstrap. To \code{taf.boot()} is similar to booting a computer, readying
#' the components required for subsequent computations. Help pages now refer to
#' \code{boot}, but all TAF functions fully support existing analyses that have
#' a legacy \code{bootstrap} folder.
#'
#' Model settings and configuration files can be set up within \verb{DATA.bib},
#' see \href{https://github.com/ices-taf/doc/wiki/Bib-entries}{TAF Wiki}.
#'
#' @seealso
#' \code{\link{draft.data}} and \code{\link{draft.software}} can be used to
#' create initial draft versions of \file{DATA.bib} and \file{SOFTWARE.bib}
#' metadata files.
#'
#' \code{\link{taf.library}} loads a package from \verb{boot/library}.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' taf.boot()
#' }
#'
#' @aliases taf.bootstrap
#'
#' @export

taf.boot <- function(software=TRUE, data=TRUE, clean=TRUE, force=FALSE,
                     taf=NULL, quiet=FALSE, ...)
{
  if(isTRUE(taf))
    software <- data <- clean <- force <- TRUE
  if(!boot.exists())
  {
    warning("'boot' folder not found in the current working directory")
    return(invisible(NULL))  # nothing to do
  }

  if(!quiet)
    msg("Boot procedure running...")

  if(force)
    clean(file.path(boot.dir(), c("software","library","data")))

  out <- c(SOFTWARE.bib=FALSE, DATA.bib=FALSE)

  # 0  Process config
  if(dir.exists(file.path(boot.dir(), "initial/config")))
  {
    if(clean)
      clean("config")
    warning("'", file.path(boot.dir(), "initial/config"), "' is deprecated, ",
            "use DATA.bib entry instead")
    cp(file.path(boot.dir(), "initial/config"), ".")
  }

  # 1  Process software
  if(software && file.exists(file.path(boot.dir(), "SOFTWARE.bib")))
    out["SOFTWARE.bib"] <-
      process.bibfile("software", clean=clean, quiet=quiet, ...)

  # 2  Process data
  if(data && file.exists(file.path(boot.dir(), "DATA.bib")))
    out["DATA.bib"] <- process.bibfile("data", clean=clean, quiet=quiet, ...)

  # Remove empty folders
  rmdir(file.path(boot.dir(), c("data", "library", "software")), recursive=TRUE)
  rmdir(file.path(boot.dir(), "library:"), recursive=TRUE)  # sometimes in Linux

  if(!quiet)
    msg("Boot procedure done")

  invisible(out)
}

#' @export

# Equivalent spelling

taf.bootstrap <- function(...)
{
  taf.boot(...)
}
