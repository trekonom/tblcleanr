#' Replace matched patterns in rows
#'
#' @param x dataframe
#' @param rows Rows to look for pattern.
#' @param pattern Pattern to look for.
#' @param replacement A character vector of replacements.
#'
#' @export
#'
#' @example inst/ex/ex-str_replace_row.R
str_replace_row <- function(x, rows, pattern, replacement) {
  x_rows <- x[rows, ]
  if (pattern != "") {
    x_rows <- rowwise(x_rows)
    x_rows <- mutate(x_rows, across(everything(), gsub, pattern = pattern, replacement = replacement))
    x_rows <- ungroup(x_rows)
  } else {
    x_rows[x_rows == ""] <- replacement
  }

  x[rows, ] <- x_rows
  x
}

#' @rdname str_replace_row
#' @export
str_replace_row_na <- function(x, rows, pattern) {
  str_replace_row(x, rows, pattern, NA_character_)
}
