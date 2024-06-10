#' Check versions with those in SOFTWARE.bib
#'
#' Compare installed and required package versions
#'
#' @details
#' A SOFTWARE.bib file can be use to record what package versions a certain
#' analysis expects. Those available in the running session can be compared
#' with those listed in the file. A warning is printed if the former are
#' earlier that the later.
#'
#' @return TRUE or FALSE if available packages match those required or not.
#'
#' @name check.software
#' @rdname check.software
#'
#' @seealso [draft.software()]
#' @keywords classes
#'
#' @importFrom utils compareVersion
#' @importFrom utils packageVersion
#'
#' @export

check.software <- function() {

  # GET bib file
  bibfile <- (file.path(boot.dir(), "SOFTWARE.bib"))

  # CHECK file exists
  if(!file.exists(bibfile))
    stop(paste0("File ", boot.dir(), "/SOFTWARE.bib does not exist"))

  # READ bib file
  entries <- taf.sources("software")

  # EXTRACT versions
  versions <- sapply(entries, '[[', 'version')

  # COMPARE with available in session: 0 if equal, -1 is too old, 1 if newer
  comparison <- unlist(lapply(setNames(nm=names(versions)), function(x)
    compareVersion(as.character(packageVersion(x)), versions[x])))

  # FIND those too old
  toold <- comparison == -1

  # WARN if any SOFTWARE.bib:versions > available
  if(any(toold)) {

    msg <- lapply(names(toold)[toold], function(x)
      paste0(x, ": ", packageVersion(x), " installed but ", versions[x],
             " required\n"))

    warning(strwrap(msg, prefix="; ", initial=""))

    invisible(FALSE)

  } else {
    invisible(TRUE)
  }
}
