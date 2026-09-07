# tblcleanr 0.1.2.9000

## Bug fixes

* `fill_row()` and `remove_rows_not_na_col()` no longer silently coerce every
  column of the input to character. Previously any call to either function
  would return a data frame with all columns converted to `character`,
  regardless of their original type.

* `category_row_regex()` now uses `.data[[...]]` consistently (matching
  `category_row_na()`) instead of bare column-name symbols, avoiding
  "no visible binding for global variable" `R CMD check` notes.

* `remove_cols_na_n()` no longer emits a spurious "'drop' argument will be
  ignored" warning on every call.

## Internal

* Removed the unexported, unfinished `category_col_to_column()` helper.

# tblcleanr 0.1.1.9000

## New

* Add category_row_regex to move category rows to a new column based on a matching pattern.

* rows_to_names gains argument `regex` to select which columns to rename when `all.cols=FALSE`.

## Changes

* Rename category_row_to_column as category_row_na. category_row_to_column still works. 
  Note however that the `val` argument was renamed to `.col`.

# tblcleanr 0.1.1

## New

* rows_to_names gains argument `na.sep` to set a different seperator used for `NA`s if `na.rm=FALSE`.

* tblcleanr gains functions remove_rows_na_n and remove_cols_na_n to remove rows and cols with a given number of NA values

* tblcleanr gains function category_row_to_column to make it easy to move 
  category labels contained in rows into a new column.
  
* tblcleanr gains function as_excel_date to make it easy to convert dates 
  imported from excel to proper R dates.
  
* tblcleanr gains convenience function str_replace_row_na to replace patterns in 
  rows with NA.
  
* rows2header is now called rows_to_names. rows2header is kept for now to avoid breaking of old code.
  
## Bug fixes

* remove_rows_not_na_col now automatically converts all columns to character

* Added a `NEWS.md` file to track changes to the package.
