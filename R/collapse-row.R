#' Collapse rows
#'
#' Collapse rows into one by concatenating contents column-wise
#' @param x a dataframe
#' @param rows rows to collapse
#' @param sep separator. Defaults to "_".
#' @param na.rm Should NAs be removed before concatenating?
#'
#' @export
#'
#' @example inst/ex/ex-collapse_row.R
collapse_row <- function(x, rows, sep = "_", na.rm = TRUE) {
  x_rows <- slice(x, rows)
  x_rows <- as.data.frame(t(x_rows))
  x_rows <- unite(x_rows, "collapse", na.rm = na.rm, sep = sep)[, 1, drop = TRUE]
  x[rows[1],] <- as.list(x_rows)
  slice(x, -rows[-1])
}
