#' Make Column Header from rows
#'
#' @param data A data frame
#' @param rows rows to make the header from
#' @param sep seperator. Defaults to "_".
#' @param na.rm a logical. Remove NAs
#' @param all.cols Should all columns be renamed?
#'
#' @export
#'
#' @example inst/ex/ex-rows2header.R
#'
#' @importFrom dplyr slice ungroup c_across
#' @importFrom tidyr unite
rows2header <- function(data, rows, sep = "_", na.rm = TRUE, all.cols = TRUE) {
  data <- mutate(data, across(everything(), as.character))
  names_data <- names(data)
  cols2rename <- rep(TRUE, length(names_data))
  if (is.logical(all.cols) & isFALSE(all.cols)) {
    cols2rename <- grepl("^\\.{3}", names_data)
  } else if (is.character(all.cols)) {
    cols2rename <- !names_data %in% all.cols
  } else if (is.numeric(all.cols)) {
    cols2rename[all.cols] <- FALSE
  }
  header <- slice(data, rows)
  header <- as.data.frame(t(header))
  header <- unite(header, "header", na.rm = na.rm)
  data <- slice(data, -rows)
  names(data)[cols2rename] <- header$header[cols2rename]
  data
}
