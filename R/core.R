#' @importFrom magrittr %>%
add_semi_colon <- function(pd_nested) {
  needs_semicolon <- which(
    pd_nested$newlines > 0 &
      pd_nested$token == "expr" &
      rep(!styler:::is_cond_expr(pd_nested), nrow(pd_nested)) &
      rep(!styler:::is_function_call(pd_nested), nrow(pd_nested)) &
      rep(!styler:::is_while_expr(pd_nested), nrow(pd_nested)) &
      rep(!pd_nested$token[styler:::next_non_comment(pd_nested, 0L)] == "'('", nrow(pd_nested))
  )
  if (any(pd_nested$pos_id == 1)) {
    needs_semicolon <- c(needs_semicolon, nrow(pd_nested))
  }
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
      styler:::arrange(pos_id)
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
