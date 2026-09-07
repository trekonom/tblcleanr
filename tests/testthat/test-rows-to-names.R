test_that("rows_to_names renames all columns by default", {
  d <- data.frame(
    a = c("Total", "0 - 20", 10),
    b = c("Total", "20 - 40", 8),
    c = c("Total", "40 - 60", 6),
    stringsAsFactors = FALSE
  )
  out <- rows_to_names(d, 1:2)
  expect_equal(nrow(out), 1)
  expect_equal(names(out), c("Total_0 - 20", "Total_20 - 40", "Total_40 - 60"))
})

test_that("rows_to_names all.cols excludes columns by name", {
  d <- data.frame(
    a = c("Total", "0 - 20", 10),
    b = c("Total", "20 - 40", 8),
    c = c("Total", "40 - 60", 6),
    stringsAsFactors = FALSE
  )
  out <- rows_to_names(d, 1:2, all.cols = "b")
  expect_equal(names(out), c("Total_0 - 20", "b", "Total_40 - 60"))
})

test_that("rows_to_names all.cols excludes columns by index", {
  d <- data.frame(
    a = c("Total", "0 - 20", 10),
    b = c("Total", "20 - 40", 8),
    c = c("Total", "40 - 60", 6),
    stringsAsFactors = FALSE
  )
  out <- rows_to_names(d, 1:2, all.cols = 2:3)
  expect_equal(names(out), c("Total_0 - 20", "b", "c"))
})

test_that("rows_to_names all.cols = FALSE renames only columns matching regex", {
  d <- data.frame(
    a = c("Total", "0 - 20", 10),
    b = c("Total", "20 - 40", 8),
    c = c("Total", "40 - 60", 6),
    stringsAsFactors = FALSE
  )
  names(d) <- c("...1", "b", "c")
  out <- rows_to_names(d, 1:2, all.cols = FALSE)
  expect_equal(names(out), c("Total_0 - 20", "b", "c"))
})

test_that("rows2header is an alias for rows_to_names", {
  expect_identical(rows2header, rows_to_names)
})
