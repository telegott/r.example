test_that("with valid parameters, does correct thing", {
  all_filepaths <- c('a/b.tif', 'a/b.tif', 'a/c.tif', 'b/b.tif')
  subset_filepaths <- c('a/b.tif', 'a/b.tif', 'a/c.tif')

  list_files_mock <- function(path, full.names, recursive, pattern) {
    condition <- path == "the-directory" &&
      full.names &&
      recursive &&
      pattern == "mohp_europe_*.*tif"
    if (!condition) {
      stop("hupsi, wrong arguments")
    }
    all_filepaths
  }

  subset_it_mock <- function(filepaths) {
    if (!(all(filepaths == all_filepaths))) {
      stop("hupsi, wrong arguments")
    }
    subset_filepaths
  }

  .read_and_clip_stars_mock <- function(filepaths, clip_layer) {
    if (!(all(filepaths == subset_filepaths) && clip_layer == 123)) {
      stop("hupsi, wrong arguments")
    }
    # if function only has side effects, nothing to return
  }

  mockery::stub(simplified_clip, "base::list_files", list_files_mock)
  mockery::stub(simplified_clip, "subset_it", subset_it_mock)
  mockery::stub(simplified_clip, ".read_and_clip_stars", .read_and_clip_stars_mock)

  expect_no_error <- purrr::partial(expect_error, regexp = NA)
  expect_no_error(simplified_clip("the-directory"))
})
