#' @docType data
#'
#' @name catage.wide
#'
#' @title Catch at Age in Wide Format
#'
#' @description
#' Catch-at-age table to describe a wide format data frame to store
#' area-year-age values.
#'
#' @usage
#' catage.wide
#'
#' @format
#' Data frame containing six columns:
#' \tabular{ll}{
#'   \code{Area} \tab area\cr
#'   \code{Year} \tab year\cr
#'   \code{1}    \tab number of one-year-olds in the catch (millions)\cr
#'   \code{2}    \tab number of two-year-olds in the catch (millions)\cr
#'   \code{3}    \tab number of three-year-olds in the catch (millions)\cr
#'   \code{4}    \tab number of four-year-olds in the catch (millions)
#' }
#'
#' @details
#' The data are an excerpt (first years and ages) from the catch-at-age table
#' for North Sea cod from the ICES (2016) assessment. Catches in \sQuote{area 1}
#' are the original data, while \sQuote{area 2} contains the same values
#' multiplied by two.
#'
#' @source
#' ICES (2016).
#' Report of the working group on the assessment of demersal stocks in the North
#' Sea and Skagerrak (WGNSSK).
#' \emph{ICES CM 2016/ACOM:14}, p. 673.
#' \doi{10.17895/ices.pub.5329}.
#'
#' @seealso
#' \code{\link{catage.taf}} describes the TAF format.
#'
#' \code{\link{taf2long}} converts a TAF table to long format.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#'
#' @examples
#' catage.wide
#' wide2long(catage.wide)

NA
