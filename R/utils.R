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
