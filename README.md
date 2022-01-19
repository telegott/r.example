# r.example


# Initial manual steps to get to this starting point

- In this folder's parent, run in R: `usethis::use_package("r.example")`. No `renv` involved yet, `usethis` must be available globally via `install.packages`.
All in the package folder in R:
Add basic development-only packages:
    
- `usethis::use_package("usethis", type = "Suggests")`
- `usethis::use_package("devtools", type = "Suggests")`. Only now install `renv`, otherwise you can't use `usethis` if it's not there before, your `renv` does not "see" the global R packages. 
