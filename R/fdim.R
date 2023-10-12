#' FLR Dimensions
#'
#' Show the dimensions of an FLR table.
#'
#' @param x an FLR table in \code{FLQuant} format or in a 7-column
#'        \code{data.frame} format.
#' @param reduce is whether to omit single-level dimensions.
#'
#' @details
#' \code{x} can also be an arbitrary data frame (not related to FLR) where the
#' last column is the measurement variable.
#'
#' @return Named vector showing the dimension names and number of levels.
#'
#' @seealso
#' \code{\link{dim}}, \code{\link{dimnames}}, and \code{\link{names}} are the
#' base functions to access dimension names and levels.
#'
#' \code{\link{as.data.frame}} is a method provided by the \pkg{FLCore} package
#' to convert \code{FLQuant} tables to a 7-column long format.
#'
#' \code{\link{flr2taf}} converts an FLR table to TAF format.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' library(FLCore)
#' flq <- FLQuant(t(catage.xtab), dimnames=list(age=1:4, year=1963:1970))
#' df <- as.data.frame(flq)
#' fdim(flq)
#' fdim(df)
#' fdim(df, TRUE)
#' }
#' # Any data frame where the last column is the measurement variable
#' fdim(catage.long)
#' fdim(esoph[-5])
#' fdim(rev(warpbreaks))
#' fdim(rev(ToothGrowth))
#'
#' @export

fdim <- function(x, reduce=FALSE)
{
  x <- as.data.frame(x)
  out <- sapply(x, function(x) length(unique(x)))[-ncol(x)]
  if(reduce)
    out <- out[out != 1]
  out
}
