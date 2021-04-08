#' @importFrom magrittr %>%
add_semi_colon <- function(pd_nested) {
  needs_semicolon <- find_semicolon_idx(pd_nested)
  if (!any(needs_semicolon)) {
    return(pd_nested)
  }
  positions <- purrr::map_dbl(needs_semicolon, styler:::create_pos_ids,
    pd = pd_nested,
    after = TRUE
  )

  # remove spaces after last token and add them after semi colon
  relevant_spaces <- pd_nested$spaces[needs_semicolon]
  pd_nested$spaces[needs_semicolon] <- 0L
  for (i in seq_along(positions)) {
    pd_nested <- styler:::bind_rows(
      pd_nested,
      styler:::create_tokens(
        tokens = "';'", text = ";",
        spaces = relevant_spaces[i],
        pos_ids = positions[i],
      )
    ) %>%
      styler:::arrange_pos_id()
  }
  return(pd_nested)
}



#' Style guide to put a semi colon at the end of (most) lines
#'
#' Otherwise, does not do anything.
#' @export
semicolon_style <- function() {
  styler::create_style_guide(
    token = tibble::lst(add_semi_colon),
    use_raw_indention = TRUE,
    reindention = styler::tidyverse_reindention(),
    style_guide_name = "semicoloner::semicolon_style@https://github.com/lorenzwalthert",
    # please choose a name that matches the definition in `?create_style_guide()`
    style_guide_version = "0.0.0.9000"
  )
}

find_semicolon_idx <- function(pd_nested) {
  is_candidate <- pd_nested$newlines > 0 & pd_nested$token == "expr"
  if (!any(is_candidate)) {
    integer()
  } else {
    passes_advanced_test <- if (
      styler:::is_function_call(pd_nested) ||
        styler:::is_function_dec(pd_nested) ||
        styler:::is_cond_expr(pd_nested) ||
        styler:::is_while_expr(pd_nested) ||
        pd_nested$token[styler:::next_non_comment(pd_nested, 0L)] == "'('"
    ) {
      rep(FALSE, nrow(pd_nested))
    } else {
      rep(TRUE, nrow(pd_nested))
    }
    needs_semicolon <- which(is_candidate & passes_advanced_test)
    if (any(pd_nested$pos_id == 1)) {
      needs_semicolon <- c(needs_semicolon, nrow(pd_nested))
    }
    needs_semicolon
  }
}
