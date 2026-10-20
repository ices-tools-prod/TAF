#' Clean TAF Analysis
#'
#' Remove boot directory and TAF directories (\verb{data}, \verb{model}, \verb{output}, and
#' \verb{report}), possibly from a different directory.
#'
#' @param dir directory containing TAF analysis.
#' @param force passed to \code{\link{clean.boot}}.
#'
#' @return No return value, called for side effects.
#'
#' @note
#' The \verb{model} directory may also be named \verb{method} and is cleaned in
#' the same way.
#'
#' @seealso
#' \code{\link{clean}} cleans TAF directories.
#'
#' \code{\link{boot.and.run}} boots and runs a TAF analysis, possibly from a
#' different directory.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' # Clean selected analyses
#' clean.analysis("analysis_1")
#' clean.analysis("analysis_2")
#' clean.analysis("different/directory/analysis_3")
#'
#' # Clean all analyses in current directory
#' dirs <- dir()[dir.exists(dir())]
#' result <- sapply(dirs, clean.analysis)
#' }
#'
#' @export

clean.analysis <- function(dir=".", force=TRUE)
{
  owd <- setwd(dir)
  on.exit(setwd(owd))

  clean.boot(force=force)
  clean()
}
