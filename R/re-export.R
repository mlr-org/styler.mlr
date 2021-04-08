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

#' @export
styler::style_dir

#' @export
styler::style_file

#' @export
styler::style_pkg

#' Like [styler::style_text()], but `style` defaulting to `semicolon_style`
#' @export
style_text <- purrr::partial(styler::style_text, style = semicolon_style)

#' @export
styler::tidyverse_math_token_spacing

#' @export
styler::tidyverse_reindention

#' @export
styler::tidyverse_style
