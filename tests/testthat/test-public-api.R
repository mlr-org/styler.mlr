test_that("multiplication works", {
  expect_equal(
    style_text("x = 1 ") %>%
      as.character(),
    "x = 1"
  )
})
