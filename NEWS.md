# tblcleanr 0.1.0

* Added a `NEWS.md` file to track changes to the package.

## New

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
