#' Show Message
#'
#' Show a message, as well as the current time.
#'
#' @param ... passed to \code{message}.
#'
#' @return No return value, called for side effects.
#'
#' @seealso
#' \code{\link{message}} is the base function to show messages, without the
#' current time.
#'
#' \code{\link{source.taf}} reports progress using \code{msg}.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \donttest{
#' msg("script.R running...")
#' }
#'
#' @export

msg <- function(...)
{
  message(format(Sys.time(), "[%H:%M:%S] "), ...)
}
