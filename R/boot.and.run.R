#' Boot and Run
#'
#' Boot and run TAF analysis, possibly from a different directory.
#'
#' @param dir directory containing TAF analysis.
#' @param clean whether to clean the boot directory and remove \verb{data},
#'        \verb{model}, \verb{output}, and \verb{report} before running the
#'        analysis.
#' @param force passed to \code{\link{clean.boot}}.
#' @param make whether to run \code{make.all} instead of \code{source.all}.
#'
#' @return \code{TRUE} (invisibly) if the TAF analysis ran without errors.
#'
#' @note
#' TAF scripts that will be run if they exist are: \verb{utilities.R},
#' \verb{data.R}, \verb{model.R}, \verb{output.R}, and \verb{report.R}.
#'
#' The \verb{model.R} script may also be named \verb{method.R} and is treated in
#' the same way.
#'
#' @seealso
#' \code{\link{taf.boot}} runs the boot procedure.
#'
#' \code{\link{source.all}} and \code{\link{make.all}} run the TAF scripts.
#'
#' \code{\link{clean.analysis}} cleans a TAF analysis, possibly from a different
#' directory.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' # Run selected analyses
#' boot.and.run("analysis_1")
#' boot.and.run("analysis_2")
#' boot.and.run("different/directory/analysis_3")
#'
#' # Run all analyses in current directory
#' dirs <- dir()[dir.exists(dir())]
#' result <- sapply(dirs, boot.and.run)
#' }
#'
#' @export

boot.and.run <- function(dir=".", clean=TRUE, force=TRUE, make=FALSE)
{
  owd <- setwd(dir)
  on.exit(setwd(owd))

  # Boot
  taf.boot(clean=clean, force=force)

  # Run
  if(make)
    make.all(clean=clean)
  else
    source.all(clean=clean)

  invisible(TRUE)
}
