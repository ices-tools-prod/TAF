#' Check DATA.bib Entries
#'
#' Check if all \verb{DATA.bib} entries have been processed.
#'
#' @param quiet whether to suppress messages.
#'
#' @return
#' Logical vector indicating which entries have been processed.
#'
#' A warning is generated if any entries have not been processed.
#'
#' @seealso
#' \code{\link{check.software}} checks \verb{SOFTWARE.bib} versions.
#'
#' \code{\link{taf.boot}} runs the boot procedure and sets up data files
#' according to \verb{DATA.bib} specifications.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' check.data()
#' check.data(quiet=TRUE)
#' }
#'
#' @export

check.data <- function(quiet = FALSE)
{
  boot <- boot.dir()
  entries <- read.bib(file.path(boot, "DATA.bib"))

  check.entry <- function(x)
  {
    if (x$source == "file") {
      file.exists(file.path(boot, "data", x$key))
    } else if (x$source %in% c("folder", "script")) {
      if (dir.exists(file.path(boot, "data", x$key))) {
        # check if folder/script contains any files
        length(dir(file.path(boot, "data", x$key), recursive = TRUE)) > 0
      } else {
        FALSE
      }
    } else {
      NA
    }
  }
  checks <- sapply(entries, check.entry)

  if (any(!checks, na.rm = TRUE)) {
    missing <- names(checks)[!checks]
    warning("boot folder is out of sync")
    if (!quiet) {
      message("The following data entries are missing:")
      message(paste("  -", missing, collapse = "\n"))
      message("Run taf.boot() to update the boot folder")
    }
  }
  else {
    if (!quiet) {
      message("All entries in ", boot, "/DATA.bib are present")
    }
  }

  invisible(checks)
}
