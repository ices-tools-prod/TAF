[![Build Status](https://travis-ci.org/ices-tools-prod/TAF.svg?branch=master)](https://travis-ci.org/ices-tools-prod/TAF)
[![CRAN Status](https://r-pkg.org/badges/version/TAF)](https://cran.r-project.org/package=TAF)
[![CRAN Monthly](https://cranlogs.r-pkg.org/badges/TAF)](https://cran.r-project.org/package=TAF)
[![CRAN Total](https://cranlogs.r-pkg.org/badges/grand-total/TAF)](https://cran.r-project.org/package=TAF)

[<img align="right" alt="ICES Logo" width="17%" height="17%" src="https://ices.dk/_layouts/15/1033/images/icesimg/iceslogo.png">](https://ices.dk)

TAF
===

TAF provides functions to support the [ICES](https://ices.dk) [Transparent
Assessment Framework](https://taf.ices.dk) to organize data, methods, and
results used in ICES assessments.

This package is the core foundation for the
[icesTAF](https://cran.r-project.org/package=icesTAF) package. The TAF package
can also be used by itself, especially for applications outside of ICES. With a
focus on stability and reproducible analyses, it is designed to have no package
dependencies.

TAF is implemented as an [R](https://www.r-project.org) package and
available on [CRAN](https://cran.r-project.org/package=TAF).

Installation
------------

TAF can be installed from CRAN using the `install.packages` command:

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
* https://github.com/ices-taf/doc

Development
-----------

TAF is developed openly on
[GitHub](https://github.com/ices-tools-prod/TAF).

Feel free to open an
[issue](https://github.com/ices-tools-prod/TAF/issues) there if you
encounter problems or have suggestions for future versions.

The current development version can be installed using:

```R
library(remotes)
install_github("ices-tools-prod/TAF")
```
