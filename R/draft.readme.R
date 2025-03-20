#' Draft Readme
#'
#' Draft an introductory \code{README.md} that describes how to run a TAF
#' analysis.
#'
#' @param path directory of a TAF analysis.
#' @param title title to display at the top of the `README.md` page.
#' @param force whether to overwrite an existing \code{README.md} file.
#'
#' @details
#' The default value of \code{title = NULL} uses the Git repository name as a
#' placeholder title.
#'
#' @return No return value, called for side effects.
#'
#' @seealso
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' draft.readme()
#' }
#'
#' @export

draft.readme <- function(path=".", title=NULL, force=FALSE)
{
  # Process repo name
  repo <- git.repo(path)
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
  readme <- c(title, "", howtorun, "", moreinfo)


}
