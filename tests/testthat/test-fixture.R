test_that("fixtures can be read", {
  path <- test_path(fs::path("fixtures", "the-fixture.csv"))
  expected <- data.frame(x = c(1, 3), y = c(2, 4))
  expect_equal(read.csv(path), expected)
})
