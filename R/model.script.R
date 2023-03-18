#' @rdname TAF-internal
#'
#' @export

## Model script name

model.script <- function()
{
  if(!file.exists("model.R") && file.exists("method.R"))
    "method.R"
  else
    "model.R"
}
