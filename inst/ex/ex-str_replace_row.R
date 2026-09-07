d <- data.frame(
  a = c("Footnote: total", "0 - 20 *", "20 - 40 *"),
  b = c("Footnote: total", "5", "8"),
  stringsAsFactors = FALSE
)

# Strip a label prefix from a single row
str_replace_row(d, 1, "Footnote: ", "")

# Blank out a footnote row entirely
str_replace_row_na(d, 1, "^Footnote:.*$")
