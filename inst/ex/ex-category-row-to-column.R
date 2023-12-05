d <- data.frame(
  x = c(NA, "A", "B", NA, "A", "B"),
  y = c("a", 1:2, "b", 1:2),
  z = c(NA, "A", "B", NA, "A", "B")
)
category_row_na(d, y, x, z)

category_row_na(d, y, x, z, name = "small")

# Cleaning a Table with two different kinds of category rows
d <- data.frame(
  x = c(NA, NA, "A", "B", NA, NA, "A", "B"),
  y = c("Table a", "Male",  1:2, "Table b", "Female",  1:2),
  z = c(NA, NA, "A", "B", NA, NA, "A", "B")
)

d |>
  category_row_regex(y, "^Table", name = "table") |>
  category_row_na(y, x, z, name = "sex")
