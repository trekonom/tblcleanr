test_that("fill_row fills right by default", {
  d <- data.frame(
    a = c("Total", "0 - 20", 10),
    b = c(NA, "20 - 40", 8),
    c = c(NA, "40 - 60", 6),
    stringsAsFactors = FALSE
  )
  out <- fill_row(d, 1)
  expect_equal(out$a, c("Total", "0 - 20", "10"))
  expect_equal(out$b, c("Total", "20 - 40", "8"))
  expect_equal(out$c, c("Total", "40 - 60", "6"))
})

test_that("fill_row fills left", {
  d <- data.frame(
    a = c("Total", 1),
    b = c(NA, 2),
    c = c(NA, 3),
    stringsAsFactors = FALSE
  )
  out <- fill_row(d, 1, direction = "left")
  expect_equal(out$a, c("Total", "1"))
  expect_equal(out$b, c(NA, "2"))
  expect_equal(out$c, c(NA, "3"))
})

test_that("fill_row preserves the class of columns it doesn't touch", {
  d <- data.frame(
    label = c(NA, "x", "y"),
    n = c(1, 2, 3),
    stringsAsFactors = FALSE
  )
  out <- fill_row(d, 1)
  expect_type(out$n, "double")
  expect_equal(out$n, c(1, 2, 3))
})
