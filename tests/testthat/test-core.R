test_that("line break for multi-line function declaration", {
  expect_warning(styler:::test_collection("core", "line-break",
    transformer = style_text,
  ), NA)
  expect_warning(styler:::test_collection("core", "data-table",
    transformer = style_text,
  ), NA)
  expect_warning(styler:::test_collection("core", "eq-sub-replacement",
    transformer = style_text,
  ), NA)
  expect_warning(styler:::test_collection("core", "fun-decs-comments",
    transformer = style_text,
  ), NA)
})
