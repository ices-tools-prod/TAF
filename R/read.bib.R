#' bibtex parser
#'
#' Parser for bibliography databases written in the bib format.
#'
#' @param file bib file to parse
#'
#' @details
#' Upload a table of F at age to the ICES TAF results database.
#' The \code{data} and \code{assessment_info} will be checked against
#' a schema, and any errors reported back to the user as attributes to
#' the FALSE return value.
#'
#' @return TRUE if successfull, FALSE otherwise
#'
#' @note
#' The \code{data} argument expects a data.frame with the first
#' column named "year" as described in the help for
#' \code{\link{xtab2taf}}.
#'
#' @seealso
#' The \code{\link{xtab2taf}} function is to create a data.frame
#'
#' \code{\link{taf.png}} opens a PNG graphics device.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
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
