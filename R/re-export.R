#' @import styler

#' @export
styler::cache_activate

#' @export
styler::cache_clear

#' @export
styler::cache_deactivate

#' @export
styler::cache_info

#' @export
styler::create_style_guide

#' @export
styler::default_style_guide_attributes

#' @export
styler::specify_math_token_spacing

#' @export
styler::specify_reindention

#' @export
styler::specify_transformers_drop

#' Like [styler::style_dir()], but `style` defaulting to `semicolon_style`
#' @export
style_dir <- purrr::partial(styler::style_dir, style = semicolon_style)

#' Like [styler::style_file()], but `style` defaulting to `semicolon_style`
#' @export
style_file <- purrr::partial(styler::style_file, style = semicolon_style)

#' Like [styler::style_pkg()], but `style` defaulting to `semicolon_style`
#' @export
style_pkg <- purrr::partial(styler::style_pkg, style = semicolon_style)

#' Like [styler::style_text()], but `style` defaulting to `semicolon_style`
#' @export
style_text <- purrr::partial(styler::style_text, style = semicolon_style)

#' @export
styler::tidyverse_math_token_spacing

#' @export
styler::tidyverse_reindention

#' @export
styler::tidyverse_style
