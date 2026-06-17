#' @rdname TAF-internal
#'
#' @export

# Returns either "TAF" (if icesTAF is not attached) or "icesTAF" (if icesTAF is
# attached)

taf.pkg <- function()
{
  if("package:icesTAF" %in% search())
    "icesTAF"
  else
    "TAF"
}
