d <- data.frame(a = c("Male", "0 - 20", 10),
                b = c("Male", "20 - 40", 8),
                c = c("Female", "40 - 60", 6))

collapse_row(d, 1:2)
