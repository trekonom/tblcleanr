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

# Coerce col back to original's class after a row-subset assignment forced
# a whole-column promotion (e.g. writing character values into a numeric
# column via `x[rows, ] <- ...` promotes that column to character for all
# rows, not just the ones written to).
restore_class <- function(col, original) {
  if (identical(class(col), class(original))) {
    return(col)
  }
  switch(class(original)[1],
    numeric = as.numeric(col),
    integer = as.integer(col),
    logical = as.logical(col),
    Date = as.Date(col),
    factor = factor(col, levels = levels(original)),
    col
  )
}
