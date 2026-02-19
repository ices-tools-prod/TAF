check.data <- function()
{
  bib.entries <- read.bib("boot/DATA.bib")

  checks <-
    sapply(bib.entries, function(entry) {
      if (entry$source == "file") {
        file.exists(file.path("boot", "data", entry$key))
      } else if (entry$source %in% c("folder", "script")) {
        if (dir.exists(file.path("boot", "data", entry$key))) {
          # check if folder/script contains any files
          length(list.files(file.path("boot", "data", entry$key), recursive = TRUE)) > 0
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
    message("- All data entries in boot/DATA.bib are present")
  }
}
