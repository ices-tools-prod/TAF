#' Read Metadata Entries
#'
#' Read metadata entries written in BibTeX format.
#'
#' @param file \file{*.bib} file to parse.
#'
#' @return List of metadata entries.
#'
#' @note
#' This function was created when the \pkg{bibtex} package was temporarily
#' removed from CRAN. The current implementation reduces the \pkg{TAF} package
#' dependencies to base R and nothing else.
#'
#' This parser is similar to the \code{read.bib} function in the \pkg{bibtex}
#' package, except:
#' \itemize{
#' \item It returns a plain list instead of class \code{bibentry}.
#' \item The fields \code{bibtype} and \code{key} are stored as list elements
#'       instead of attributes.
#' }
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
  x <- x[!grepl("^\\s*[%#]", x)]
  # remove empty lines
  x <- trimws(x)
  x <- x[nzchar(x)]

  # split into entries
  x <- paste(c("}", x), collapse = "")
  x <- paste0("@", strsplit(x, "\\}@")[[1]][-1], "}")

  # convert key and bibtype entry
  x <- gsub(
    "@+([a-zA-Z]+)\\{([^,]+),",
    "bibtype = {\\1}, key = {\\2}, ",
    x
  )
  x <- strsplit(x, "\\}\\s*,\\s*")
  x <-
    sapply(
      x,
      function(y) {
        y <- gsub("\\s*=\\s*\\{\\s*", "\" = \"", y)
        y <- gsub("\\}+", "", y)
        y <- y[nzchar(y)]
        paste0("list(", paste(paste0("\"", y, "\""), collapse = ","), ")")
      }
    )
  x <- paste0("list(", paste(x, collapse = ","), ")")

  bib <- eval(parse(text = x))
  names(bib) <- sapply(bib, "[[", "key")

  bib
}
