test_that("collapse_row concatenates rows column-wise and drops the extra rows", {
  d <- data.frame(
    a = c("Male", "0 - 20", 10),
    b = c("Male", "20 - 40", 8),
    c = c("Female", "40 - 60", 6),
    stringsAsFactors = FALSE
  )
  out <- collapse_row(d, 1:2)
  expect_equal(nrow(out), 2)
  expect_equal(out$a, c("Male_0 - 20", "10"))
  expect_equal(out$b, c("Male_20 - 40", "8"))
  expect_equal(out$c, c("Female_40 - 60", "6"))
})
