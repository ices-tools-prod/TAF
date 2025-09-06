#' Run All TAF Scripts
#'
#' Run core TAF scripts in current directory.
#'
#' @param ... passed to \code{\link{source.taf}}.
#'
#' @return Logical vector, indicating which scripts ran without errors.
#'
#' @note
#' TAF scripts that will be run if they exist are: \verb{utilities.R},
#' \verb{data.R}, \verb{model.R}, \verb{output.R}, and \verb{report.R}.
#'
#' The \verb{model.R} script may also be named \verb{method.R} and is treated in
#' the same way.
#'
#' @seealso
#' \code{\link{source.taf}} runs a TAF script.
#'
#' \code{\link{make.all}} runs all TAF scripts as needed.
#'
#' \code{\link{clean}} cleans TAF directories.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' source.all()
#' }
#'
#' @aliases sourceAll
#'
#' @export

source.all <- function(...)
{
  scripts <- c("utilities.R", "data.R", model.script(), "output.R", "report.R")
  scripts <- scripts[file.exists(scripts)]

  out <- sapply(scripts, source.taf, ...)
  if(length(out) == 0)
    out <- logical(0)

  invisible(out)
}

#' @export

# Equivalent spelling

sourceAll <- function(...)
{
  source.all(...)
}
