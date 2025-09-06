#' Dependencies of a Package
#'
#' Find dependencies or reverse dependencies of a CRAN package.
#'
#' @param packages package names.
#' @param recursive whether to include dependencies of dependencies.
#' @param reverse whether to find reverse dependencies instead.
#' @param base whether to include base packages.
#' @param installed whether to include installed packages.
#' @param available whether to include available packages.
#' @param sort whether to sort package dependencies.
#' @param ... passed to \code{package_dependencies}.
#'
#' @return Names of packages that are required by \code{package}.
#'
#' @seealso
#' \code{\link{package_dependencies}} is the underlying base function to find
#' CRAN package dependencies.
#'
#' \code{\link{installed.packages}}, \code{\link{available.packages}}.
#'
#' \code{\link{deps}} shows the dependencies of a workflow.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' # TAF dependencies
#' pdeps("TAF")                # does not depend on non-base packages
#' pdeps("TAF", base=TRUE)     # depends on these base packages
#' pdeps("TAF", reverse=TRUE)  # icesTAF depends on TAF
#'
#' # Other packages with light dependencies
#' sapply(pdeps(c("data.table", "Rcpp", "renv")), length)
#'
#' # ggplot2 dependencies
#' pdeps("ggplot2")                   # full list of dependencies
#' pdeps("ggplot2", recursive=FALSE)  # primary dependencies
#'
#' # Each ggplot2 dependency brings in these secondary dependencies
#' pdeps(pdeps("ggplot2", recursive=FALSE)$ggplot2)
#' }
#'
#' @importFrom tools package_dependencies
#' @importFrom utils available.packages installed.packages
#'
#' @export

pdeps <- function(packages, recursive=TRUE, reverse=FALSE, base=FALSE,
                  installed=TRUE, available=TRUE, sort=FALSE, ...)
{
  # Get all package dependencies
  pkgs <- package_dependencies(packages, recursive=recursive,
                               reverse=reverse, ...)

  # Maybe exclude base/installed/available
  if(!base)
    pkgs <- lapply(pkgs, function(p)
      p[!(p %in% rownames(installed.packages(priority="high")))])
  if(!installed)
    pkgs <-
      lapply(pkgs, function(p) p[!(p %in% rownames(installed.packages()))])
  if(!available)
    pkgs <-
      lapply(pkgs, function(p) p[!(p %in% rownames(available.packages()))])

  # Format output
  if(sort)
    pkgs <- lapply(pkgs, sort)

  pkgs
}
