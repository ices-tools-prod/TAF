#' TAF Skeleton
#'
#' Create initial directories and R scripts for a new TAF analysis.
#'
#' @param path where to create initial directories and R scripts. The default is
#'        the current working directory.
#' @param force whether to overwrite existing scripts.
#' @param pkgs packages to load at the start of each script. The default is the
#'        TAF package, i.e. \code{library(TAF)}.
#' @param model.script model script filename, either \code{model.R} (default) or
#'        \code{method.R}.
#'
#' @return Full path to analysis directory.
#'
#' @seealso
#' \code{\link{package.skeleton}} creates an empty template for a new R package.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' taf.skeleton()
#' }
#'
#' @export

taf.skeleton <- function(path = ".", force = FALSE, pkgs = "TAF",
                         model.script = "model.R")
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
  mkdir("boot/initial/data")

  # define headers
  template <- paste0("## %s\n\n## Before:\n## After:\n\n",
                     paste0("library(", pkgs, ")", collapse = "\n"),
                     "\n\nmkdir(\"%s\")\n\n")
  headers <- list(
    data = "Preprocess data, write TAF data tables",
    model = "Run analysis, write model results",
    output = "Extract results of interest, write TAF output tables",
    report = "Prepare plots and tables for report")
  if (model.script %in% c("method", "method.R")) {
    names(headers)[2] <- "method"
  }

  # create TAF scripts
  for (section in names(headers)) {
    safe.cat(sprintf(template, headers[[section]], section),
             file = paste0(section, ".R"),
             force = force)
  }

  invisible(getwd())
}
