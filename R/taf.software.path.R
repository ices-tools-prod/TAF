#' Construct path to the TAF boot software folder
#'
#' Construct the path to the TAF boot library folder
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
#' inintial data files gathered during the TAF booting step.
#' In addition, this function is useful when developing scripts used
#' in the boot procedure, as these scripts are run with the
#' working directory set to the boot folder, and hence make it
#' to develop and debug.
#'
#' @return character
#' @export
taf.software.path <- function(..., fsep = .Platform$file.sep) {
  taf.boot.path(taf.constants$boot.software, ...)
}
