#' TAF Library
#'
#' Load and attach package from local TAF library.
#'
#' @param package name of a package found in \verb{boot/library}.
#' @param messages whether to show messages when package loads.
#' @param warnings whether to show warnings when package loads.
#'
#' @return The names of packages currently installed in the TAF library.
#'
#' @note
#' The purpose of the TAF library is to retain R packages that are not commonly
#' used (and not on CRAN), to support long-term reproducibility of TAF analyses.
#'
#' If a package has dependencies that are also in the TAF library, they will be
#' loaded in preference of any version that may be installed in the system or
#' user library. To force the use of a dependency from outside of the TAF
#' library call \verb{library(package)} prior to the call to \verb{taf.library}.
#'
#' @seealso
#' \code{\link{library}} is the underlying base function to load and attach a
#' package.
#'
#' \code{\link{taf.boot}} is the procedure to install packages into a local TAF
#' library, via the \verb{SOFTWARE.bib} metadata file.
#'
#' \code{\link{detach.packages}} detaches all packages.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#'
#' # Show packages in TAF library
#' taf.library()
#'
#' # Load packages
#' taf.library(this)
#' taf.library(that)
#' }
#'
#' @export

taf.library <- function(package, messages=FALSE, warnings=FALSE)
{
  # If taf.library() is called from boot data script, the working directory is
  # root/boot/data/scriptname; change to root temporarily
  if(basename(dirname(dirname(getwd()))) %in% c("boot","bootstrap"))
  {
    owd <- setwd("../../.."); on.exit(setwd(owd))
  }

  if(!dir.exists(file.path(boot.dir(),"library")))
    stop("directory 'boot/library' not found")

  installed <- dir(file.path(boot.dir(), "library"))
  if(missing(package))
    return(installed)

  package <- as.character(substitute(package))
  if(!(package %in% installed))
    stop("there is no package '", package, "' in boot/library")

  # Add bootstrap/library to lib path, using that rather than external library
  opath <- .libPaths()
  .libPaths(c(file.path(boot.dir(),"library"), opath))
  on.exit(.libPaths(opath), add=TRUE)

  supM <- if(messages) identity else suppressMessages
  supW <- if(warnings) identity else suppressWarnings
  supW(supM(library(package, lib.loc=file.path(boot.dir(),"library"),
                    character.only=TRUE)))
}
