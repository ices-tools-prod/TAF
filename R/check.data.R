check.data <- function()
{
  boot <- boot.dir()
  entries <- read.bib(file.path(boot, "DATA.bib"))

  checks <-
    sapply(entries, function(x) {
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
    })

  if (any(!checks, na.rm = TRUE)) {
    missing <- names(checks)[!checks]
    message(
      "- Project boot folder is out of sync:\n  The following data entries are missing:\n",
      paste("  -", missing, collapse = "\n"),
      "\n  Run `taf.boot()` to update the boot folder with the missing data entries."
    )
  }
  else {
    message("- All data entries in ", boot, "/DATA.bib are present")
  }
}
