#' Construct Boot Path
#'
#' Construct a relative path to the \code{boot} folder, regardless of whether
#' the current working directory is the TAF root, the \code{boot} folder, or a
#' subfolder inside \code{boot}.
#'
#' @param \dots names of folders or files to append to the result.
#' @param fsep path separator to use instead of the default forward slash.
#'
#' @return Relative path, or a vector of paths.
#'
#' @note This function is especially useful in boot scripts.
#'
#' @seealso
#' \link{file.path} is the underlying function used to construct the path.
#'
#' \code{\link{taf.data.path}} constructs the path to \code{boot} data files.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' taf.boot.path()
#' taf.boot.path("software")
#' }
#'
#' @export

taf.boot.path <- function(..., fsep = .Platform$file.sep) {
  if (basename(dirname(dirname(getwd()))) %in% c("boot", "bootstrap")) {
    args <- list("..", "..")  # we're in TAF/boot/subdir/subdir
  } else if (basename(dirname(getwd())) %in% c("boot", "bootstrap")) {
    args <- list("..")        # we're in TAF/boot/subdir
  } else if (basename(getwd()) %in% c("boot", "bootstrap")) {
    args <- list(".")         # we're in TAF/boot
  } else {
    args <- list(boot.dir())  # we're in TAF
  }
  do.call(file.path, c(args, ..., fsep = fsep))
}
