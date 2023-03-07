#' Clean Boot Directory
#'
#' Clean the boot directory using \code{clean.data}, \code{clean.library}, and
#' \code{clean.software}.
#'
#' @param force passed to \code{clean.data}, \code{clean.library}, and
#'        \code{clean.software}.
#'
#' @return No return value, called for side effects.
#'
#' @note
#' Instead of completely removing the \verb{boot} directory, \code{clean.data},
#' \code{clean.library}, and \code{clean.software} are used to clean the
#' \verb{boot/data}, \verb{boot/library}, and \verb{boot/library}
#' subdirectories. This protects the subdirectory \verb{boot/initial}, boot
#' scripts, and \verb{*.bib} metadata files from being accidentally deleted.
#'
#' @seealso
#' \code{\link{clean.data}} selectively removes data from \verb{boot/data}.
#'
#' \code{\link{clean.library}} selectively removes packages from
#' \verb{boot/library}.
#'
#' \code{\link{clean.software}} selectively removes software from
#' \verb{boot/software}.
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

clean.boot <- function(force=FALSE)
{
  ## An odd directory called 'library:' can appear in Linux
  unlink(file.path(boot.dir(),"library:"), recursive=TRUE)

  clean.data(file.path(boot.dir(),"data"), force=force)
  clean.library(file.path(boot.dir(),"library"), force=force)
  clean.software(file.path(boot.dir(),"software"), force=force)
}
