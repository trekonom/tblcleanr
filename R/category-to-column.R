#' Category to Column
#'
#' @param x a dataframe
#' @param val the column containing category names
#' @param ... the columns to check for NA
#' @param name a character. Name of column
#'
#' @export
#'
#' @example inst/ex/ex-category_row_to_column.R
category_row_to_column <- function(x, val, ..., name = "name") {
  args <- rlang::enquos(...)

  x <- dplyr::mutate(x, .is_category = rowSums(
    dplyr::across(c(!!!args), ~ !is.na(.x))
  ) == 0 & !is.na({{ val }}))
  x <- dplyr::mutate(x, "{name}" := ifelse(
    .data[[".is_category"]], {{ val }}, NA_character_))
  x <- tidyr::fill(x, !!rlang::sym(name))
  x <- dplyr::filter(x, !.data[[".is_category"]])
  x <- dplyr::select(x, -".is_category")
  x
}

category_col_to_column <- function(x, val, where, name = "name", value = "value") {
  x <- dplyr::mutate(x, !!rlang::sym(name) := ifelse({{ where }}, {{ val }}, NA_character_))
  x <- tidyr::fill(x, !!rlang::sym(name))
  x <- dplyr::mutate(x, {{ val }} := ifelse({{ where }}, value, {{ val }}))

  x
}
