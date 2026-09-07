test_that("str_replace_row replaces a matched pattern in the given rows", {
  d <- data.frame(a = c("foo1", "bar2"), b = c("baz3", "qux4"), stringsAsFactors = FALSE)
  out <- suppressWarnings(str_replace_row(d, 1:2, "[0-9]", "#"))
  expect_equal(out$a, c("foo#", "bar#"))
  expect_equal(out$b, c("baz#", "qux#"))
})

test_that("str_replace_row only touches the given rows", {
  d <- data.frame(a = c("foo1", "bar2"), b = c("baz3", "qux4"), stringsAsFactors = FALSE)
  out <- suppressWarnings(str_replace_row(d, 1, "[0-9]", "#"))
  expect_equal(out$a, c("foo#", "bar2"))
  expect_equal(out$b, c("baz#", "qux4"))
})

test_that("str_replace_row with pattern = '' replaces empty-string cells instead of pattern-matching", {
  d <- data.frame(a = c("", "bar2"), b = c("baz3", ""), stringsAsFactors = FALSE)
  out <- str_replace_row(d, 1:2, "", "MISSING")
  expect_equal(out$a, c("MISSING", "bar2"))
  expect_equal(out$b, c("baz3", "MISSING"))
})

test_that("str_replace_row_na blanks out matches with NA", {
  d <- data.frame(a = c("foo1", "bar2"), b = c("baz3", "qux4"), stringsAsFactors = FALSE)
  out <- suppressWarnings(str_replace_row_na(d, 1, "[0-9]"))
  expect_equal(out$a, c(NA_character_, "bar2"))
  expect_equal(out$b, c(NA_character_, "qux4"))
})
