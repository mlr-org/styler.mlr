version = unlist(unname(read.dcf("DESCRIPTION")[, "Version"]))

#' The mlr style
#'
#' Style code according to the mlr style guide. For more details and docs, see
#' the [styler::tidyverse_style()].
#' @inheritParams styler::tidyverse_style
#' @details
#' The following levels for `scope` are available:
#'
#' * "none": Performs no transformation at all.
#' * "spaces": Manipulates spacing between token on the same line.
#' * "indention": Manipulates the indention, i.e. number of spaces at the
#'   beginning of each line.
#' * "line_breaks": Manipulates line breaks between tokens.
#' * "tokens": manipulates tokens.
#'
#' `scope` can be specified in two ways:
#'
#' - As a string: In this case all less invasive scope levels are implied, e.g.
#'   "line_breaks" includes "indention", "spaces". This is brief and what most
#'   users need.
#' - As vector of class `AsIs`: Each level has to be listed explicitly by
#'   wrapping one ore more levels of the scope in [I()]. This offers more
#'   granular control at the expense of more verbosity.
#'
#' @family obtain transformers
#' @family style_guides
#' @examples
#' style_text("call( 1)", style = mlr_style, scope = "spaces")
#' style_text("call( 1)", transformers = mlr_style(strict = TRUE))
#' @importFrom purrr partial
#' @export
mlr_style = function(scope = "tokens",
  strict = TRUE,
  indent_by = 2,
  start_comments_with_one_space = FALSE,
  reindention = tidyverse_reindention(),
  math_token_spacing = tidyverse_math_token_spacing()
) {

  args = as.list(environment())
  scope = styler:::scope_normalize(scope)
  indention_manipulators = if ("indention" %in% scope) {
    list(
      indent_braces = partial(styler:::indent_braces, indent_by = indent_by),
      indent_op = partial(styler:::indent_op, indent_by = indent_by),
      indent_eq_sub = partial(styler:::indent_eq_sub, indent_by = indent_by),
      indent_without_paren = partial(styler:::indent_without_paren,
        indent_by = indent_by
      )
    )
  }
  space_manipulators = if ("spaces" %in% scope) {
    list(
      remove_space_before_closing_paren = styler:::remove_space_before_closing_paren,
      remove_space_before_opening_paren = if (strict) {
        styler:::remove_space_before_opening_paren
      },
      add_space_after_for_if_while = styler:::add_space_after_for_if_while,
      remove_space_before_comma = styler:::remove_space_before_comma,
      style_space_around_math_token = partial(
        styler:::style_space_around_math_token, strict,
        math_token_spacing$zero,
        math_token_spacing$one
      ),
      style_space_around_tilde = partial(
        styler:::style_space_around_tilde,
        strict = strict
      ),
      spacing_around_op = purrr::partial(
        styler:::set_space_around_op,
        strict = strict
      ),
      # already called in spacing_around_op
      # spacing_around_comma = if (strict) {
      #   # set_space_after_comma
      #   styler:::add_space_after_comma
      # } else {
      #   styler:::add_space_after_comma
      # },
      remove_space_after_opening_paren = styler:::remove_space_after_opening_paren,
      remove_space_after_excl = styler:::remove_space_after_excl,
      set_space_after_bang_bang = styler:::set_space_after_bang_bang,
      remove_space_before_dollar = styler:::set_space_after_bang_bang,
      remove_space_after_fun_dec = styler:::set_space_after_bang_bang,
      remove_space_around_colons = styler:::set_space_after_bang_bang,
      start_comments_with_space = partial(
        styler:::start_comments_with_space,
        force_one = start_comments_with_one_space
      ),
      remove_space_after_unary_pm_nested = styler:::remove_space_after_unary_pm_nested,
      spacing_before_comments = if (strict) {
        styler:::set_space_before_comments
      } else {
        styler:::add_space_before_comments
      },
      set_space_between_levels = styler:::set_space_between_levels,
      set_space_between_eq_sub_and_comma = styler:::set_space_between_eq_sub_and_comma
      # set_space_in_curly_curly = styler:::set_space_in_curly_curly
    )
  }

  use_raw_indention = !("indention" %in% scope)

  line_break_manipulators = if ("line_breaks" %in% scope) {
    list(
      # set_line_break_around_comma_and_or = styler:::set_line_break_around_comma_and_or,
      # set_line_break_after_assignment = set_line_break_after_assignment,
      # set_line_break_before_curly_opening = set_line_break_before_curly_opening,
      style_line_break_around_curly = partial(
        style_line_break_around_curly,
        strict = strict
      ),
      # remove_line_breaks_in_fun_dec =
      #   if (strict) remove_line_breaks_in_fun_dec,
      # set_line_break_around_curly_curly = styler:::set_line_break_around_curly_curly,
      set_line_break_before_closing_call = if (strict) {
        partial(
          set_line_break_before_closing_call,
          except_token_before = "COMMENT"
        )
      },
      # set_line_break_after_opening_if_call_is_multi_line = if (strict) {
      #   partial(
      #     styler:::set_line_break_after_opening_if_call_is_multi_line,
      #     except_token_after = "COMMENT",
      #     except_text_before = c("ifelse", "if_else"), # don't modify line break here
      #     force_text_before = c("switch") # force line break after first token
      #   )
      # },
      # remove_line_break_in_fun_call = purrr::partial(
      #   styler:::remove_line_break_in_fun_call,
      #   strict = strict
      # ),
      add_line_break_after_pipe = styler:::add_line_break_after_pipe,
      # this breaks }) into separate lines, see https://github.com/r-lib/styler/issues/514#issue-443293104
      add_line_break_before_round_closing_after_curly
      # add_line_break_after_pipe = if (strict) add_line_break_after_pipe,
      # set_linebreak_after_ggplot2_plus = if (strict) set_linebreak_after_ggplot2_plus
    )
  }

  token_manipulators = if ("tokens" %in% scope) {
    list(
      fix_quotes = styler:::fix_quotes,
      force_assignment_eq = force_assignment_eq,
      resolve_semicolon = styler:::resolve_semicolon,
      add_brackets_in_pipe = styler:::add_brackets_in_pipe,
      wrap_if_else_while_for_fun_multi_line_in_curly =
        if (strict) styler:::wrap_if_else_while_for_fun_multi_line_in_curly
    )
  }



  transformers_drop = specify_transformers_drop(
    spaces = list(
      add_space_after_for_if_while = c("IF", "WHILE", "FOR"),
      # remove_space_before_comma = "','",
      set_space_between_eq_sub_and_comma = "EQ_SUB",
      style_space_around_math_token = c(
        math_token_spacing$zero,
        math_token_spacing$one
      ),
      style_space_around_tilde = "'~'",
      # remove_space_after_opening_paren = c("'('", "'['", "LBB"),
      remove_space_after_excl = "'!'",
      set_space_after_bang_bang = "'!'",
      remove_space_before_dollar = "'$'",
      remove_space_after_fun_dec = "FUNCTION",
      remove_space_around_colons = c("':'", "NS_GET_INT", "NS_GET"),
      start_comments_with_space = "COMMENT",
      remove_space_after_unary_pm_nested = c("'+'", "'-'"),
      spacing_before_comments = "COMMENT"
    ),
    indention = list(),
    line_breaks = list(
      style_line_break_around_curly = "'{'",
      add_line_break_after_pipe = c("SPECIAL-PIPE", "PIPE")
    ),
    tokens = list(
      resolve_semicolon = "';'",
      add_brackets_in_pipe = c("SPECIAL-PIPE", "PIPE"),
      # before 3.6, these assignments are not wrapped into top level expression
      # and `text` supplied to transformers_drop() is "", so it appears to not
      # contain EQ_ASSIGN, and the transformer is falsely removed.
      # compute_parse_data_nested / text_to_flat_pd ('a = 4')
      force_assignment_op = "LEFT_ASSIGN",
      wrap_if_else_while_for_fun_multi_line_in_curly = c("IF", "WHILE", "FOR", "FUNCTION")
    )
  )

  if (getRversion() < "3.6") {
    transformers_drop$token$force_assignment_op = NULL
  }

  create_style_guide(
    # transformer functions
    initialize = default_style_guide_attributes,
    line_break = line_break_manipulators,
    space = space_manipulators,
    indention = indention_manipulators,
    token = token_manipulators,
    # transformer options
    use_raw_indention = use_raw_indention,
    reindention = reindention,
    style_guide_name = "styler.mlr::mlr_style@https://github.com/mlr-org/styler.mlr/",
    style_guide_version = version,
    more_specs_style_guide = args,
    transformers_drop = transformers_drop
  )
}
