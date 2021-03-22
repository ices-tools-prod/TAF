#' Construct Path to a TAF boot folder
#'
#' Construct the path to a file in the TAF boot data folder
#' from components in a platform-independent way.  This function
#' checks to see if R is running in the boot folder - i.e.
#' `taf.boot()` is running, and adjusts the path accordingly.
#'
#' @param ... character vectors. Long vectors are not supported.
#' @param fsep the path separator to use (assumed to be ASCII).
#'
#' @seealso \link{file.path}
#' @details
#' This function, simplifies the construction of file paths to
#' the boot folder.
#'
#' @return character
#' @export
taf.boot.path <- function(..., fsep = .Platform$file.sep) {
  if (basename(dirname(dirname(getwd()))) == taf.constants$boot) {
    args <- list("..", "..")
  } else if (basename(dirname(getwd())) == taf.constants$boot) {
    args <- list("..")
  } else {
    args <- list(taf.constants$boot)
  }
  do.call(file.path, c(args, ..., fsep = fsep))
}
