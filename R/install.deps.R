#' Install Dependencies
#'
#' Search R scripts for packages that are required and install those that are
#' not already installed. The default install location is the same as
#' \code{install.packages}.
#'
#' @param path a directory or file containing R code.
#' @param ... passed to \code{install.packages}.
#'
#' @details
#' This function also looks in the TAF boot directory for packages that are
#' required by the TAF boot process, i.e., called from a boot script.
#'
#' In addition it runs taf.boot on SOFTWARE.bib to install any special packages that may not be available on CRAN.
#'
#' @seealso
#' \code{\link{install.packages}} is the underlying function to install
#' packages.
#'
#' \code{\link{deps}} searches R scripts for packages that are required.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' # Download a TAF analysis
#' download(file.path("https://github.com/ices-taf/2019_san.sa.6",
#'                    "archive/refs/heads/master.zip"))
#' unzip("master.zip")
#' setwd("2019_san.sa.6-master")
#'
#' # List dependencies
#' deps()
#' deps(taf.boot.path())
#'
#' # Install dependencies that are not already installed
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

  sources <- taf.sources(type = "software")
  taf_packages <- names(sources)[grepl("@", sapply(sources, "[[", "source"))]

  taf_script_deps <- deps(installed = FALSE)
  boot_deps <- deps(taf.boot.path(), installed = FALSE)

  required_deps <-
    setdiff(unique(c(taf_script_deps, boot_deps)), taf_packages)

  install.packages(required_deps, ...)
}
