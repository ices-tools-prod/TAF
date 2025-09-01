# TAF 4.3.0 (2025-09-02)

* Added function check.software() to check global package versions - an
  administrative tool for special cases. Code contributed by Iago Mosqueira.

* Added function ddim() to show the data dimensions of a table.

* Added function dir.tree() to show directory structure and files.

* Added function draft.readme() to draft an introductory README.md.

* Added function git.repo() to read a Git repository name.

* Added function install.deps() to install all dependencies of a TAF analysis.

* Added function pdeps() to analyze the dependencies of a CRAN package.

* Added function taf.example() to copy an example analysis from the TAF package.

* Added function taf.libraries() to load all packages from TAF library. Code
  contributed by Iago Mosqueira.

* Added function wide2long() to convert from wide to long table format.

* Added argument 'force' to dos2unix() and unix2dos().

* Added argument 'quiet' to make(). Renamed argument 'debug' to 'details'.

* Added argument 'gitignore' to taf.skeleton().

* Added example data frame catage.wide to demonstrate a wide table format.

* Added 'linreg' example, a minimal TAF workflow.

* Improved draft.software() so it supports packages from r-universe. Code
  contributed by Iago Mosqueira.

* Improved taf.boot() so it is not affected by getOption("pkgType"). Changed
  taf.boot() so it handles multiple filenames/URLs in 'source' field, separated
  by comma. Handled by internal function process.entry().

* Changed taf.skeleton() so it sets 'pkgs' to either "TAF" or "icesTAF",
  depending on whether the icesTAF package is attached. The header comments
  produced by taf.skeletion() have also been simplified.




# TAF 4.2.0 (2023-03-20)

* The term 'boot' is now preferred for what used to be called 'bootstrap',
  mainly to avoid confusion with statistical bootstrap. To taf.boot() is similar
  to booting a computer, readying the components required for subsequent
  computations. Help pages now refer to 'boot', but all TAF functions fully
  support existing analyses that have a legacy 'bootstrap' folder.

* The filename method.R is now an alternative to the default filename model.R
  script, for analyses where the term 'model' would be misleading or ambiguous.

* Added function clean.boot() to clean the boot directory.

* Added argument 'imports' to taf.session().

* Added argument 'model.script' to taf.skeleton().

* Improved draft.data() so it returns source = {folder} for folders.

* Improved taf.boot() so it returns a logical vector, as documented.

* Improved taf.library() to ensure it returns to the previous working directory.
  Code contributed by Alexandros Kokkalis.

* Fixed a taf.boot() bug introduced in 4.1.0, checking GitHub references.

* New admin tools, mainly for use inside TAF functions: boot.dir(),
  boot.dir.inside(), boot.exists(), model.dir(), and model.script().




# TAF 4.1.0 (2023-01-20)

* Added function taf2html() to convert a TAF table to HTML code.

* Added argument 'pkgs' to taf.skeleton().

* Improved deps() to include Rmd files.

* Improved read.taf() and write.taf() to warn when column names are missing or
  duplicated and also when a data frame has zero rows. Changed write.taf() so it
  no longer enforces Dos line endings.

* Improved taf.bootstrap() so it only connects to GitHub when necessary to look
  up SHA codes.

* Provided alternative spelling variations for several functions:
  - make.all() is equivalent to makeAll()
  - make.taf() is equivalent to makeTAF()
  - source.all() is equivalent to sourceAll()
  - source.dir() is equivalent to sourceDir()
  - source.taf() is equivalent to sourceTAF()
  - taf.boot() is equivalent to taf.bootstrap()




# TAF 4.0.0 (2021-04-06)

* Package renamed and focus changed to providing general support for the ICES
  Transparent Assessment Framework.

* Removed all non-base package dependencies.

* Changed sourceAll() and makeAll() so they start by sourcing utilities.R. Code
  contributed by Hjalte Parner.




# icesTAF 3.6.0 (2020-10-19)

* Added function draft.data.script() to create R script template for downloading
  data with metadata.

* Added function read.bib(), removing 'bibtex' package dependency.

* Added function taf.boot.path() to simplify access to boot folder.

* Added function taf.data.path() to provide path to bootstrap data.

