#' Run R Script if Needed
#'
#' Run an R script if underlying files have changed, otherwise do nothing.
#'
#' @param recipe script filename.
#' @param prereq one or more underlying files, required by the script. For
#'        example, data files, scripts, or \code{NULL}.
#' @param target one or more output files, produced by the script. Directory
#'        names can also be used.
#' @param include whether to automatically include the script itself as a
#'        prerequisite file. This means that if the script file has been
#'        modified, it should be run.
#' @param engine function to source the script.
#' @param details whether to show a diagnostic table of files and time last
#'        modified.
#' @param force whether to run the R script unconditionally.
#' @param recon whether to return \code{TRUE} or \code{FALSE}, without actually
#'        running the R script.
#' @param quiet whether to suppress messages.
#' @param \dots passed to \code{engine}.
#'
#' @return \code{TRUE} or \code{FALSE}, indicating whether the script was run.
#'
#' @note
#' This function provides functionality similar to makefile rules, to determine
#' whether a script should be (re)run or not.
#'
#' If any \code{target} is either missing or is older than any \code{prereq},
#' then the script is run.
#'
#' @references
#' Stallman, R. M. \emph{et al.} An introduction to makefiles. Chapter 2 in the
#' \emph{\href{https://www.gnu.org/software/make/manual/}{GNU Make manual}}.
#'
#' @seealso
#' \code{\link{source}} runs any R script, \code{\link{source.taf}} is more
#' convenient for running a TAF script, and \code{\link{source.all}} runs all
#' TAF scripts.
#'
#' \code{\link{make}}, \code{\link{make.taf}}, and \code{\link{make.all}} are
#' similar to the \code{source} functions, except they avoid repeating tasks
#' that have already been run.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' # Here, model.R uses input.dat, creating results.dat
#' make("model.R", "data/input.dat", "model/results.dat")
#' make("model.R", "data/input.dat", "model/results.dat", quiet=FALSE)
#' make("model.R", "data/input.dat", "model/results.dat", details=TRUE)
#' }
#'
#' @export

make <- function(recipe, prereq, target, include=TRUE, engine=source,
                 details=FALSE, force=FALSE, recon=FALSE, quiet=TRUE, ...)
{
  if(include)
    prereq <- union(prereq, recipe)
  if(details)
    print(data.frame(Object=c(rep("target",length(target)),
                              rep("prereq",length(prereq))),
                     File=c(target,prereq),
                     Modified=file.mtime(c(target,prereq))))
  if(!all(file.exists(prereq)))
    stop("missing prerequisite file '", prereq[!file.exists(prereq)][1], "'")
  if(force ||
     !all(file.exists(target)) ||
     min(file.mtime(target)) < max(file.mtime(prereq)))
  {
    if(!quiet)
      message("Running ", recipe)
    if(!recon)
      engine(recipe, ...)
    out <- TRUE
  }
  else
  {
    if(!quiet)
      message("Nothing to be done")
    out <- FALSE
  }
  invisible(out)
}
