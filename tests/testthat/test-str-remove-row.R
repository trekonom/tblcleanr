test_that("str_remove_row removes a matched pattern in the given rows", {
  d <- data.frame(a = c("foo1", "bar2"), b = c("baz3", "qux4"), stringsAsFactors = FALSE)
  out <- str_remove_row(d, 1:2, "[0-9]")
  expect_equal(out$a, c("foo", "bar"))
  expect_equal(out$b, c("baz", "qux"))
})
