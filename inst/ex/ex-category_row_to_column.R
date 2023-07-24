d <- data.frame(
  x = c(NA, "A", "B", NA, "A", "B"),
  y = c("a", 1:2, "b", 1:2),
  z = c(NA, "A", "B", NA, "A", "B")
)
category_row_to_column(d, y, x, z)

category_row_to_column(d, y, x, z, name = "small")
