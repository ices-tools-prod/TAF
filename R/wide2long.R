#' Convert Wide Table to Long Format
#'
#' Convert a table from wide format to long format.
#'
#' @param x a data frame in wide format.
#' @param names a vector of two names for the last two columns of the resulting
#'        data frame.
#'
#' @return A data frame.
#'
#' @note
#' TAF stores tables as data frames, usually with a year column as seen in stock
#' assessment reports. Although year is the most common dimension, tables may
#' also include area, sex, season, or other additional dimensions. The
#' \code{catage.wide} table provides an example of a wide table that includes
#' area and year as dimensions. The long format is more convenient for analysis
#' and producing plots.
#'
#' @seealso
#' \code{\link{catage.taf}} and \code{\link{catage.wide}} describe the TAF and
#' wide formats.
#'
#' \code{\link{taf2long}} converts a TAF table to long format.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' wide2long(catage.wide, names=c("Age","Catch"))
#'
#' @importFrom utils read.table type.convert
#'
#' @export

wide2long <- function(x, names=c("Age", "Value"))
{
  # Select left columns and save their values as row labels
  cols <- grep("[0-9]", names(x), value=TRUE, invert=TRUE)
  rowlab <- apply(x[cols], 1, paste, collapse = "|")
  x <- x[!names(x) %in% cols]
  row.names(x) <- rowlab

  # Convert crosstab to long format
  x <- as.data.frame(as.table(as.matrix(x)), stringsAsFactors=FALSE)

  # Simplify data type
  x[[2]] <- type.convert(as.character(x[[2]]), as.is=TRUE)

  # Restore left columns
  left <- read.table(text=x[[1]], sep = "|", col.names=cols)
  x[[1]] <- NULL

  # Apply names and combine
  names(x) <- names
  x <- cbind(left, x)

  x
}
