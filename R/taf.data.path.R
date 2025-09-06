#' Construct Boot Data Path
#'
#' Construct a relative path to data files in the \code{boot} data folder,
#' regardless of whether the current working directory is the TAF root, the
#' \code{boot} folder, or a subfolder inside \code{boot}.
#'
#' @param ... filenames inside \code{boot/data}.
#' @param fsep path separator to use instead of the default forward slash.
#'
#' @return Relative path, or a vector of paths.
#'
#' @note This function is especially useful in boot scripts.
#'
#' @seealso
#' \link{file.path} is the underlying function used to construct the path.
#'
#' \code{\link{taf.boot.path}} constructs the path to the \code{boot} folder.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' taf.data.path()
#' taf.data.path("example.dat")
#'
#' @export

taf.data.path <- function(..., fsep = .Platform$file.sep) {
  taf.boot.path("data", ..., fsep = fsep)
}
