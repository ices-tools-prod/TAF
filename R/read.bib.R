#' Bibtex Parser
#'
#' Parser for Bibtex entries.
#'
#' @param file \file{*.bib} file to parse.
#'
#' @return List containing Bibtex entries.
#'
#' @note
#' This parser is similar to the \code{\link[bibtex]{read.bib}} function in the
#' \pkg{bibtex} package, except:
#' \itemize{
#' \item It returns a plain list instead of class \code{bibentry}.
#' \item The fields \code{bibtype} and \code{key} are stored as plain list
#'       elements instead of attributes.
#' }
#'
#' @seealso
#' \code{\link{taf.sources}} calls this function to import metadata entries.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
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
