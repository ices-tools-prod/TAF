#' @rdname TAF-internal
#'
#' @export

# Boot directory exists

boot.exists <- function()
{
  dir.exists("boot") || dir.exists("bootstrap")
}
