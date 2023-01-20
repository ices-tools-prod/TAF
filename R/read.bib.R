#' Read Metadata Entries
#'
#' Read metadata entries written in the BibTeX format.
#'
#' @param file bib file to parse.
#'
#' @return List of metadata entries.
#'
#' @note
#' Inspired by (and roughly equivalent to) the \code{read.bib} function in the
#' \pkg{bibtex} package.
#'
#' This function was created when the \pkg{bibtex} package was temporarily
#' removed from CRAN. The current implementation reduces the \pkg{TAF} package
#' dependencies to base R and nothing else.
#'
#' See the TAF Wiki page on
#' \href{https://github.com/ices-taf/doc/wiki/Bib-entries}{bib entries}.
#'
#' @seealso
#' \code{\link{taf.boot}} reads and processes metadata entries.
#'
#' \code{\link{taf.sources}} reads metadata entries and adds a \code{type}
#' field.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' bib <- read.bib("DATA.bib")
#' str(bib)
#' }
#'
#' @export

read.bib <- function(file) {
  x <- readLines(file, warn = FALSE)

  # remove comments (# or %)
  x <- x[!grepl("^\\s*[%#].*$", x)]
  # remove empty lines
  x <- trimws(x)
  x <- x[nzchar(x)]

  # split into entiries
  x <- paste(c("}", x), collapse = "")
  x <- paste0("@", strsplit(x, "\\}@")[[1]][-1], "}")

  # convert key and bibtype entry
  x <- gsub(
    "@+([a-zA-Z]+)[{]([^,]+),",
    "bibtype = {\\1}, key = {\\2}, ",
    x
  )
  x <- strsplit(x, "\\}\\s*,\\s*")
  x <-
    sapply(
      x,
      function(y) {
        y <- gsub("\\s*=\\s*\\{\\s*", "\" = \"", y)
        y <- gsub("[}]+", "", y)
        y <- y[nzchar(y)]
        paste0("list(", paste(paste0("\"", y, "\""), collapse = ","), ")")
      }
    )
  x <- paste0("list(", paste(x, collapse = ","), ")")

  bib <- eval(parse(text = x))
  names(bib) <- sapply(bib, "[[", "key")

  bib
}
