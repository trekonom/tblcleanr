#' Fill in missing values in rows with previous or next row value
#'
#' This function is useful for tidying messy datasets, e.g. when importing data from formatted tables.
#'
#' @param x A dataframe
#' @param rows Rows to fill
#' @param direction Direction in which to fill missing values. Either "right" (the default) or "left.
#' @param browse debug
#'
#' @export
#'
#' @example inst/ex/ex-fill_row.R
#'
#' @importFrom tidyr fill
fill_row <- function(x, rows, direction = "right", browse = FALSE) {
  if (browse) browser()

  nrows <- seq_along(rows)
  tbl_row <- as.data.frame(t(x[rows,]))
  tbl_row <- if (direction == "right") {
    fill(tbl_row, tidyselect::all_of(nrows), .direction = "down")
  } else {
    fill(tbl_row, tidyselect::all_of(nrows), .direction = "up")
  }
  tbl_row <- as.data.frame(t(tbl_row))

  x_orig <- x
  x[rows,] <- tbl_row
  x[] <- Map(restore_class, x, x_orig)
  x
}
