#' Write List
#'
#' Write a list to a text file.
#'
#' @param x a list containing atomic elements.
#' @param file a filename, or special value \code{""}.
#' @param ncolumns the number of columns to write the data in.
#' @param sep a string used to separate columns.
#' @param prefix a string prefix to use before element names.
#'
#' @details
#' The default value \code{file = ""} prints the list in the console, allowing
#' the user to preview alternative formats before writing the list to a file.
#'
#' The default value \code{ncolumns = 1} writes one data value per line. This is
#' the only format supported by \code{\link{read.list}} and therefore
#' recommended if importing the list back into R is relevant. Other formats
#' using \code{ncolumns} and \code{sep} can improve human readability if
#' importing back into R is not relevant.
#'
#' The special value \code{ncolumns = NULL} uses 1 column for strings and 5
#' columns for other data types, in the same way as \code{\link{write}} does.
#'
#' @return No return value, called for side effects.
#'
#' @seealso
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
#' @export

write.list <- function(x, file="", ncolumns=1, sep=" ", prefix="# ")
{
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
