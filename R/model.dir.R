#' @rdname TAF-internal
#'
#' @export

# Model directory name

model.dir <- function()
{
  if(!dir.exists("model") && dir.exists("method"))
    "method"
  else
    "model"
}
