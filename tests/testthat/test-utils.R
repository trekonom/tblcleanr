test_that("as_excel_date converts excel serial dates", {
  expect_equal(as_excel_date(46789), as.Date("2028-02-06"))
  expect_equal(as_excel_date(0), as.Date("1899-12-30"))
})
