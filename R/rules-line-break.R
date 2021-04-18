#' Force the assignment operator `=` when possible
#'
#' Because you can't determine from a nest with `<-` what the context is,
#' we need to do it from the parent.
#' @examplesIf rlang::is_installed("data.tree")
#' # identical
#' styler:::create_tree("x <- 2")
#' styler:::create_tree("c(x <- 2)")
#' @keywords internal
force_assignment_eq = function(pd) {
  if (styler:::is_function_call(pd) ||
    isTRUE(pd$token[styler:::next_non_comment(pd, 0L)] == "'('")
  ) {
    return(pd)
  }
  pd$child[pd$token == "expr"] = purrr::map(
    pd$child[pd$token == "expr"], function(pd_child) {
      to_replace = pd_child$token == "LEFT_ASSIGN" & pd_child$text == "<-"
      if (any(to_replace)) {
        pd_child$token[to_replace] = "EQ_ASSIGN"
        pd_child$text[to_replace] = "="
      }
      pd_child
    })
  pd
}

# set_line_break_after_fun_dec_header = function(pd) {
#   if (any(pd$token == "FUNCTION") &&
#     pd$child[[nrow(pd)]]$token[1] == "'{'"
#   ) {
#     pos = styler:::next_non_comment(pd$child[[nrow(pd)]], 1)
#     pd$child[[nrow(pd)]]$lag_newlines[pos] = min(
#       2L,
#       pd$child[[nrow(pd)]]$lag_newlines[pos]
#     )
#   }
#   pd
# }

# if ) follows on }, add line break
add_line_break_before_round_closing_after_curly = function(pd) {
  round_after_curly = pd$token == "')'" & (pd$token_before == "'}'")
  pd$lag_newlines[round_after_curly] = min(pd$lag_newlines[round_after_curly], 1L)
  pd
}

style_line_break_around_curly = function(strict, pd) {
  if (styler:::is_curly_expr(pd) && nrow(pd) > 2) {
    closing_before = pd$token == "'}'"
    opening_before = (pd$token == "'{'") & (pd$token_after != "COMMENT")
    to_break = styler:::lag(opening_before, default = FALSE) | closing_before
    pd$lag_newlines[to_break] = pmin(2L, pd$lag_newlines[to_break])
  }
  pd
}
