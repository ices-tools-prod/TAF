#' Clean TAF Directories
#'
#' Remove TAF directories: \verb{data}, \verb{model}, \verb{output}, and
#' \verb{report}.
#'
#' @param dirs directories to delete.
#' @param force passed to \code{clean.boot} if any of the \code{dirs} is
#'        \code{"boot"}.
#'
#' @details
#' The \verb{model} directory may also be named \verb{method} and is cleaned in
#' the same way.
#'
#' @return No return value, called for side effects.
#'
#' @note
#' The purpose of removing the directories is to make sure that subsequent TAF
#' scripts start by creating new empty directories.
#'
#' If any of the \code{dirs} is \code{"boot"}, it is treated specially and
#' \code{clean.boot} is called to clean the \verb{boot} directory.
#'
#' In other words, \code{clean("boot")} and \code{clean.boot()} are
#' interchangeable, the latter providing a slightly clearer interface that was
#' introduced in version 4.2.0.
#'
#' @seealso
#' \code{\link{clean.boot}} cleans the boot directory.
#'
#' \code{\link{mkdir}} and \code{\link{rmdir}} create and remove empty
#' directories.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' clean()
#' clean.boot()
#' }
#'
#' @export

clean <- function(dirs=c("data", model.dir(), "output", "report"), force=FALSE)
{
  # Convert "boot/" to "boot", so clean("boot/") doesn't go wild
  dirs <- sub("/$", "", dirs)

  if("boot" %in% dirs || "bootstrap" %in% dirs)
  {
    clean.boot(force=force)
    dirs <- dirs[dirs != boot.dir()]
  }

  unlink(dirs, recursive=TRUE)
}
