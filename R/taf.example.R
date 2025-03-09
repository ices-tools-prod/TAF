#' TAF Example
#'
#' Copy example analysis from TAF package.
#'
#' @param name of TAF example analysis.
#' @param path where to create example directory. The default is the current
#'        working directory.
#' @param force whether to overwrite existing directory.
#' @param gitignore whether to write TAF entries to a \file{.gitignore} file.
#'
#' @details
#' When \code{gitignore = TRUE}, the following entries will be written to a
#' \verb{.gitignore} file:
#' \preformatted{
#' /boot/data
#' /boot/library
#' /boot/software
#' /data
#' /model
#' /output
#' /report
#' *.Rproj
#' .RData
#' .Rhistory
#' .Rproj.user
#' .Ruserdata
#' }
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
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' taf.example()
#' }
#'
#' @importFrom tools file_path_as_absolute
#'
#' @export

taf.example <- function(name="linreg", path=".", force=FALSE, gitignore=FALSE)
{
  # Handle existing directory
  dest.dir <- file.path(path, name)
  if(dir.exists(dest.dir) && force)
    unlink(dest.dir, recursive=TRUE)
  if(dir.exists(dest.dir) && !force)
    stop("directory ", dest.dir, " exists already; consider force=TRUE")

  # Handle non-existing example
  example.dir <- system.file("examples", name, package="TAF")
  if(!dir.exists(example.dir))
    stop("example '", name, "' not found in TAF package")

  # Copy example
  dir.create(path, showWarnings=FALSE, recursive=TRUE)
  file.copy(example.dir, path, recursive=TRUE)

  # Add .gitignore
  if(gitignore)
  {
    ignore <- c("/boot/data", "/boot/library", "/boot/software", "/data",
                "/model", "/output", "/report", "*.Rproj", ".RData",
                ".Rhistory", ".Rproj.user", ".Ruserdata")
    write(ignore, file.path(path, name, ".gitignore"))
  }

  invisible(file_path_as_absolute(dest.dir))
}
