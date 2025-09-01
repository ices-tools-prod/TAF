#' TAF Skeleton
#'
#' Create initial directories and R scripts for a new TAF analysis.
#'
#' @param path where to create initial directories and R scripts. The default is
#'        the current working directory.
#' @param force whether to overwrite existing scripts.
#' @param pkgs packages to load at the start of each script. The default is
#'        either \code{"TAF"} (if the icesTAF package is not attached) or
#'        \code{"icesTAF"} (if icesTAF is attached).
#' @param model.script model script filename, either \code{model.R} (default) or
#'        \code{method.R}.
#' @param gitignore whether to write TAF entries to a \file{.gitignore} file.
#'
#' @details
#' When \code{gitignore = TRUE}, the following entries will be written to a
#' \verb{.gitignore} file, appending if the file exists already:
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
#' @return Full path to analysis directory.
#'
#' @note
#' After running \code{taf.skeleton()} to create a new TAF workflow, the author
#' can populate the \code{boot/initial/data} folder with initial data files and
#' run \code{draft.data(file=TRUE)} to produce a \code{DATA.bib} file.
#'
#' The next step is then to run \code{taf.boot()} to populate the
#' \code{boot/data} folder and start editing the \code{data.R} script, reading
#' files from the \code{boot/data} folder.
#'
#' @seealso
#' \code{\link{taf.example}} copies an example analysis from the TAF package.
#'
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

taf.skeleton <- function(path = ".", force = FALSE, pkgs = taf.pkg(),
                         model.script = "model.R", gitignore = TRUE)
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
  template <- paste0("# %s\n\n# Before:\n# After:\n\n",
                     paste0("library(", pkgs, ")", collapse = "\n"),
                     "\n\nmkdir(\"%s\")\n\n")
  headers <- list(
    data = "Prepare data, write CSV data tables",
    model = "Run analysis, write model results",
    output = "Extract results of interest, write CSV output tables",
    report = "Produce plots and tables for report")
  if (model.script %in% c("method", "method.R")) {
    names(headers)[2] <- "method"
  }

  # create TAF scripts
  for (section in names(headers)) {
    safe.cat(sprintf(template, headers[[section]], section),
             file = paste0(section, ".R"),
             force = force)
  }

  if (gitignore) {
    ignore <- c("/boot/data", "/boot/library", "/boot/software", "/data",
                paste0("/", file_path_sans_ext(model.script)), "/output",
                "/report", "*.Rproj", ".RData", ".Rhistory", ".Rproj.user",
                ".Ruserdata")
    if (file.exists(".gitignore"))
      ignore <- ignore[!ignore %in% readLines(".gitignore")]
    if (length(ignore) > 0)
      write(ignore, ".gitignore", append = TRUE)
  }

  invisible(getwd())
}

#' @rdname TAF-internal
#'
#' @export

# Returns either "TAF" (if icesTAF is not attached) or "icesTAF" (if icesTAF is
# attached)

taf.pkg <- function()
{
  if("package:icesTAF" %in% search())
    "icesTAF"
  else
    "TAF"
}
