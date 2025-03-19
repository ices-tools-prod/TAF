#' Git Name
#'
#' Read the Git repository name from the \code{.git} folder.
#'
#' @param path top directory of a Git repository.
#' @param owner whether to include the repository owner name.
#' @param warn whether to raise a warning include the repository owner name.
#'
#' @return String of the format \code{"[owner]/repo"}.
#'
#' @seealso
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' git.name()
#' git.name(owner=FALSE)
#' }
#'
#' @export

git.name <- function(path=".", owner=TRUE, warn=TRUE)
{
  # Read config file
  filename <- file.path(path, ".git/config")
  if(!file.exists(filename))
  {
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
