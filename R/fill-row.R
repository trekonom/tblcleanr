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
#' @importFrom dplyr mutate across
#' @importFrom tidyselect everything
fill_row <- function(x, rows, direction = "right", browse = FALSE) {
  if (browse) browser()

  nrows <- seq_along(rows)
  tbl_row <- as.data.frame(t(x[rows,]))
  tbl_row <- if (direction == "right") {
    fill(tbl_row, nrows, .direction = "down")
  } else {
    fill(tbl_row, nrows, .direction = "up")
  }
  tbl_row <- as.data.frame(t(tbl_row))
  x <- mutate(x, across(everything(), as.character))
  x[rows,] <- tbl_row
  x
}
