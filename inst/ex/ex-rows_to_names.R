d <- data.frame(
  a = c("Total", "0 - 20", 10),
  b = c("Total", "20 - 40", 8),
  c = c("Total", "40 - 60", 6)
)
# Rename all columns
rows_to_names(d, 1:2)
# Do not rename column "b"
rows_to_names(d, 1:2, all.cols = "b")
# Do not rename columns 2:3
rows_to_names(d, 1:2, all.cols = 2:3)
# Rename only columns starting with `...`
rows_to_names(d, 1:2, all.cols = FALSE)
