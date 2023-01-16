#' Category to Column
#'
#' @param x a dataframe
#' @param val the column containing category names
#' @param ... the columns to check for NA
#' @param name a character. Name of column
#'
#' @export
#'
#' @examples
#' d <- data.frame(
#'   x = c(NA, "A", "B", NA, "A", "B"),
#'   y = c("a", 1:2, "b", 1:2),
#'   z = c(NA, "A", "B", NA, "A", "B")
#' )
#' category_row_to_column(d, y, x, z)
#'
#' category_row_to_column(d, y, x, z, name = "small")
category_row_to_column <- function(x, val, ..., name = "name") {
  args <- rlang::enquos(...)
  x <- dplyr::rowwise(x)
  x <- dplyr::mutate(x, .is_category = all(is.na(dplyr::c_across(c(!!!args)))) & !is.na({{ val }}))
  x <- dplyr::ungroup(x)
  x <- dplyr::mutate(x, !!rlang::sym(name) := ifelse(.data[[".is_category"]], {{ val }}, NA_character_))
  x <- tidyr::fill(x, !!rlang::sym(name))
  x <- dplyr::filter(x, !.data[[".is_category"]])
  x <- dplyr::select(x, -.data[[".is_category"]])
  x
}

category_col_to_column <- function(x, val, where, name = "name", value = "value") {
  x <- dplyr::mutate(x, !!rlang::sym(name) := ifelse({{ where }}, {{ val }}, NA_character_))
  x <- tidyr::fill(x, !!rlang::sym(name))
  x <- dplyr::mutate(x, {{ val }} := ifelse({{ where }}, value, {{ val }}))

  x
}
