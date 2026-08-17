#' Write List
#'
#' Write a list to a text file.
#'
#' @param x a list containing atomic elements.
#' @param file a filename, or special value \code{""}.
#' @param ncolumns the number of columns to write the data in.
#' @param sep a string used to separate columns.
#' @param prefix a string prefix to use before element names.
#' @param as.is whether to simply capture the output of printing \code{x} to the
#'        console in standard R format and write that to the \code{file}.
#'
#' @details
#' The default value \code{file = ""} prints the list in the console, allowing
#' the user to preview alternative formats before writing the list to a file.
#'
#' The default value \code{ncolumns = 1} writes one data value per line. This is
#' the only format supported by \code{\link{read.list}} and therefore
#' recommended if importing the list back into R is relevant. Other formats
#' using \code{ncolumns} and \code{as.is} can improve human readability if
#' importing back into R is not relevant.
#'
#' The special value \code{ncolumns = NULL} uses 1 column for strings and 5
#' columns for other data types, in the same way as \code{\link{write}} does.
#'
#' The \code{as.is = TRUE} format is affected by R session options such as
#' \code{width} and \code{digits}, but is not affected by the function arguments
#' \code{ncolumns}, \code{sep}, and \code{prefix}.
#'
#' @return No return value, called for side effects.
#'
#' @note
#' The \code{write.list} function can be useful to produce a human-readable text
#' file containing a simple list, which can be imported back into R using
#' \code{\link{read.list}}.
#'
#' Other pathways, such as \code{\link{saveRDS}}, \code{\link{dput}}, or JSON,
#' are better suited for large or complex lists when human readability is not a
#' priority.
#'
#' @seealso
#' \code{\link{read.list}} reads a list from a text file.
#'
#' \code{\link{write}} is the underlying function used to write data values to a
#' file.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' x <- list(pi=pi, month=month.name, value=stack.loss,
#'           area=c("Bay of Biscay", "Kattegat", "North Sea"))
#'
#' write.list(x)
#' write.list(x, ncolumns=NULL)
#' write.list(x, ncolumns=3)
#' write.list(x, ncolumns=3, sep=",")
#' write.list(x, prefix="$")
#'
#' \dontrun{
#' write.list(x, "list.dat")
#' }
#'
#' @importFrom utils capture.output
#'
#' @export

write.list <- function(x, file="", ncolumns=1, sep=" ", prefix="# ", as.is=FALSE)
{
  # Handle the simple case of as.is = TRUE
  if(as.is)
  {
    write(capture.output(x), file=file)
    return(invisible(NULL))  # early
  }

  # Confirm that x is a list of atomic elements
  if(!is.list(x))
    stop("'x' should be a list")
  if(!all(sapply(x, is.atomic)))
    stop("list must only contain atomic elements")

  # Recycle ncolumns
  if(is.null(ncolumns))
    ncolumns <- c(5, 1)[sapply(x, is.character) + 1]
  else
    ncolumns <- rep(ncolumns, length.out=length(x))

  # Make sure no data values start with prefix
  check <- sapply(x, grepv, pattern=paste0("^", prefix))
  check <- check[sapply(check, length) > 0]
  if(length(check) > 0)
    stop(paste0(names(check)[1], " '", check[[1]][1], "' starts with prefix"))

  # Prepare labels
  labels <- paste0(prefix, names(x))

  # Write first element
  if(length(x) >= 1)
  {
    write(labels[1], file)
    write(x[[1]], file, ncolumns=ncolumns[1], append=TRUE, sep=sep)
  }

  # Write subsequent elements
  if(length(x) >= 2)
  {
    for(i in 2:length(x))
    {
      write("", file, append=TRUE)
      write(labels[i], file, append=TRUE)
      write(x[[i]], file, ncolumns=ncolumns[i], append=TRUE, sep=sep)
    }
  }
}
