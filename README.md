
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

Or the development version with:

``` r
remotes::install_github("llrs/bugRzilla")
```

## Example

This is a basic example which shows you the first “bug” on the issue
tracker:

``` r
library(bugRzilla)
## basic example code
g1 <- get_bug(1)
g1
#>   blocks see_also creator keywords          depends_on dupe_of platform
#> 1     NA       NA   admin       NA 15763, 15764, 15862      NA  PowerPC
#>               url target_milestone severity is_confirmed classification
#> 1 http://url.com/              ---   normal         TRUE   Unclassified
#>   cc_detail is_creator_accessible         op_sys alias is_cc_accessible status
#> 1   1, 5, 1                  TRUE Mac OS X v10.4    NA             TRUE CLOSED
#>   whiteboard resolution deadline product version            cc is_open
#> 1                 FIXED       NA       R R 2.y.z simon.urbanek   FALSE
#>      last_change_time creator_detail       creation_time qa_contact assigned_to
#> 1 2018-01-16 16:21:14        1, 1, 1 2010-02-15 18:29:54                  admin
#>   flags assigned_to_detail id component priority                   summary
#> 1    NA            1, 1, 1  1      Misc       P5 Test bug report - summary
#>   groups
#> 1     NA
```

## Other packages

Just after having figured out how to authenticate via the API I realized
that someone might have done this before. After a brief search I found
[bugtractr](https://github.com/mvkorpel/bugtractr/): It allows to access
the same data (only non authenticated requests), last commit 3 years
ago, no test coverage, but author is responsive.
