#' Category to Column
#'
#' @param .data a dataframe
#' @param .col the column containing category names
#' @param pattern a regex pattern to match category rows
#' @param ... the columns to check for NA
#' @param name a character. Name of column
#'
#' @name category-row-to-column
#'
#' @example inst/ex/ex-category-row-to-column.R

#' @rdname category-row-to-column
#' @export
category_row_na <- function(x, .col, ..., name = "name") {
  args <- rlang::enquos(...)

  x <- dplyr::mutate(x,
    .is_category = rowSums(
      dplyr::across(c(!!!args), ~ !is.na(.x))
    ) == 0 & !is.na({{ .col }})
  )
  x <- dplyr::mutate(x,
    "{name}" := ifelse(.data[[".is_category"]], {{ .col }}, NA_character_),
    .before = 1
  )
  x <- tidyr::fill(x, !!rlang::sym(name))
  x <- dplyr::filter(x, !.data[[".is_category"]])
  x <- dplyr::select(x, -".is_category")
  x
}

#' @rdname category-row-to-column
#' @export
category_row_regex <- function(x, .col, pattern, name = "name") {
  x |>
    dplyr::mutate(
      .is_category = grepl(pattern, {{ .col }}),
      "{name}" := ifelse(.data$.is_category, {{ .col }}, NA_character_),
      .before = 1
    ) |>
    tidyr::fill(.data[[name]]) |>
    dplyr::filter(!.is_category) |>
    dplyr::select(-.is_category)
}

category_col_to_column <- function(x, .col, where, name = "name", value = "value") {
  x <- dplyr::mutate(
    x,
    "{name}" := ifelse({{ where }}, {{ .col }}, NA_character_)
  )
  x <- tidyr::fill(x, .data[[name]])
  x <- dplyr::mutate(
    x,
    {{ .col }} := ifelse({{ where }}, value, {{ .col }})
  )

  x
}

#' @rdname category-row-to-column
#' @export
category_row_to_column <- category_row_na
