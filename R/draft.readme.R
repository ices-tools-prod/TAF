#' Draft Readme
#'
#' Draft an introductory \code{README.md} that describes how to run a TAF
#' analysis.
#'
#' @param title title to display at the top of the `README.md` page.
#' @param file optional filename to save the draft readme to a file. The value
#'        \code{TRUE} can be used as shorthand for \code{"README.md"}.
#'
#' @details
#' The default value \code{title = NULL} uses the Git repository name as a
#' placeholder title.
#'
#' The default value \code{file = ""} prints the initial draft in the console,
#' instead of writing it to a file. The output can then be pasted into a file to
#' edit further, without accidentally overwriting an existing file.
#'
#' @return Character vector of class \verb{Bibtex}.
#'
#' @note
#' Although the output is Markdown text, the \verb{Bibtex} class is used for
#' convenient display in the console.
#'
#' @seealso
#' \code{\link{git.repo}} reads the Git repository name.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' # Print in console
#' draft.readme()
#'
#' # Export to file
#' draft.readme(file=TRUE)
#'
#' # Specify title
#' draft.readme("Yellowfin tuna in the western and central Pacific")
#' }
#'
#' @export

draft.readme <- function(title=NULL, file="")
{
  # Process repo name
  repo <- git.repo()
  repo.quoted <- paste0("`", repo, "`")
  if(repo == "")
  {
    repo <- "TAF analysis"
    repo.quoted <- "TAF analysis"
  }

  # Process title
  if(is.null(title))
    title <- repo
  if(!grepl("^#", title))
    title <- paste("#", title)

  # Construct and combine sections
  howtorun <- c("## How to run", "",
                paste("Install the TAF package from CRAN. Then open R in the",
                      repo.quoted, "directory and run:"), "", "```",
                "library(TAF)", "taf.boot()", "source.all()", "```")
  link <- paste0("[TAF vignette](https://cran.r-project.org/web/packages/TAF/",
                 "vignettes/TAF.html)")
  moreinfo <- c("## More information", "",
                paste0("For an overview of how TAF works, see the ", link, "."))
  out <- c(title, "", howtorun, "", moreinfo)
  class(out) <- "Bibtex"

  # Export
  if(identical(file, TRUE))
    file <- "README.md"
  if(identical(file, FALSE))
    file <- ""
  # No write() when file="", to ensure quiet assignment x <- draft.readme()
  if(file == "")
  {
    out
  }
  else
  {
    write(out, file=file)
    invisible(out)
  }
}
