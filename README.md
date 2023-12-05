
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tblcleanr

<!-- badges: start -->
<!-- badges: end -->

The goal of tblcleanr is to make it easier to tidy real world data
tables.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("trekonom/tblcleanr")
```

## Example

Here is a typical example of how to use `tblcleanr` to tidy a messy data
table. The example data is drawn from the
[`unpivotr`](https://nacnudus.github.io/unpivotr/) package which serves
a similar purpose and follows a simliar approach as `tblcleanr`:

``` r
library(tidyverse)
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.4     ✔ readr     2.1.4
#> ✔ forcats   1.0.0     ✔ stringr   1.5.1
#> ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
#> ✔ lubridate 1.9.3     ✔ tidyr     1.3.0
#> ✔ purrr     1.0.2     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
library(unpivotr)
#> 
#> Attaching package: 'unpivotr'
#> 
#> The following objects are masked from 'package:tidyr':
#> 
#>     pack, unpack
library(tblcleanr)

x <- purpose$`up-left left-up`

head(x)
#>                  X2      X3     X4     X5    X6     X7
#> 1              <NA>    <NA> Female   <NA>  Male   <NA>
#> 2              <NA>    <NA>  0 - 6 7 - 10 0 - 6 7 - 10
#> 3 Bachelor's degree 15 - 24   7000  27000  <NA>  13000
#> 4              <NA> 25 - 44  12000 137000  9000  81000
#> 5              <NA> 45 - 64  10000  64000  7000  66000
#> 6              <NA>     65+   <NA>  18000  7000  17000

y <- x |>
  # Fill empty cells in first header row
  fill_row(1) |>
  # Fill qualification column
  fill(1) |>
  # Move header rows to colum names
  rows_to_names(1:2) |>
  # Rename tidy columns
  rename(qualification = 1, "age-band" = 2) |>
  # Reshape to tidy format
  pivot_longer(-c(qualification, `age-band`),
    names_to = c("sex", "life_satisfaction"),
    names_sep = "_",
    values_to = "count"
  ) |> 
  # Convert data type
  mutate(count = as.integer(count))

head(y)
#> # A tibble: 6 × 5
#>   qualification     `age-band` sex    life_satisfaction  count
#>   <chr>             <chr>      <chr>  <chr>              <int>
#> 1 Bachelor's degree 15 - 24    Female 0 - 6               7000
#> 2 Bachelor's degree 15 - 24    Female 7 - 10             27000
#> 3 Bachelor's degree 15 - 24    Male   0 - 6                 NA
#> 4 Bachelor's degree 15 - 24    Male   7 - 10             13000
#> 5 Bachelor's degree 25 - 44    Female 0 - 6              12000
#> 6 Bachelor's degree 25 - 44    Female 7 - 10            137000
```
