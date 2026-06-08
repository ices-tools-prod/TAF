#' Write List
#'
#' Write a list to a text file.
#'
#' @param x a list containing atomic elements.
#' @param file a filename, or special value \code{""}.
#' @param ncolumns the number of columns to write the data in.
#' @param append whether to append to an existing file.
#' @param sep a string used to separate columns.
#' @param section a string to use before section labels.
#'
#' @details
#' The default value \code{file = ""} prints the list in the console, allowing
#' the user to preview alternative formats before writing the list to a file.
#'
#' The default value \code{ncolumns = NULL} uses 1 column for strings and 5
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
#' x <- list(a=pi, b=month.name, c=stack.loss)
#'
#' write.list(x)
#' write.list(x, ncolumns=c(1,2,3))
#' write.list(x, sep=",")
#' write.list(x, section="# ")
#'
#' \dontrun{
#' write.list(x, "list.dat")
#' }
#'
#' @export

write.list <- function(x, file="", ncolumns=NULL, append=FALSE, sep=" ",
                       section="")
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

  # Prepare labels
  labels <- paste0(section, names(x))

  # Write first element
  if(length(x) >= 1)
  {
    write(labels[1], file, append=append)
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
