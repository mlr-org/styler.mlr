force_assignment_eq <- function(pd) {
  to_replace <- pd$token == "LEFT_ASSIGN" & pd$text == "<-"
  if (any(to_replace) && styler:::next_terminal(pd)$token == "'('") {
    pd$token[to_replace] <- "EQ_ASSIGN"
    pd$text[to_replace] <- "="
  }
  pd
}

set_line_break_after_fun_dec_header <- function(pd, min_lines_for_break) {
  if (any(pd$token == "FUNCTION") &&
    pd$child[[nrow(pd)]]$token[1] == "'{'"
  ) {
    pos <- styler:::next_non_comment(pd$child[[nrow(pd)]], 1)
    pd$child[[nrow(pd)]]$lag_newlines[pos] <- ifelse(
      n_lines(pd) > min_lines_for_break,
      2L,
      1L
    )
  }
  pd
}

#' Count the number of line breaks in a parse table and all its children
#'
#' This can be useful if styling depends on the number of lines within an
#' expression.
#' @param pd A parse table
#' @keywords internal
n_lines <- function(pd) {
  sum(purrr::map_int(pd$child, newlines_count_top_nest)) +
    newlines_count_top_nest(pd)
}

newlines_count_top_nest <- function(pd) {
  sum(pd$lag_newlines)
}
