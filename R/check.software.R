#' Check SOFTWARE.bib Against Global Packages
#'
#' Compare versions declared in \verb{SOFTWARE.bib} with packages installed in
#' the global R library.
#'
#' @param full whether to return full data frame as output.
#'
#' @return
#' Logical vector (or data frame if \verb{full = TRUE}) indicating which
#' installed packages are \dfn{ready}, i.e., at least as new as the version
#' required in \verb{SOFTWARE.bib}.
#'
#' A warning is generated if any installed packages are older than required.
#'
#' @note
#' Generally, TAF installs R packages that are declared in \verb{SOFTWARE.bib}
#' inside the TAF library (\verb{boot/library}). This guarantees that the right
#' versions of packages are installed for the analysis. The \code{taf.library}
#' function is then used to load packages from the TAF library.
#'
#' In special cases, however, it might be useful to compare the versions of
#' packages declared in \verb{SOFTWARE.bib} against packages that are installed
#' in the global R library, outside the TAF library.
#'
#' @seealso
#' \code{\link{taf.boot}} and \code{\link{taf.library}} are the general tools to
#' install and load packages of the correct version in the TAF library.
#'
#' \code{\link{update.packages}} can be used to update packages in the general R
#' library to the newest version available on CRAN.
#'
#' @examples
#' \dontrun{
#' check.software()
#' check.software(full=TRUE)
#' }
#'
#' @importFrom utils compareVersion
#' @importFrom utils packageVersion
#'
#' @export

check.software <- function(full=FALSE)
{
  # GET bib file
  bibfile <- file.path(boot.dir(), "SOFTWARE.bib")

  # CHECK file exists
  if(!file.exists(bibfile))
    stop(paste0("file ", boot.dir(), "/SOFTWARE.bib does not exist"))

  # READ bib file
  entries <- taf.sources("software")

  # EXTRACT required version
  req <- sapply(entries, "[[", "version")
  req <- gsub("[,; ].*", "", req)  # remove text after comma/semicolon/space
  out <- data.frame(Package=names(req), Required=req, row.names=NULL)

  # COMPARE with installed version
  out$Installed <- NA
  out$Ready <- NA
  for(i in seq_len(nrow(out)))
  {
    inst <- try(as.character(packageVersion(out$Package[i])), silent=TRUE)
    out$Installed[i] <- if(inherits(inst, "try-error")) NA else inst
    cmp <- compareVersion(out$Required[i], out$Installed[i])
    out$Ready[i] <- if(is.na(out$Installed[i])) NA else cmp < 1
  }

  # WARN if any packages are obsolete (Installed < Required)
  obs <- which(!out$Ready)
  if(length(obs) > 0)
  {
    txt <- paste(out$Package[obs], out$Installed[obs], "installed but",
                 out$Required[obs], "required", collapse="; ")
    warning(txt)
  }

  # RETURN data frame or vector
  if(full)
    out
  else
    invisible(setNames(out$Ready, out$Package))
}
