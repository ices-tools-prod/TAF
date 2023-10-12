#' TAF Libraries
#'
#' Load and attach all packages from local TAF library.
#'
#' @param messages whether to show messages when package loads.
#' @param warnings whether to show warnings when package loads.
#'
#' @return \code{TRUE} (invisibly) if all packages loaded.
#'
#' @note
#' Packages in the TAF library are loaded in the order in which they are
#' listed in \verb{SOFTWARE.bib}. Internal dependencies can in this way be
#' respected.
#'
#' @seealso
#' \code{\link{taf.library}} is the TAF function called for each found package.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' # Load all packages in TAF library
#' taf.libraries()
#' }
#'
#' @export

taf.libraries <- function(messages=FALSE, warnings=FALSE) {

  bib <- read.bib(file.path(boot.dir(), "SOFTWARE.bib"))
  entries <- names(bib)
  installed <- taf.library()
  pkgs <- entries[entries %in% installed]

  res <- lapply(pkgs, function(x) {
    if(dir.exists(file.path(boot.dir(), "library", x)))
      do.call("taf.library", list(package=x, messages=messages,
        warnings=warnings))
    })

  invisible(TRUE)
}
