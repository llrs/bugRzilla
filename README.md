
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bugRzilla

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-CMD-check](https://github.com/llrs/bugRzilla/workflows/R-CMD-check/badge.svg)](https://github.com/llrs/bugRzilla/actions)
[![Codecov test
coverage](https://codecov.io/gh/llrs/bugRzilla/branch/master/graph/badge.svg)](https://codecov.io/gh/llrs/bugRzilla?branch=master)
<!-- badges: end -->

The goal of bugRzilla is to provide a package to download and analyze
the [R bug tracker](https://bugs.r-project.org/bugzilla/).

## Installation

You can install the released version of bugRzilla from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("bugRzilla")
```

## Example

This is a basic example which shows you the first “bug” on the issue
tracker:

``` r
library(bugRzilla)
## basic example code
g1 <- get_issue(1)
g1[, 1:5]
#>   attachid commentid comment_count           who                  bug_when
#> 1        1         3             2         admin 2010-02-16 17:42:59 +0000
#> 2     <NA>         1             0         admin 2010-02-15 18:29:54 +0000
#> 3     <NA>         2             1         admin 2010-02-15 18:33:25 +0000
#> 4     <NA>     83214             3 simon.urbanek 2010-03-09 18:14:23 +0000
#> 5     <NA>     83218             4         admin 2010-03-10 16:54:39 +0000
```

## Other packages

Just after having figured out how to authenticate via the API I realized
that someone might have done this before. After a brief search I found
[bugtractr](https://github.com/mvkorpel/bugtractr/): It allows to access
the same data (only non authenticated requests), last commit 3 years
ago, no test coverage,
