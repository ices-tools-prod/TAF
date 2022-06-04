#' Axis Limits
#'
#' Compute reasonable axis limits for plotting non-negative numbers.
#'
#' @param x a vector of data values.
#' @param mult a number to multiply with the highest data value.
#'
#' @return A vector of length two, which can be used as axis limits.
#'
#' @note
#' The lower limit is set to 0, and the upper limit is determined by the highest
#' data value, times a multiplier.
#'
#' @seealso
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' plot(precip)
#' plot(precip, ylim=lim(precip))
#' plot(precip, ylim=lim(precip), yaxs="i")
#'
#' @export

lim <- function(x, mult=1.1)
{
  c(0, mult*max(x,na.rm=TRUE))
}