* Added function taf.roxygenise() to build DATA.bib file from Roxygen
  documentation.

* Added function taf.sources() to extract data and software sources used in a
  project.

* Improved taf2long() so it works on tibbles.

* Moved all bib entry processing to process.bib().




# icesTAF 3.5-0 (2020-05-15)

* Added function clean.data() to selectively clean the bootstrap data folder.

* Added function detach.packages() to detach all packages.

* Added argument 'overwrite' to cp().

* Added arguments 'detach' and 'taf' to sourceTAF().

* Added argument 'taf' to taf.bootstrap().

* Added argument 'remove' to taf.libPaths().

* Added argument 'details' to taf.session().

* Changed taf.bootstrap() to skip download of files if they already exist, and
  skip bootstrap script if the destination folder already contains files.

* Changed taf.png() to use 'res' rather than 'pointsize', improving consistency
  between base, lattice, and ggplot2 plots. Code contributed by Iago Mosqueira.




# icesTAF 3.4-0 (2020-04-07)

* Added function is.r.package() to check if tar.gz file is an R package.

* Added functions long2xtab() and xtab2long() to convert between table formats.

* Added function taf.libPaths() to add TAF library to search path.

* Added function taf.session() to show session information.

* Added argument 'force' to clean(), clean.library(), and clean.software().

* Added argument 'ignore' to cp().

* Improved clean.software() to remove software folder, not just software files.

* Improved download.github() to store GitHub metadata in the DESCRIPTION file,
  if the GitHub resource is an R package. Warn if the tar.gz file looks like an
  R package nested inside a repository.

* Improved taf.bootstrap() to support GitHub references in DATA.bib. Runs
  taf.install() only when software from GitHub contains a DESCRIPTION file.
  Added source = {folder} as a special value, similar to source = {file}. Warn
  if source = {owner/repo@ref} entry is missing the '@ref' part.

* Renamed internal function process.bib() to process.bibfile() and
  process.inner() to process.entry().




# icesTAF 3.3-3 (2020-01-29)

* Moved documentation of metadata (DATA.bib and SOFTWARE.bib) entries from
  process.bib() help page to https://github.com/ices-taf/doc/wiki/Bib-entries.




# icesTAF 3.3-2 (2020-01-07)

* Improved process.bib() so it allows 'access' to be undefined.




# icesTAF 3.3-1 (2019-12-11)

* Improved handling of SOFTWARE.bib GitHub entries that have owner/repo/subdir.
  Code contributed by Ibrahim Umar.

* Improved process.bib() so it verifies that 'access' values match the allowed
  values.




# icesTAF 3.3-0 (2019-12-03)

* Added function get.remote.sha() to look up a SHA reference code on GitHub.
  Fixed a bug introduced in 3.2-0.

* Improved clean.library() and clean.software() to remove the TAF library and
  software when SOFTWARE.bib file does not exist. Improved clean.software() to
  remove software file when version does not match SOFTWARE.bib.

* Improved download.github() to handle packages that are nested inside a
  repository. Set default to quiet=FALSE.

* Changed write.taf() so it no longer converts line endings.

* Removed 'remotes' package dependency.




# icesTAF 3.2-0 (2019-11-01)

* Added functions clean.library() and clean.software() to selectively clean the
  TAF library and software folders.

* Added function download.github() to download a GitHub repository.

* Added function taf.install() to install a package in the local TAF library.

* Changed taf.bootstrap() so bootstrap/initial/config is now deprecated.
  Instead, model configuration files can be processed as a DATA.bib entry.
  Removed argument 'config'. SOFTWARE.bib is now processed before DATA.bib.

* Changed clean() so it uses clean.library() to clean the TAF library.

