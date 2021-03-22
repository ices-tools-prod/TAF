#' TAF Skeleton
#'
#' Create initial directories and R scripts for a new TAF analysis.
#'
#' @param path where to create initial directories and R scripts. The default is
#'        the current working directory.
#' @param force whether to overwrite existing scripts.
#'
#' @return Full path to analysis directory.
#'
#' @seealso
#' \code{\link{package.skeleton}} creates an empty template for a new R package.
#'
#' \code{\link{icesTAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' taf.skeleton()
#' }
#'
#' @export

taf.skeleton <- function(path = ".", force = FALSE)
{
  # only overwrite files if force = TRUE
  safe.cat <- function(..., file, force) {
    if (!file.exists(file) || force) {
      cat(..., file = file)
    }
  }

  # create analysis directory
  mkdir(path)
  owd <- setwd(path)
  on.exit(setwd(owd))

  # create initial directories
  mkdir(file.path(taf.constants$boot, "initial", "data"))

  # define headers
  template <- paste0("## %s\n\n## Before:\n## After:\n\n",
                     "library(TAF)\n\nmkdir(\"%s\")\n\n")
  headers <- list(
    "Preprocess data, write TAF data tables",
    "Run analysis, write method results",
    "Extract results of interest, write TAF output tables",
    "Prepare plots and tables for report"
  )
  names(headers) <- unlist(taf.constants$taf.sections)

  # create TAF scripts
  for (section in names(headers)) {
    safe.cat(sprintf(template, headers[[section]], section),
             file = paste0(section, ".R"),
             force = force)
  }

  invisible(getwd())
}
