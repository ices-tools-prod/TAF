#' Data Dimensions
#'
#' Show the data dimensions of a table.
#'
#' @param x a data frame where the first columns are dimension variables and the
#'        last column is a measurement variable.
#' @param reduce is whether to omit single-level dimensions.
#'
#' @details
#' Dimension variables can include year, age, region, fleet, survey, or the
#' like, generally an integer or string. The measurement variable can be catch,
#' fishing mortality, maturity, weight, or the like, often a decimal.
#'
#' \code{x} can also be an FLR table in \code{FLQuant} format.
#'
#' @return Named vector showing the dimension names and number of levels.
#'
#' @seealso
#' \code{\link{unique}} is the base function to extract the levels of a
#' dimension variable.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' # Long table format, 8 years and 4 ages
#' ddim(catage.long)
#'
#' # Some base R datasets
#' ddim(esoph[-5])
#' ddim(rev(warpbreaks))
#' ddim(rev(ToothGrowth))
#'
#' @importFrom methods is
#' @importFrom stats setNames
#'
#' @export

ddim <- function(x, reduce=FALSE)
{
  out <- if(is(x, "FLQuant"))
           setNames(dim(x), names(dimnames(x)))
         else
           sapply(x, function(col) length(unique(col)))[-ncol(x)]
  if(reduce)
    out <- out[out != 1]
  out
}
