force_assignment_eq <- function(pd) {
  to_replace <- pd$token == "LEFT_ASSIGN" & pd$text == "<-"
  if (any(to_replace) && styler:::next_terminal(pd)$token == "'('") {
    pd$token[to_replace] <- "EQ_ASSIGN"
    pd$text[to_replace] <- "="
  }
  pd
}
