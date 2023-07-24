#' Make Names from rows
#'
#' @param x A data frame
#' @param rows rows to make the header from
#' @param sep seperator. Defaults to "_".
#' @param na.sep seperator to be used for NAs if `na.rm=FALSE`. Defaults to `sep`.
#' @param na.rm a logical. Remove NAs
#' @param all.cols Should all columns be renamed?
#' @param regex A regular expression to select columns to rename if `all.cols = FALSE`.
#'
#' @export
#'
#' @example inst/ex/ex-rows_to_names.R
#'
#' @importFrom tidyr unite
rows_to_names <- function(x, rows, sep = "_", na.sep = sep, na.rm = TRUE,
                          all.cols = TRUE, regex = "^(\\.{3}|X\\d+)") {
  names_data <- names(x)
  cols2rename <- rep(TRUE, length(names_data))
  if (is.logical(all.cols) && isFALSE(all.cols)) {
    cols2rename <- grepl(regex, names_data)
  } else if (is.character(all.cols)) {
    cols2rename <- !names_data %in% all.cols
  } else if (is.numeric(all.cols)) {
    cols2rename[all.cols] <- FALSE
  }
  header <- x[rows, ]
  header <- as.data.frame(t(header))
  header <- unite(header, "header", sep = sep, na.rm = na.rm)
  header <- header[["header"]]
  if (!na.rm) header <- gsub(paste0("NA", sep), paste0("NA", na.sep), header)
  x <- x[-rows, ]
  names(x)[cols2rename] <- header[cols2rename]
  x
}

#' @rdname rows_to_names
#' @export
rows2header <- rows_to_names
