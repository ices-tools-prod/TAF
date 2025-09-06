#' Read TAF Table
#'
#' Read from a CSV file into a data frame.
#'
#' @param file a filename.
#' @param check.names whether to enforce regular column names, e.g. convert
#'        column name \code{"3"} to \code{"X3"}.
#' @param stringsAsFactors whether to import strings as factors.
#' @param fileEncoding character encoding of input file.
#' @param ... passed to \code{read.csv}.
#'
#' @details
#' Alternatively, \code{file} can be a directory or a vector of filenames, to
#' read many tables in one call.
#'
#' @return
#' A data frame, or a list of data frames if \code{file} is a directory or a
#' vector of filenames.
#'
#' @note
#' This function gives a warning when column names are missing or duplicated. It
#' also gives a warning if the data frame has zero rows.
#'
#' @seealso
#' \code{\link{read.csv}} is the underlying function used to read a table from a
#' file.
#'
#' \code{\link{write.taf}} writes a data frame to a CSV file.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' write.taf(catage.taf, "catage.csv")
#' catage <- read.taf("catage.csv")
#'
#' write.taf(catage)
#' file.remove("catage.csv")
#' }
#'
#' @importFrom tools file_path_sans_ext
#' @importFrom utils read.csv
#'
#' @export

read.taf <- function(file, check.names=FALSE, stringsAsFactors=FALSE,
                     fileEncoding="UTF-8", ...)
{
  # Ensure file is either single dirname or only filenames
  if(length(file) > 1 && any(dir.exists(file)))
    stop("'file' must be of length 1 when it is a directory name")
  if(length(file) == 1 && dir.exists(file))
  {
    file <- dir(file, pattern="\\.csv$", full.names=TRUE)
    # Ensure file is not a dirname without CSV files
    if(length(file) == 0)
      stop("directory contains no CSV files")
  }

  # Now ready to import one or more CSV files
  if(length(file) > 1)
  {
    out <- lapply(file, read.taf, check.names=check.names,
                  stringsAsFactors=stringsAsFactors,
                  fileEncoding=fileEncoding, ...)
    names(out) <- basename(file_path_sans_ext(file))
  }
  else
  {
    out <- read.csv(file, check.names=check.names,
                    stringsAsFactors=stringsAsFactors,
                    fileEncoding=fileEncoding, ...)
    if(any(names(out) == ""))
    {
      warning("column ", which(names(out)=="")[1], " in '", basename(file),
              "' has no name")
    }
    if(any(duplicated(names(out))))
      warning("duplicated column name: ", names(out)[duplicated(names(out))][1])
    if(nrow(out) == 0)
      warning("data frame has zero rows")
  }
  out
}
