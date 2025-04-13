#' Install package dependencies of a TAF analysis
#'
#' Search R scripts for packages that are required and install them.
#'
#' @param ... arguments passed on to \link{install.packages}
#' @param path a directory or file containing R scripts.
#'
#' @seealso
#'
#' \link{deps}
#'
#' @examples
#' \dontrun{
#'
#' library(TAF)
#'
#' # Download a TAF analysis
#' download("https://github.com/ices-taf/2019_san.sa.6/archive/refs/heads/master.zip")
#' unzip("master.zip")
#'
#' # move into analysis folder
#' setwd("2019_san.sa.6-master")
#'
#' # list dependencies
#' deps()
#'
#' # install dependencies
#' install.deps()
#' }
#'
#' @importFrom TAF deps
#' @importFrom utils install.packages
#'
#' @export
install.deps <- function(path = ".", ...) {
  od <- setwd(path)
  on.exit(setwd(od))

  taf_script_deps <- deps(installed = FALSE)
  boot_deps <- deps(taf.boot.path(), installed = FALSE)

  install.packages(unique(c(taf_script_deps, boot_deps)), ...)
}
