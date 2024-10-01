[![CRAN Status](https://r-pkg.org/badges/version/TAF)](https://cran.r-project.org/package=TAF)
[![CRAN Monthly](https://cranlogs.r-pkg.org/badges/TAF)](https://cran.r-project.org/package=TAF)
[![CRAN Total](https://cranlogs.r-pkg.org/badges/grand-total/TAF)](https://cran.r-project.org/package=TAF)

[<img align="right" alt="ICES Logo" height="40" src="https://www.ices.dk/_layouts/15/1033/images/icesimg/iceslogo.png">](https://www.ices.dk)

TAF
===

General framework to organize data, methods, and results used in reproducible
scientific analyses. A TAF analysis consists of four scripts (data.R, model.R,
output.R, report.R) that are run sequentially. Each script starts by reading
files from a previous step and ends with writing out files for the next step.

Convenience functions are provided to version control the required data and
software, run analyses, clean residues from previous runs, manage files,
manipulate tables, and produce figures. With a focus on stability and
reproducible analyses, the TAF package comes with no dependencies.

TAF forms a base layer for the
[icesTAF](https://cran.r-project.org/package=icesTAF) package and other
scientific applications.

Installation
------------

The package can be installed from [CRAN](https://cran.r-project.org/package=TAF)
using the `install.packages` command:

```R
install.packages("TAF")
```

Usage
-----

For a summary of the package:

```R
library(TAF)
?TAF
```

References
----------

ICES Transparent Assessment Framework:
* https://taf.ices.dk

Development
-----------

The package is developed openly on
[GitHub](https://github.com/ices-tools-prod/TAF).

Feel free to open an
[issue](https://github.com/ices-tools-prod/TAF/issues) there if you
encounter problems or have suggestions for future versions.

The current development version can be installed using:

```R
library(remotes)
install_github("ices-tools-prod/TAF")
```
