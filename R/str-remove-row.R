#' Remove matched patterns in rows
#'
#' @param x dataframe
#' @param rows Rows to look for pattern.
#' @param pattern Pattern to look for.
#'
#' @export
#'
#' @example inst/ex/ex-str_remove_row
str_remove_row <- function(x, rows, pattern) {
  str_replace_row(x, rows, pattern, "")
}
