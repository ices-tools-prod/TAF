#' @rdname TAF-internal
#'
#' @export

# Boot directory name

boot.dir <- function()
{
  if(!dir.exists("boot") && dir.exists("bootstrap"))
    "bootstrap"
  else
    "boot"
}

#' @rdname TAF-internal
#'
#' @export

# Boot directory name, in a location different from the working directory
#
# Generalization of boot.dir(), but we want to keep boot.dir() extremely simple
# and readable, so users understand how TAF chooses between boot and bootstrap
#
# Example: boot.dir.inside("~/taf/2015/rjm-347d")

boot.dir.inside <- function(inside=".")
{
  boot <- if(inside == ".") "boot" else file.path(inside, "boot")
  bootstrap <- if(inside == ".") "bootstrap" else file.path(inside, "bootstrap")
  if(!dir.exists(boot) && dir.exists(bootstrap))
    bootstrap
  else
    boot
}
