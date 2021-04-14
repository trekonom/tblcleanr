# ex-remove_rows_not_na_col
d <- data.frame(
  x = c(1, 2, 3),
  y = c(1, 2, NA),
  z = c(1, NA, NA),
  w = c(1, NA, NA)
)
# Remove rows which contain only NA in columns when excluding cols 1 and 2
remove_rows_not_na_col(d, col = c(1, 2),)
# Remove all rows from the first two rows
# which contain only NA in columns when excluding cols 1 and 2
remove_rows_not_na_col(d, col = c(1, 2), rows = 1:2)
# Remove rows with exactly two NA
remove_rows_not_na_n(d, n = 2)
