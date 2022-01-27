process <- function(input) {
  rnorm(1)
}

process_all <- function(inputs) {
  safe <- purrr::safely(process)
  results <- purrr::map(inputs, safe)
  successes <- results %>%
    purrr::map("result") %>%
    purrr::compact()
  failures <- results %>%
    purrr::map("error") %>%
    purrr::compact() %>%
    purrr::map(~as.character(.x$message))
  list(results = successes, failures = failures)
}
