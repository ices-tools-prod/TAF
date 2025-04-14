#' Install package dependencies of a TAF analysis
#'
#' Search R scripts for packages that are required and install them.
#'
#' @param ... arguments passed on to \link{install.packages}
#' @param path a directory or file containing R scripts.
#'
#' @details
#'
#' This function additionally looks in the TAF boot directory for packages
#' that are required by the TAF boot process (i.e. called from a boot script).
#'
#' @seealso
#'
#' \link{deps}
#' \link{install.packages}
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
#' deps(taf.boot.path())
#'
#' # install (uninstalled) dependencies
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
