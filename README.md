# r.example


# Initial manual steps to get to this starting point

- In this folder's parent, run in R: `usethis::use_package("r.example")`. No `renv` involved yet, `usethis` must be available globally via `install.packages`.

All following commands in the package folder in R.

Add basic development-only packages:
    
- `usethis::use_package("usethis", type = "Suggests")`
- `usethis::use_package("devtools", type = "Suggests")`. Only now install `renv`, otherwise you can't use `usethis` if it's not there before, your `renv` does not "see" the global R packages. 

Make sure `renv` is installed globally, then:

- `usethis::use_testthat()`
- `usethis::use_package("styler")`
- `usethis::use_package("lintr")`
- `usethis::use_package("covr")`
- `usethis::use_github_actions()`
- `renv::snapshot(type="explicit")`

On GitHub, 
- under settings/Options make sure that in the section "Merge Button", only "Allow squash merging" is active. Also check "Automatically delete head branches"
- under settings/Branches click add "Add rule" enter "main" under "Branch name pattern" and check "Require a pull request before merging " and "Require status checks to pass before merging"

Then push your changes on a new branch.



Workflows:
- _Never_ install the package locally!
- To add a package, use `usethis::use_package`, _don't_ use `renv::install`. The `DESCRIPTION` file is the source of truth.
- After the `DESCRIPTION` file has new packages, do `renv::snapshot(type = "explicit")`, _not_ `renv::snapshot()`.
- To automatically style your files do `styler::style_pkg()`
- To generate a test coverage report do `covr::report()`
- Never do `source()` or `library()`. After `devtools::load_all()`, all code is in the workspace in the newest version.
- If you need functions from other packages, use `@import` or `importFrom` comments. Do `devtools::document()` after such changes to automatically adapt the `NAMESPACE` file which handles what your package sees from the outer world and what's available from your package to the outer world.
- All files in `R/` should have an equivalent in 