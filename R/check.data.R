check.data <- function(quiet = FALSE)
{
  boot <- boot.dir()
  entries <- read.bib(file.path(boot, "DATA.bib"))

  check.entry <- function(x)
  {
    if (x$source == "file") {
      file.exists(file.path(boot, "data", x$key))
    } else if (x$source %in% c("folder", "script")) {
      if (dir.exists(file.path(boot, "data", x$key))) {
        # check if folder/script contains any files
        length(dir(file.path(boot, "data", x$key), recursive = TRUE)) > 0
      } else {
        FALSE
      }
    } else {
      NA
    }
  }
  checks <- sapply(entries, check.entry)

  if (any(!checks, na.rm = TRUE)) {
    missing <- names(checks)[!checks]
    warning("boot folder is out of sync")
    if (!quiet) {
      message("The following data entries are missing:")
      message(paste("  -", missing, collapse = "\n"))
      message("Run taf.boot() to update the boot folder")
    }
  }
  else {
    if (!quiet) {
      message("All entries in ", boot, "/DATA.bib are present")
    }
  }

  invisible(checks)
}