* Improved draft.data() so it detects bootstrap/*.R scripts as source files to
  consider. Added arguments 'access' and 'data.scripts'. Removed argument
  'data.dir'. Added support for file=TRUE as shorthand for
  file="bootstrap/DATA.bib".

* Improved draft.software() so it first looks for packages in the TAF library.
  Added support for package="owner/repo@ref" to install package on the fly.
  Added support for file=TRUE as shorthand for file="bootstrap/SOFTWARE.bib".

* Improved taf.library() so it works from a bootstrap script.

* Improved write.taf() so it gives an error if data frame contains comma.

* Added argument 'quiet' to cp().

* Added arguments 'force' and 'recon' to make().

* Added argument 'clean' to process.bib(). Renamed argument 'data.source' to
  'data.scripts'.

* Added argument 'force' to taf.bootstrap().

* Improved convert.spaces() so it allows 'sep' to be any number of characters,
  treats %20 as space, and allows spaces in parent directories.

* Improved download() so it shaves off ?tail from the end of 'destfile', and
  converts spaces and %20 to underscores.

* Improved zoom() so it handles legend text size.

* Removed 'jsonlite' package dependency.




# icesTAF 3.1-1 (2019-05-24)

* Added function convert.spaces() to convert spaces in filenames.

* Added function sam2taf() to convert SAM tables to TAF format.

* Added argument 'quiet' to process.bib() and support for source={script} and
  dir={TRUE}. Removed 'bundle' field.

* Added argument 'quiet' to taf.bootstrap(). Improved taf.bootstrap() so it
  doesn't clean the corresponding bootstrap subdirectories when arguments
  'config', 'data', or 'software' are FALSE. Dropped support for custom
  bootstrap.R script, superseded by source={script}.

* Improved draft.data() so it works in R versions older than 3.5. Code
  contributed by Alexandros Kokkalis.

* Changed sourceTAF() so working directory is not changed before script is run.




# icesTAF 3.0-0 (2019-04-25)

* Added function period() to paste period string for DATA.bib entries.

* Removed argument 'name' from taf.skeleton(). The default behavior is now to
  create initial directories and scripts in the current working directory.

* Changed taf.library() so it loads a package instead of changing the library
  path.

* Changed default size of taf.png(). Changed text size in zoom() accordingly and
  renamed arguments. The zoom() function is now generic.

* Changed write.taf() so it gives a warning if column names are duplicated.

* Improved process.bib() so it supports 'prefix' field when specifying multiple
  filenames in 'source' field.

* Improved process.bib() so it doesn't install a package that is already
  installed.




# icesTAF 2.3-0 (2019-04-08)

* Added function sourceDir() to read all *.R files from a directory.

* Added function zoom() to change text size in a lattice plot.

* Added arguments 'config', 'data', and 'software' to taf.bootstrap().

* Added argument 'append' to draft.data() and draft.software(). Code contributed
  by Alexandros Kokkalis.

* Added argument 'colname' to xtab2taf().

* Improved draft.data() so the default value of 'year' is the current year and
  user can pass period=FALSE.

* Improved file.encoding() so it handles spaces in filenames.

* Improved os.unix() so it recognizes both Linux and macOS operating systems.

* Improved process.bib() so it supports 'bundle' field and multiple filenames in
  'source' field, separated by newlines.

* Improved write.taf() so file="" prints to screen, regardless of dir.




# icesTAF 2.2-0 (2019-02-22)

* Added function file.encoding() to examine file encoding. Added functions
  latin1.to.utf8() and utf8.to.latin1() to convert file encoding.

* Added function line.endings() to examine line endings.

* Added arguments 'author', 'year', and 'title' to draft.software(), and
  improved it so it also handles software other than R packages.

* Added argument 'clean' to taf.bootstrap().

* Added argument 'create' to taf.library().

* Improved process.bib() so it does not require taf.bootstrap() to create 'data'
  and 'software' subdirectories.

* Improved taf.skeleton() so every script starts with library(icesTAF) and
  mkdir() to create a working directory.




# icesTAF 2.1-0 (2019-01-08)

* Added functions taf.bootstrap() and process.bib() to set up data files and
  software.

* Added functions draft.data() and draft.software() to create initial draft
  versions of metadata files.

* Added functions os(), os.linux() and os.macos() to detect more operating
  systems than before.

* Updated colors (taf.green, taf.orange, taf.blue, taf.dark, taf.light) to make
  them equally intense and easy to distinguish.

* This release introduces package dependencies to parse BibTeX files (bibtex)
  and install packages from GitHub (remotes), with further underlying package
  dependencies.




# icesTAF 2.0-0 (2018-12-07)

* Added function taf.library() to work with packages in a local TAF library.

* Added function rmdir() to remove an empty directory.

* Added functions os.unix() and os.windows() to determine OS family.

* Added function taf.unzip() to extract files from zip archives.

* Moved functions read.dls() and write.dls() to the 'icesAdvice' package.

* Changed clean(), makeAll(), makeTAF(), sourceAll(), and taf.skeleton() to
  align with new data-model workflow.

* Renamed function tafpng() to taf.png().

* Added argument 'destfile' to download().




# icesTAF 1.6-2 (2018-08-03)

* Added argument 'underscore' to write.taf().

* Added argument 'stringsAsFactors' to read.taf().

* Improved multitable support for read.taf() and write.taf().




# icesTAF 1.6-1 (2018-06-28)

* Changed sourceTAF(), sourceAll(), makeTAF(), and makeAll() so they never
  delete the 'begin' folder.

* Changed sourceAll(), makeTAF(), makeAll() so they don't set the working
  directory.

* Changed clean() so user can specify directories to remove.

* Changed write.taf() to search in the global workspace if 'x' is a string.

* Changed cp() to enforce safeguards when moving files.




# icesTAF 1.6-0 (2018-05-15)

* Removed function upload(). Initial data and model files are now in the 'begin'
  folder of each assessment.

* Added function plus() to rename plus group column.

* Added argument 'dir' to write.taf().

* Changed read.taf() and write.taf() so they can read and write many tables in
  one call.

* Changed write.taf() so the name of the data frame is the default filename.

* Changed cp() to preserve the timestamp when copying a file.




# icesTAF 1.5-3 (2018-04-27)

* Changed default file encoding in read.taf() to UTF-8.




# icesTAF 1.5-1 (2018-03-20)

* Replaced argument 'local' with 'rm' in sourceTAF().

* Added argument 'colname' to flr2taf().




# icesTAF 1.5-0 (2018-01-25)

* Added functions makeTAF() and makeAll() to run TAF scripts as needed.

* Added arguments 'include' and 'engine' to make().

* Added argument 'local' to sourceTAF(), replacing the 'rm' argument.

* Changed sourceAll() to only run TAF scripts: data.R, input.R, model.R,
  output.R, and report.R.




# icesTAF 1.4-1 (2017-12-05)

* Added argument 'grep' to div() and rnd().




# icesTAF 1.4-0 (2017-10-30)

* Added function upload() to upload file to TAF database. Added function
  download() to download file in binary mode.

* Added function msg() to show a message, as well as the current time.

* Added function tafpng() to open a graphics device. Added function lim() to
  compute axis limits.

* Added function div() to divide column values with a common number. Added
  function rnd() to round column values.

* Added function taf.skeleton() to create an empty template for a TAF analysis.

* Added function deps() to list dependencies.

* Renamed function sourceAtoZ() to sourceAll().

* Added argument 'move' to cp(). Added argument 'clean' to sourceTAF(). Added
  argument 'column' to tt().

* Added color objects: taf.green, taf.orange, taf.blue, taf.dark, and taf.light.

* Added example data frame summary.taf to demonstrate div() and rnd().




# icesTAF 1.3-2 (2017-06-03)

* Improved package description.




# icesTAF 1.3-0 (2017-05-27)

* Added function make() to run script if needed, and sourceAtoZ() to run all
  scripts in alphabetical order. Added clean() to remove TAF directories.




# icesTAF 1.2-0 (2017-05-19)

* Added function sourceTAF() to run scripts. Added cp() to copy files and
  mkdir() to create a directory. Added read.taf() and write.taf() to read and
  write TAF tables. Added long2taf(), taf2xtab(), tt(), and xtab2taf to convert
  between table formats.

* Renamed functions readDLS() and writeDLS() to read.dls() and write.dls().

* Removed function dir.remove() which is no longer needed in TAF scripts.

* Added example data frames catage.long, catage.taf, and catage.xtab to
  demonstrate different table formats.




# icesTAF 1.1-0 (2017-04-27)

* Added functions flr2taf() and taf2long() to convert between table formats.




# icesTAF 1.0-0 (2017-02-17)

* Initial release, with five functions: dir.remove(), dos2unix(), readDLS(),
  unix2dos(), and writeDLS().
