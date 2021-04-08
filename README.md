
<!-- README.md is generated from README.Rmd. Please edit that file -->

# styler.mlr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/lorenzwalthert/styler.mlr/workflows/R-CMD-check/badge.svg)](https://github.com/lorenzwalthert/styler.mlr/actions)
<!-- badges: end -->

The goal of {styler.mlr} is format code according to the [mlr
style](https://github.com/mlr-org/mlr3/wiki/Style-Guide). It is an
example for a custom [{styler}](https://styler.r-lib.org) style guide.

## Installation

You can install the released version of {styler.mlr} from
[GitHub](https://github.com) with:

``` r
remotes::install_github("lorenzwalthert/styler.mlr")
```

## Example

This is a basic example of how to style code with it.

``` r
library(styler.mlr)
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
#>     cat("Please review the changes carefully!", fill = TRUE)
#>   }
#> }
#> a
#> b
#> c /
#>   3
#> d + 3
```

To use in the addin, you can put something like this in your
`.Rprofile`:

``` r
if (grepl("mlr", getwd()) || grepl("paradox", getwd())) {
  options(styler.addins_style_transformer = "styler.mlr::mlr_style()")
}
```
