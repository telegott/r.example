simplified_clip <- function(directory_input, ...) {
  # ... check inputs ...
  filepaths <- list.files(
    directory_input,
    full.names = TRUE,
    recursive = TRUE,
    pattern = "mohp_europe_*.*tif"
  )
  clip_layer <- 123
  filepaths_subset <- subset_it(filepaths)
  # test .read_and_clip_stars separately, not here, just check it gets correct things
  .read_and_clip_stars(filepaths_subset, clip_layer)
}

subset_it <- function(filepaths) {
  stop("Does not need to be implemented for this example")
}

.read_and_clip_stars <- function(filepaths_subset, clip_layer) {
  stop("Does not need to be implemented for this example")
}