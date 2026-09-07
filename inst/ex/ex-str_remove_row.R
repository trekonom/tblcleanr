d <- data.frame(
  a = c("Footnote: total", "0 - 20 *", "20 - 40 *"),
  b = c("Footnote: total", "5", "8"),
  stringsAsFactors = FALSE
)

# Strip a trailing footnote marker from the data rows
str_remove_row(d, 2:3, " \\*$")
