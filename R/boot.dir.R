#' @rdname TAF-internal
#'
#' @export

## Boot directory name

boot.dir <- function()
{
  if(!dir.exists("boot") && dir.exists("bootstrap"))
    "bootstrap"
  else
    "boot"
}
