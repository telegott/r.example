test_that("package is lint free", {
  lintr::expect_lint_free(path = ".", relative_path = FALSE)
})
