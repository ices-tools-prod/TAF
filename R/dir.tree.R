#' Directory Tree
#'
#' Show directory structure and files in a tree format.
#'
#' @param path the directory to show.
#'
#' @seealso
#' \link{dir} is the underlying base function that returns directories and files
#' as strings.
#'
#' \code{\link{TAF-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' path <- system.file("examples", package="TAF")
#' dir.tree(path)
#' cbind(dir(recursive=TRUE, include.dirs=TRUE))
#' }
#'
#' @importFrom utils tail write.table
#'
#' @export

dir.tree <- function(path = ".") {
  od <- setwd(path)
  on.exit(setwd(od))

  # get skeleton path structure
  paths <- dir(recursive = TRUE, full.names = TRUE, include.dirs = TRUE)

  # prettify list.files output
  splitpaths <- strsplit(paths, "/")
  depth <- sapply(splitpaths, length)

  patharr <-
    t(sapply(splitpaths, function(x) {
      c(x, rep("", max(depth) - length(x)))
    }))

  # fix ordering
  ord <- do.call(order, lapply(1:ncol(patharr), function(i) patharr[, i]))
  depth <- depth[ord]
  splitpaths <- splitpaths[ord]
  patharr <- patharr[ord, ]

  # based on the vector of path depths, devise ascii tree structure
  # e = end connector, c = connector, l = line connector, s = space
  linkchar <- function(d) {
    out <- ifelse(depth == d, "c", "l")
    out[-(1:tail(which(depth == d), 1))] <- "s"
    out[tail(which(depth == d), 1)] <- "e"
    out[depth < d] <- ""
    # if there is a l followed by "" or s it should be "s"
    for (i in rev(which(out == "l"))) {
      if (out[i+1] %in% c("", "s")) {
        out[i] <- "s"
      }
    }
    # if there is a c followed by "" or s it should be e
    for (i in which(out == "c")) {
      if (out[i + 1] %in% c("", "s")) {
        out[i] <- "e"
      }
    }
    out
  }

  # chars for tree structure
  chars <- c(e = "+-- ", s = "    ", c = "+-- ", l = "|   ")
  link <- sapply(2:max(depth), linkchar)
  link[] <- chars[link]
  link[is.na(link)] <- ""
  link <- apply(link, 1, paste, collapse = "")

  tree <- c(".", paste0(link, sapply(splitpaths, tail, 1)))
  chars <- sapply(tree, nchar)
  # pad white space for printing
  tree <-
    sapply(1:length(tree), function(i) {
      paste(tree[i], paste(rep(" ", max(chars) - chars[i]), collapse = ""))
    })
  tree <- data.frame(tree)
  names(tree) <- ""

  write.table(tree, quote=FALSE, col.names=FALSE, row.names=FALSE)
  invisible(tree)
}
