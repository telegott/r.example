# r.example


## Initial manual steps to get setup the starting point

Alternatively, clone and run `renv::restore()`

- In this folder's parent, run in R: `usethis::use_package("r.example")`. No `renv` involved yet, `usethis` must be available globally via `install.packages`.

All following commands in the package folder in R.

Add basic development-only packages:
    
- `usethis::use_package("usethis", type = "Suggests")`
- `usethis::use_package("devtools", type = "Suggests")`. Only now install `renv`, otherwise you can't use `usethis` if it's not there before, your `renv` does not "see" the global R packages. 

Make sure `renv` is installed globally, then:

- `usethis::use_mit_license()` (or something else)
- `usethis::use_testthat()`
- `usethis::use_package("styler")`
- `usethis::use_package("lintr")`
- `usethis::use_package("covr")`
- `usethis::use_package("htmltools")`
- `usethis::use_package("DT")`
- `usethis::use_github_actions()`
- `renv::snapshot(type="explicit")`

Adapt the `R-CMD-check.yaml` to the state of this repository. This file is used for continuous integration, meaning that if you create a pull request, Github builds a linux "computer", installs linux libraries required for packages, installs R and the packages and checks your package. Only if you get a green check, you should be able to merge the pull request. That means your `main` branch is always in a workign state. If you add libraries such as `sf` that need system geo libraries, make sure to include these in the appropriate section of the `R-CMD-check.yml` in the linux package section so the "computer" on Github also installs these.

On GitHub, 
- under settings/Options make sure that in the section "Merge Button", only "Allow squash merging" is active. Also check "Automatically delete head branches"
- under settings/Branches click add "Add rule" enter "main" under "Branch name pattern" and check "Require a pull request before merging " and "Require status checks to pass before merging"

Then push your changes on a new branch.

Workflows:
- building the packages add _everything_ in your package directory to your build process. Exclude _everything_ that's not needed for that to the `.Rbuildignore` (be aware it has a stricter syntax than other ignore-files, check examples).
- _Never_ install the package locally from within the package folder! If you need to have the functionality available in another local package, that other package should install it from Github.
- To add a package, use `usethis::use_package`, _don't_ use `renv::install`. The `DESCRIPTION` file is the source of truth.
- After the `DESCRIPTION` file has new packages, do `renv::snapshot(type = "explicit")`, _not_ `renv::snapshot()`.
- To automatically style your files do `styler::style_pkg()`.
- To generate a test coverage report do `covr::report()`.
- To run the tests locally, call `devtools::test()`
- Never do `source()` or `library()`. After `devtools::load_all()`, all code is in the workspace in the newest version.
- If you need functions from other packages, use `@import` or `@importFrom` comments. Do `devtools::document()` after such changes to automatically adapt the `NAMESPACE` file which handles what your package sees from the outer world and what's available from your package to the outer world.
- All files in `R/` should have an equivalent in `tests/testthat`, e.g. `R/helpers.R` corresponds to `tests/testthat/test-helpers.R` and an individual `test_that` call to test individual functions in that file.
- The `.R` file where a function is defined has no influence on how it is available in your package. Everything in every `.R` file in the `R/` directory is available when the package is loaded. (Note that in the background, loading the package means sourcing the `.R` files alphabetically, so if you have a function `do_something()` defined in `a.R` and `b.R`, you should end up with the version in `b.R`).
- If you don't need functions from other packages often, use the `package::function()` notation, e.g. `dplyr::mutate` (bad example). If you need single functions often, use `@importFrom` comments. If you need the whole package all the time, use `@import`, but this can clutter your namespace. What you put in the comments above function `a` is _also_ available to function `b`, it is _not_ bound to the function, so pay attention to not import unnecessary functions. The `package::function` notation does not affect the `NAMESPACE` file.