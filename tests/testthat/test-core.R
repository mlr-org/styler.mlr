test_that("calls", {
  expect_warning(styler:::test_collection("core",
    "calls",
    transformer = style_text
  ), NA)

  expect_warning(styler:::test_collection("core",
    "braces",
    transformer = style_text
  ), NA)

  expect_warning(styler:::test_collection("core",
    "pipes",
    transformer = style_text
  ), NA)

  expect_warning(styler:::test_collection("core",
    "conditional",
    transformer = style_text
  ), NA)
  expect_warning(styler:::test_collection("core",
    "loops",
    transformer = style_text
  ), NA)

  expect_warning(styler:::test_collection("core",
    "fun-dec",
    transformer = style_text
  ), NA)
})
