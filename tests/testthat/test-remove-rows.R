d <- data.frame(
  x = c(1, 2, 3, 5),
  y = c(1, 2, NA, NA),
  z = c(1, NA, NA, 3),
  w = c(1, NA, NA, 4)
)

test_that("remove_rows_not_na_n drops rows with exactly n NAs", {
  out <- remove_rows_not_na_n(d, n = 2)
  expect_equal(out$x, c(1, 3, 5))
})

test_that("remove_rows_not_na_n accepts a vector of n", {
  out <- remove_rows_not_na_n(d, n = 1:2)
  expect_equal(out$x, c(1, 3))
})

test_that("remove_rows_na_n drops rows with exactly n non-missing values", {
  out <- remove_rows_na_n(d, n = 2)
  expect_equal(out$x, c(1, 3, 5))
})

test_that("remove_cols_na_n drops columns with exactly n non-missing values, without warning", {
  expect_no_warning(out <- remove_cols_na_n(d, n = 2))
  expect_equal(names(out), "x")
  expect_equal(out$x, c(1, 2, 3, 5))
})

test_that("remove_rows_not_na_col drops rows that are all-NA outside excluded columns", {
  out <- remove_rows_not_na_col(d, col = c(1, 2))
  expect_equal(out$x, c(1, 5))
})

test_that("remove_rows_not_na_col only checks the given rows when rows is numeric", {
  out <- remove_rows_not_na_col(d, col = c(1, 2), rows = 1:2)
  expect_equal(out$x, c(1, 3, 5))
})

test_that("remove_rows_not_na_col preserves the class of untouched columns", {
  out <- remove_rows_not_na_col(d, col = c(1, 2))
  expect_type(out$x, "double")
  expect_type(out$y, "double")
})
