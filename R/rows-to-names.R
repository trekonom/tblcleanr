#' Make Names from rows
#'
#' @param x A data frame
#' @param rows rows to make the header from
#' @param sep seperator. Defaults to "_".
#' @param na.rm a logical. Remove NAs
#' @param all.cols Should all columns be renamed?
#'
#' @export
#'
#' @example inst/ex/ex-rows_to_names.R
#'
#' @importFrom tidyr unite
rows_to_names <- function(x, rows, sep = "_", na.rm = TRUE, all.cols = TRUE) {
  names_data <- names(x)
  cols2rename <- rep(TRUE, length(names_data))
  if (is.logical(all.cols) & isFALSE(all.cols)) {
    cols2rename <- grepl("^\\.{3}", names_data)
  } else if (is.character(all.cols)) {
    cols2rename <- !names_data %in% all.cols
  } else if (is.numeric(all.cols)) {
    cols2rename[all.cols] <- FALSE
  }
  header <- x[rows, ]
  header <- as.data.frame(t(header))
  header <- unite(header, "header", sep = sep, na.rm = na.rm)
  x <- x[-rows, ]
  names(x)[cols2rename] <- header$header[cols2rename]
  x
}

#' @rdname rows_to_names
#' @export
rows2header <- rows_to_names
