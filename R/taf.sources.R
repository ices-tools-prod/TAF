#' List Sources
#'
#' List metadata entries from \code{DATA.bib}, \code{SOFTWARE.bib}, or both.
#'
#' @param type one of \code{"data"}, \code{"software"} or \code{"both"}.
#'
#' @return List of metadata entries.
#'
#' @note
#' The functionality is similar to \code{read.bib}, with the addition of a
#' \code{type} field, indicating whether an entry is \code{data}
#' \code{software}.
#'
#' This function is used internally by the \code{taf.boot} procedure and is
#' also useful when organizing a larger TAF project.
#'
#' @seealso
#' \code{\link{taf.boot}} reads and processes metadata entries.
#'
#' \code{\link{read.bib}} is the underlying function to read metadata entries.
#'
#' \code{\link{process.entry}} processes a single metadata entry, in the list
#' format returned by \code{taf.sources}.
#'
#' @examples
#' \dontrun{
#' taf.sources("data")
#' taf.sources("software")
#' taf.sources("both")
#' }
#'
#' @export

taf.sources <- function(type) {
  # check type arg
  type <- match.arg(type, c("data", "software", "both"))

  # handle "both" with a recursive early return
  if (type == "both")
    return(c(taf.sources("data"), taf.sources("software")))

  bibfile <- file.path(boot.dir(), paste0(toupper(type), ".bib"))
  sources <- read.bib(bibfile)

  # check for duplicates
  dups <- anyDuplicated(names(sources))
  if (dups) {
    stop("Duplicated key: '", names(sources)[dups], "'")
  }

  # add type field (data or software)
  sources <-
    lapply(
      sources,
      function(x) {
        x$type <- type
        x
      }
    )

  sources
}
