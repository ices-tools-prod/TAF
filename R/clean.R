#' Clean TAF Directories
#'
#' Remove working TAF directories (\verb{data}, \verb{method}, \verb{output},
#' \verb{report}), \verb{boot}, or other directories.
#'
#' @param dirs directories to delete.
#' @param force passed to \code{software} and \code{clean.library} if any of the
#'        \code{dirs} is \code{"boot"}.
#'
#' @note
#' The purpose of removing the directories is to make sure that subsequent TAF
#' scripts start by creating new empty directories.
#'
#' If any of the \code{dirs} is \code{"boot"} it is treated specially.
#' Instead of completely removing the \verb{boot} directory, only the
#' subdirectories \verb{data} is removed, while \code{clean.software} and
#' \code{clean.library} are used to clean the \verb{boot/software} and
#' \verb{boot/library} subdirectories. This protects the subdirectory
#' \verb{boot/initial} and \verb{*.bib} metadata files from being
#' accidentally deleted.
#'
#' @seealso
#' \code{\link{clean.software}} selectively removes software from
#' \verb{boot/software}.
#'
#' \code{\link{clean.library}} selectively removes packages from
#' \verb{boot/library}.
#'
#' \code{\link{clean.data}} selectively removes data from \verb{boot/data}.
#'
#' \code{\link{mkdir}} and \code{\link{rmdir}} create and remove empty
#' directories.
#'
#' \code{\link{icesTAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' clean()
#' }
#'
#' @export

clean <- function(dirs=unlist(taf.constants$taf.sections), force=FALSE)
{
  ## Convert "boot/" to "boot", so clean("boot/") doesn't go wild
  dirs <- sub("/$", "", dirs)

  if(taf.constants$boot %in% dirs)
  {
    ## An odd directory called 'library:' can appear in Linux
    unlink(file.path(taf.constants$boot, "library:"), recursive = TRUE)
    clean.software(force=force)
    clean.library(force=force)
    clean.data(force=force)
    dirs <- dirs[dirs != taf.constants$boot]
  }

  unlink(dirs, recursive=TRUE)
}
