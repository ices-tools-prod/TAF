#' Write TAF Table
#'
#' Write a data frame to a CSV file.
#'
#' @param x a data frame.
#' @param file a filename.
#' @param dir an optional directory name.
#' @param quote whether to quote strings.
#' @param row.names whether to include row names.
#' @param fileEncoding character encoding for output file.
#' @param underscore whether automatically generated filenames (when
#'        \code{file = NULL}) should use underscore separators instead of dots.
#' @param ... passed to \code{write.csv}.
#'
#' @details
#' Alternatively, \code{x} can be a list of data frames or a string vector of
#' object names, to write many tables in one call. The resulting files are named
#' automatically, similar to \code{file = NULL}.
#'
#' The default value \code{file = NULL} uses the name of \code{x} as a filename,
#' so a data frame called \code{survey.uk} will be written to a file called
#' \file{survey_uk.csv} (when \code{underscore = TRUE}) or \file{survey.uk.csv}
#' (when \code{underscore = FALSE}).
#'
#' The special value \code{file = ""} prints the data frame in the console,
#' similar to \code{write.csv}.
#'
#' @return No return value, called for side effects.
#'
#' @note
#' This function gives a warning when column names are missing or duplicated,
#' unless the target directory name is \verb{report}. It also gives a warning if
#' the data frame has zero rows.
#'
#' @seealso
#' \code{\link{write.csv}} is the underlying function used to write a table to a
#' file.
#'
#' \code{\link{read.taf}} reads from a CSV file into a data frame.
#'
#' \code{\link{taf2html}} converts a data frame to HTML.
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
#' @importFrom utils write.csv
#'
#' @export

write.taf <- function(x, file=NULL, dir=NULL, quote=FALSE, row.names=FALSE,
                      fileEncoding="UTF-8", underscore=TRUE, ...)
{
  # 1  Handle many tables
  if(is.data.frame(x) && ncol(x)==0)
    stop("data frame has zero columns")
  if(is.character(x) && length(x)>1)
    return(invisible(sapply(x, write.taf, file=NULL, dir=dir, quote=quote,
                            row.names=row.names, fileEncoding=fileEncoding,
                            underscore=underscore, ...)))
  if(is.list(x) && is.data.frame(x[[1]]))
  {
    file <- paste0(if(underscore) chartr(".","_",names(x))
                   else names(x), ".csv")
    dir <- if(is.null(dir)) "." else dir
    return(invisible(mapply(write.taf, x, file=file, dir=dir, quote=quote,
                            row.names=row.names, fileEncoding=fileEncoding,
                            underscore=underscore, ...)))
  }

  # 2  Handle one table
  if(is.character(x) && length(x)==1)
  {
    if(is.null(file))
      file <- paste0(if(underscore) chartr(".","_",x) else x, ".csv")
    x <- get(x, envir=.GlobalEnv)
  }
  if(is.null(x))
    stop("x should be a data frame (or a list of data frames), not NULL")

  # 3  Prepare file path
  if(is.null(file))
  {
    file <- deparse(substitute(x))
    file <- if(underscore) chartr(".","_",file) else file
    file <- sub(".*[@$]", "", file)  # parent@obj$data -> data
    file <- paste0(file, ".csv")
  }
  if(!is.null(dir) && file!="")
    file <- file.path(sub("[/\\]+$","",dir), file)  # remove trailing slash

  # 4  Check column names and data entries
  if(any(names(x)=="") && dirname(file)!="report")
    warning("column ", which(names(x)=="")[1], " has no name")
  if(any(duplicated(names(x))) && dirname(file)!="report")
    warning("duplicated column name: ", names(x)[duplicated(names(x))][1])
  comma <- sapply(x, grepl, pattern=",")
  if(nrow(x) == 0)
    warning("data frame has zero rows")
  if(nrow(x)>0 && !quote && any(comma))
  {
    row <- if(is.matrix(comma)) which(apply(comma, 1, any))[1] else 1
    stop("unexpected comma in row ", row, ", consider quote=TRUE")
  }

  # 5  Export
  write.csv(x, file=file, quote=quote, row.names=row.names,
            fileEncoding=fileEncoding, ...)
}
