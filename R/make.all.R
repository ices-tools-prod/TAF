#' Run All TAF Scripts as Needed
#'
#' Run core TAF scripts that have changed, or if previous steps were rerun.
#'
#' @param \dots passed to \code{\link{make.taf}}.
#'
#' @return Logical vector indicating which scripts were run.
#'
#' @note
#' TAF scripts that will be run as needed are: \verb{utilities.R},
#' \verb{data.R}, \verb{model.R}, \verb{output.R}, and \verb{report.R}.
#'
#' The \verb{model.R} script may also be named \verb{method.R} and is treated in
#' the same way.
#'
#' @seealso
#' \code{\link{source}} runs any R script, \code{\link{source.taf}} is more
#' convenient for running a TAF script, and \code{\link{source.all}} runs all
#' TAF scripts.
#'
#' \code{\link{make}}, \code{\link{make.taf}}, and \code{\link{make.all}} are
#' similar to the \code{source} functions, except they avoid repeating tasks
#' that have already been run.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' make.all()
#' }
#'
#' @aliases makeAll
#'
#' @export

make.all <- function(...)
{
  scripts <- c("utilities.R", "data.R", model.script(), "output.R", "report.R")
  scripts <- scripts[file.exists(scripts)]

  out <- sapply(scripts, make.taf, ...)
  if(length(out) == 0)
    out <- logical(0)

  invisible(out)
}

#' @export

## Equivalent spelling

makeAll <- function(...)
{
  make.all(...)
}
