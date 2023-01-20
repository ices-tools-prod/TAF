#' Construct Boot Path
#'
#' Construct a relative path to the \code{bootstrap} folder, regardless of
#' whether the current working is the TAF root, the \code{bootstrap} folder, or
#' a subfolder inside \code{bootstrap}.
#'
#' @param ... names of folders or files to append to the result.
#' @param fsep path separator to use instead of the default forward slash.
#'
#' @return Relative path, or a vector of paths.
#'
#' @note This function is especially useful in boot scripts.
#'
#' @seealso
#' \link{file.path} is the underlying function used to construct the path.
#'
#' \code{\link{taf.data.path}} constructs the path to \code{bootstrap} data
#' files.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' taf.boot.path()
#' taf.boot.path("software")
#'
#' @export

taf.boot.path <- function(..., fsep = .Platform$file.sep) {
  if (basename(dirname(dirname(getwd()))) == "bootstrap") {
    args <- list("..", "..")
  } else if (basename(dirname(getwd())) == "bootstrap") {
    args <- list("..")
  } else {
    args <- list("bootstrap")
  }
  do.call(file.path, c(args, ..., fsep = fsep))
}
