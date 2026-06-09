#' Read List
#'
#' Read a list from a text file.
#'
#' @param file a filename.
#' @param prefix a string prefix before element names.
#'
#' @return A list.
#'
#' @note
#' The \code{\link{write.list}} function can be useful to produce a
#' human-readable text file containing a simple list, which can be imported back
#' into R using \code{read.list}.
#'
#' Other pathways, such as \code{\link{saveRDS}}, \code{\link{dput}}, or JSON,
#' are better suited for large or complex lists when human readability is not a
#' priority.
#'
#' @seealso
#' \code{\link{write.list}} writes a list to a text file.
#'
#' \code{\link{write}} is the underlying function used to write data values to a
#' file.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' x <- list(pi=pi, month=month.name, value=stack.loss,
#'           country=c("Bay of Biscay", "Kattegat", "North Sea"))
#'
#' write.list(x)
#' write.list(x, ncolumns=NULL)
#' write.list(x, ncolumns=3)
#' write.list(x, ncolumns=3, sep=",")
#' write.list(x, prefix="# ")
#'
#' \dontrun{
#' write.list(x, "list.dat")
#' }
#'
#' @export

read.list <- function(file, prefix="# ")
{
  # Read file
  txt <- readLines(file)

  # Parse file
  el <- grep(paste0("^", prefix), txt)
  labels <- sub(prefix, "", txt[el])
  beg <- el + 1
  end <- c(el - 2, length(txt))[-1]

  # Construct list
  out <- list()
  for(i in seq_along(labels))
    out[[labels[i]]] <- txt[beg[i]:end[i]]
  out <- sapply(out, type.convert, as.is=TRUE)

  out
}
