#' Convert TAF Table to HTML
#'
#' Convert a data frame to HTML code and optionally write to a file.
#'
#' @param x a data frame.
#' @param file a filename, or special value \code{""}.
#' @param align a string (or a vector of strings) specifying alignment of data
#'        cells.
#' @param header a string (or a vector strings) specifying alignment of header
#'        cells.
#' @param digits significant digits for numeric columns.
#' @param center HTML attribute to indicate center alignment.
#' @param left HTML attribute to indicate left alignment.
#' @param right HTML attribute to indicate right alignment.
#' @param append whether to append to an existing file.
#'
#' @details
#' The \code{align} argument can be a vector of strings to specify
#' column-specific alignment, for example \code{c("l","r","l","l")}. Only the
#' first letter (case-insensitive) is used, so \code{"left"} is equivalent to
#' \code{"L"}. An empty string (the default), or any string that does not begin
#' with \code{C}, \code{L}, or \code{R} indicates no specific alignment.
#'
#' The \code{header} argument can be used to specify an alignment for the column
#' names that is different from the data values. The default is to use the same
#' alignment as the data values.
#'
#' The \code{center}, \code{left}, and \code{right} arguments can be used to
#' specify the exact HTML attribute to render alignment, for users who are
#' familiar with cascading style sheets (CSS). For example, the long-winded
#' \code{style="text-align:center"} could be shortened to \code{class="L"} if a
#' corresponding class has been defined in CSS.
#'
#' The default value \code{file = ""} prints the HTML code in the console,
#' instead of writing it to a file. The output can then be pasted into a file to
#' edit further, without accidentally overwriting an existing file.
#'
#' @return Character vector of class \verb{Bibtex}.
#'
#' @note
#' Although the output is HTML code, the \verb{Bibtex} class is used for
#' convenient display in the console.
#'
#' The resulting HTML conforms to the HTML5 standard and aims for compact
#' output, omitting optional closing tags and rendering each row of data as one
#' row of HTML code.
#'
#' @seealso
#' \code{\link{write.taf}} writes a data frame to a CSV file.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' taf2html(catage.taf)
#' taf2html(catage.taf, align=c("L","R","R","R","R"))
#'
#' \dontrun{
#' taf2html(catage.taf, "catage.html")
#' taf2html(catage.taf, "catage.html", align=c("L","R","R","R","R"),
#'          append=TRUE)
#' }
#'
#' @export

taf2html <- function(x, file="", align="", header=align,
                     digits=getOption("digits"),
                     center="style=\"text-align:center\"",
                     left="style=\"text-align:left\"",
                     right="style=\"text-align:right\"", append=FALSE)
{
  x <- as.data.frame(x)

  # Process td
  td <- align
  td <- rep(td, length.out=ncol(x))
  td[!toupper(substring(td,1,1)) %in% c("C","L","R")] <- "<td>"
  td[toupper(substring(td,1,1)) == "C"] <- paste0("<td ", center, ">")
  td[toupper(substring(td,1,1)) == "L"] <- paste0("<td ", left, ">")
  td[toupper(substring(td,1,1)) == "R"] <- paste0("<td ", right, ">")

  # Process th
  th <- header
  th <- rep(th, length.out=ncol(x))
  th[!toupper(substring(th,1,1)) %in% c("C","L","R")] <- "<th>"
  th[toupper(substring(th,1,1))=="C"] <- paste0("<th ", center, ">")
  th[toupper(substring(th,1,1))=="L"] <- paste0("<th ", left, ">")
  th[toupper(substring(th,1,1))=="R"] <- paste0("<th ", right, ">")

  # Format numbers
  x <- format(x, digits=digits)
  x <- as.data.frame(sapply(x, trimws))

  # Convert data frame lines to text
  thead <- paste0("  <tr>", paste0(th, names(x), collapse=""))
  tbody <- character(nrow(x))
  for(i in seq_len(nrow(x)))
    tbody[i] <- paste0("  <tr>", paste0(td, x[i,], collapse=""))

  # Finalize object
  out <- c("<table>", thead, tbody, "</table>")
  class(out) <- "Bibtex"

  # 3  Export
  # No write() when file="", to ensure quiet assignment x <- draft.data()
  if(file == "")
  {
    out
  }
  else
  {
    write(out, file=file, append=append)
    invisible(out)
  }
}
