test_that("process produces output", {
  actual <- process('doesnt-matter-in-this-example')
  expect_true(is.numeric(actual))
})

test_that("process_all collects results and errors", {

  process_mock <- function(input) {
    if (input == 'b') {
      stop("could not calculate for input 'b'")
    } else {
      input
    }
  }

  mockery::stub(process_all, 'process', process_mock)

  expected <- list(
    results = list('a', 'c'),
    failures = list("could not calculate for input 'b'")
  )
  actual <- process_all(c('a', 'b', 'c'))
  expect_equal(actual, expected)
})
