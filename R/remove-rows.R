#' Remove Rows with limited Number of Non-Missing Values
#'
#' @param x a vector
#' @param n a integer vector. number of non-missing values
#' @param col a integer vector. columns to exclude when checking for NA rows
#' @param rows rows to check as a vector of row indices or as a regex
#' @param .direction in case that rows is a regex .direction sets the direction
#'     in which to include the rows to check. One of "up" or "down"
#' @export
#'
#' @example inst/ex/ex-remove_rows_not_na_col.R
#' @importFrom dplyr rowwise filter ungroup c_across
remove_rows_not_na_n <- function(x, n = 1) {
  x <- rowwise(x)
  x <- filter(x, !sum(is.na(c_across())) %in% n)
  ungroup(x)
}

#' @rdname remove_rows_not_na_n
#' @export
remove_rows_na_n <- function(x, n = 1) {
  x <- rowwise(x)
  x <- filter(x, !sum(!is.na(c_across())) %in% n)
  ungroup(x)
}

#' @rdname remove_rows_not_na_n
#' @export
remove_cols_na_n <- function(x, n = 1) {
  select(x, -which(colSums(!is.na(x)) %in% n))
}

#' @rdname remove_rows_not_na_n
#' @export
remove_rows_not_na_col <- function(x, col = 1, rows = NULL, .direction = "up") {
  x[] <- lapply(x, as.character)
  if (is.character(rows)) {
    rows <- which(grepl(rows, x[, 1, drop = TRUE]))
    if (.direction == "down") {
      rows <- seq(max(rows), nrow(x), 1)
    } else {
      rows <- seq(max(rows))
    }
  }
  if (is.numeric(rows)) {
    is_row_drop <- seq(nrow(x)) %in% rows
  } else {
    is_row_drop <- rep(TRUE, nrow(x))
  }
  x <- cbind(is_row_drop, x)
  cols <- setdiff(seq_along(names(x)), c(1, col + 1))
  x <- x[!(is_row_drop & rowSums(is.na(x[cols])) == length(cols)), , drop = FALSE]
  x[["is_row_drop"]] <- NULL

  x
}
