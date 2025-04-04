#' Git Repo
#'
#' Read the Git repository name from the \code{.git} folder.
#'
#' @param path top directory of a Git repository.
#' @param owner whether to include the repository owner name.
#' @param warn whether to generate a warning if no \verb{.git/config} file is
#'        found.
#'
#' @return String of the format \code{"[owner]/repo"}.
#'
#' @seealso
#' \code{\link{draft.readme}} calls \code{git.repo} to include the repository
#' name in the \verb{README.md}.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' git.repo()
#' git.repo(owner=TRUE)
#' }
#'
#' @export

git.repo <- function(path=".", owner=FALSE, warn=FALSE)
{
  # Read config file
  filename <- file.path(path, ".git/config")
  if(!file.exists(filename))
  {
    if(warn)
      warning("file '", filename, "' not found")
    return("")
  }
  config <- readLines(filename)

  # Locate repo name
  config <- sub("[\t ]", "", config)  # remove initial space
  name <- grep("^url[\t ]", config, value=TRUE)

  # Parse name
  name <- sub("url[\t ]=[\t ]", "", name)   # remove initial url =
  name <- sub("git@github.com:", "", name)  # remove initial git@github.com:
  name <- sub("https://github.com/", "", name)  # rm initial https://github.com/
  name <- sub("\\.git$", "", name)
  if(!owner)
    name <- basename(name)

  name
}
