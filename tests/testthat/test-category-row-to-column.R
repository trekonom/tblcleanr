test_that("category_row_na moves category-only rows into a new column", {
  d <- data.frame(
    x = c(NA, "A", "B", NA, "A", "B"),
    y = c("a", 1:2, "b", 1:2),
    z = c(NA, "A", "B", NA, "A", "B"),
    stringsAsFactors = FALSE
  )
  out <- category_row_na(d, y, x, z)
  expect_equal(out$name, c("a", "a", "b", "b"))
  expect_equal(out$y, c("1", "2", "1", "2"))
  expect_equal(nrow(out), 4)
})

test_that("category_row_na respects the name argument", {
  d <- data.frame(
    x = c(NA, "A", "B", NA, "A", "B"),
    y = c("a", 1:2, "b", 1:2),
    z = c(NA, "A", "B", NA, "A", "B"),
    stringsAsFactors = FALSE
  )
  out <- category_row_na(d, y, x, z, name = "small")
  expect_true("small" %in% names(out))
  expect_false("name" %in% names(out))
})

test_that("category_row_to_column is an alias for category_row_na", {
  expect_identical(category_row_to_column, category_row_na)
})

test_that("category_row_regex moves rows matching a pattern into a new column", {
  d <- data.frame(
    x = c(NA, NA, "A", "B", NA, NA, "A", "B"),
    y = c("Table a", "Male", 1:2, "Table b", "Female", 1:2),
    z = c(NA, NA, "A", "B", NA, NA, "A", "B"),
    stringsAsFactors = FALSE
  )
  out <- category_row_regex(d, y, "^Table", name = "table")
  expect_equal(unique(out$table), c("Table a", "Table b"))
  expect_false(any(grepl("^Table", out$y)))
  expect_equal(nrow(out), 6)
})

test_that("category_row_na and category_row_regex compose for tables with two category kinds", {
  d <- data.frame(
    x = c(NA, NA, "A", "B", NA, NA, "A", "B"),
    y = c("Table a", "Male", 1:2, "Table b", "Female", 1:2),
    z = c(NA, NA, "A", "B", NA, NA, "A", "B"),
    stringsAsFactors = FALSE
  )
  out <- d |>
    category_row_regex(y, "^Table", name = "table") |>
    category_row_na(y, x, z, name = "sex")
  expect_equal(nrow(out), 4)
  expect_equal(sort(unique(out$table)), c("Table a", "Table b"))
  expect_equal(sort(unique(out$sex)), c("Female", "Male"))
})
