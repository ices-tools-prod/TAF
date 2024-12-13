#' Install packages listed in \verb{SOFTWARE.bib}
#'
#' The information on packages and their versions contained in
#' \verb{SOFTWARE.bib} is taken to install them. If the same precise
#' versions are requested, they are installed from the individual github
#' repositories using the stored hash reference. When the latest version of the 
#' listed packages is requested instead, they are downloaded from
#' r-universe.dev, including those packages available in CRAN.
#'
#' @param latest Whether to install the recorded packages versions. Logical, TRUE.
#' @param ... Extra arguments to be pass on to install_github.
#'
#' @return TRUE invisibly if succesfull
#'
#' @name install.software
#' @rdname install.software
#'
#' @seealso [TAF::check.software] [devtools::install_github]
#' @examples
#' \dontrun{
#' install.software()
#' install.software(latest=TRUE)
#' }
#'
#' @importFrom remotes install_github
#'
#' @export

install.software <- function(latest=FALSE, ...) {

  # GET list of packages in SOFTWARE.bib
  sources <- taf.sources('software')

  # INSTALL latest from r-universe
  if(latest) {
    sapply(sources, function(x) install.packages(x$key,
      repos=paste0("https://", strsplit(x$source, '/')[[1]][1],
        ".r-universe.dev")))
  # or exact version from github
  } else {
    sapply(sources, function(x) install_github(x$source, ...))
  }

  invisible(TRUE)
}
