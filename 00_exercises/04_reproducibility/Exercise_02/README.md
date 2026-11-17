# Replication of Boulesteix et al. (2020)

This project reproduces the measurement error simulation in Boulesteix et al. (2020), using data from NHANES 2015–2016 (CDC/NCHS, 2015–2016).

## Project contents

- `simulation.qmd`: Quarto manuscript with the analysis, simulation, results and interpretation.
- `scripts/original_script.R`: original R code, unchanged.
- `scripts/setup_renv.R`: script to set up the R package environment.
- `data/raw/`: five NHANES data files in `.XPT` format.
- `references.bib`: bibliography for the manuscript.
- `renv.lock`, `.Rprofile` and `renv/`: files for restoring the R environment.

## Reproduce the study

Install R and Quarto, then open `research_compendium.Rproj` in RStudio.

To set up `renv` for the first time, run in the R console:

```r
source("scripts/setup_renv.R")
```

If `renv.lock` has already been created, restore the recorded package versions instead:

```r
renv::restore()
```

## References

Boulesteix, A.-L., et al. (2020). Introduction to statistical simulations in health research. *BMJ Open, 10*, e039921. https://doi.org/10.1136/bmjopen-2020-039921

Centers for Disease Control and Prevention, National Center for Health Statistics (CDC/NCHS). (2015–2016). *National Health and Nutrition Examination Survey (NHANES), 2015–2016.*
