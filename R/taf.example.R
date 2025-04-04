#' TAF Example
#'
#' Copy example analysis from TAF package.
#'
#' @param name of TAF example analysis.
#' @param path where to create example directory. The default is the current
#'        working directory.
#' @param force whether to overwrite existing directory.
#'
#' @details Currently, the package comes with one example: \code{"linreg"}.
#'
#' @return Full path to directory that was created.
#'
#' @note
#' The example analysis is copied from the TAF package directory:
#' \preformatted{
#' dir(system.file("examples", package="TAF"), full=TRUE)
#' }
#'
#' @seealso
#' \code{\link{taf.skeleton}} creates an empty TAF template.
#'
#' \code{\link{linreg}} describes the \code{linreg} example.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' taf.example("linreg")
#' setwd("linreg")
#' taf.boot()
#' source.all()
#' }
#'
#' @importFrom tools file_path_as_absolute
#'
#' @export

taf.example <- function(name, path=".", force=FALSE)
{
  # Handle non-existing example
  example.dir <- system.file("examples", name, package="TAF")
  if(!dir.exists(example.dir))
    stop("example '", name, "' not found in TAF package")

  # Handle existing directory
  dest.dir <- file.path(path, name)
  if(dir.exists(dest.dir) && force)
    unlink(dest.dir, recursive=TRUE)
  if(dir.exists(dest.dir) && !force)
    stop("directory ", dest.dir, " exists already; consider force=TRUE")

  # Copy example
  dir.create(path, showWarnings=FALSE, recursive=TRUE)
  file.copy(example.dir, path, recursive=TRUE)

  invisible(file_path_as_absolute(dest.dir))
}
