#' Clean TAF Directories
#'
#' Remove TAF directories (\verb{data}, \verb{model}, \verb{output},
#' \verb{report}) and/or clean the \verb{boot} directory.
#'
#' @param dirs directories to delete.
#' @param force passed to \code{clean.software}, \code{clean.library}, and
#'        \code{clean.data} if any of the \code{dirs} is \code{"boot"}.
#'
#' @return No return value, called for side effects.
#'
#' @note
#' The purpose of removing the directories is to make sure that subsequent TAF
#' scripts start by creating new empty directories.
#'
#' If any of the \code{dirs} is \code{"boot"} it is treated specially. Instead
#' of completely removing the \verb{boot} directory, only the subdirectories
#' \verb{data} is removed, while \code{clean.software} and \code{clean.library}
#' are used to clean the \verb{boot/software} and \verb{boot/library}
#' subdirectories. This protects the subdirectory \verb{boot/initial} and
#' \verb{*.bib} metadata files from being accidentally deleted.
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
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' clean()
#' clean("boot")
#' }
#'
#' @export

clean <- function(dirs=c("data", "model", "output", "report"), force=FALSE)
{
  ## Convert "boot/" to "boot", so clean("boot/") doesn't go wild
  dirs <- sub("/$", "", dirs)

  if("boot" %in% dirs || "bootstrap" %in% dirs)
  {
    ## An odd directory called 'library:' can appear in Linux
    unlink(file.path(boot.dir(),"library:"), recursive=TRUE)
    clean.software(file.path(boot.dir(),"software"), force=force)
    clean.library(file.path(boot.dir(),"library"), force=force)
    clean.data(file.path(boot.dir(),"data"), force=force)
    dirs <- dirs[dirs != boot.dir()]
  }

  unlink(dirs, recursive=TRUE)
}
