#' Excel date
#'
#' Function to convert Dates imported from Excel to proper R dates
#'
#' @param x a numeric. Vector of excel dates
#'
#' @export
#'
#' @examples
#' as_excel_date(46789)
as_excel_date <- function(x) {
  as.Date(as.numeric(x), origin = "1899-12-30")
}

check_data_frame <- function(x, arg = "x") {
  if (!is.data.frame(x)) {
    stop(sprintf("`%s` must be a data frame, not %s.", arg, class(x)[1]), call. = FALSE)
  }
}

check_rows <- function(x, rows, arg = "rows") {
  if (is.numeric(rows) && (any(rows < 1) || any(rows > nrow(x)))) {
    stop(
      sprintf(
        "`%s` must be between 1 and nrow(x) (%d), not %s.",
        arg, nrow(x), paste(rows, collapse = ", ")
      ),
      call. = FALSE
    )
  }
}

check_col <- function(x, col, arg = "col") {
  if (is.numeric(col) && (any(col < 1) || any(col > ncol(x)))) {
    stop(
      sprintf(
        "`%s` must be between 1 and ncol(x) (%d), not %s.",
        arg, ncol(x), paste(col, collapse = ", ")
      ),
      call. = FALSE
    )
  }
}
