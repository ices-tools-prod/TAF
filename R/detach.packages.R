#' Detach Packages
#'
#' Detach all packages other than \verb{TAF}, \verb{icesTAF}, and base packages.
#'
#' @param quiet whether to suppress messages.
#'
#' @return Names of detached packages.
#'
#' @seealso
#' \code{\link{detach}} is the underlying base function to detach a package.
#'
#' \code{\link{library}} loads a package from the global library.
#'
#' \code{\link{taf.library}} loads a package from the local \verb{boot/library}.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' detach.packages()
#' }
#'
#' @export

detach.packages <- function(quiet=FALSE)
{
  # Prepare list of loaded packages
  pkgs <- sessionInfo()$otherPkgs
  pkgs[c("TAF", "icesTAF")] <- NULL
  if(length(pkgs) == 0)
    pkgs <- NULL

  # Detach
  if(!is.null(pkgs))
  {
    pkgs <- names(pkgs)
    sapply(paste0("package:", pkgs), detach, character.only=TRUE)
    invisible(pkgs)
    if(!quiet)
      message(paste(c("Detached packages:", pkgs), collapse="\n  "))
  }
  else if(!quiet)
  {
    message("No packages to be detached.")
  }

  invisible(pkgs)
}
