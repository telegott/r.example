# r.example


# Initial manual steps to get to this starting point

- In this folder's parent, run in R: `usethis::use_package("r.example")`. No `renv` involved yet, `usethis` must be available globally via `install.packages`.

All following commands in the package folder in R.

Add basic development-only packages:
    
- `usethis::use_package("usethis", type = "Suggests")`
- `usethis::use_package("devtools", type = "Suggests")`. Only now install `renv`, otherwise you can't use `usethis` if it's not there before, your `renv` does not "see" the global R packages. 

Make sure `renv` is installed globally, then:

- `usethis::use_package("testthat")`
- `usethis::use_package("styler")`
- `usethis::use_package("lintr")`
- `usethis::use_package("covr")`
- `usethis::use_github_actions()`

On GitHub, 
- under settings/Options make sure that in the section "Merge Button", only "Allow squash merging" is active. Also check "Automatically delete head branches"
- under settings/Branches click add "Add rule" enter "main" under "Branch name pattern" and check "Require a pull request before merging " and "Require status checks to pass before merging"

