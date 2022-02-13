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
#' This function is especially useful for organizing larger analyses.
#'
#' @seealso
#' \code{\link{read.bib}} reads metadata entries.
#'
#' \code{\link{process.entry}} processes a single metadata entry, in the list
#' format returned by \code{read.bib} and \code{taf.sources}.
#'
#' @examples
#' \dontrun{
#' taf.sources("data")
#' taf.sources("software")
#' }
#'
#' @export

taf.sources <- function(type) {
  # check type arg
  type <- match.arg(type, c("data", "software", "both"))

  bibfile <- file.path("bootstrap", paste0(toupper(type), ".bib"))
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
