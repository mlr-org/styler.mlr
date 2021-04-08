
<!-- README.md is generated from README.Rmd. Please edit that file -->

# semicoloner

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of semicoloner is format code according to one rule: Put a
semi-colon after every expression. It is an example for a custom
[{styler}](https://styler.r-lib.org) style guide.

## Installation

You can install the released version of semicoloner from
[CRAN](https://CRAN.R-project.org) with:

``` r
remotes::install_github("lorenzwalthert/semicoloner")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(semicoloner)
cache_deactivate()
#> Deactivated cache.
text <- 'communicate_warning <- function(changed, transformers) {
  if (any(changed, na.rm = TRUE) &&
    !can_verify_roundtrip(transformers) &&
    !getOption("styler.quiet", FALSE)
  ) {
    cat("Please review the changes carefully!", fill = TRUE)
  }
}
a
b
c /
  3
d + 3
'

style_text(text)
#> communicate_warning <- function(changed, transformers) {
#>   if (any(changed, na.rm = TRUE) &&
#>     !can_verify_roundtrip(transformers) &&
#>     !getOption("styler.quiet", FALSE)
#>   ) {
#>     cat("Please review the changes carefully!", fill = TRUE);
#>   };
#> };
#> a;
#> b;
#> c /
#>   3;
#> d + 3
```
