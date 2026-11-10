# Measurement error simulation replication

Replication of Boulesteix et al. (2020), *Introduction to statistical simulations in health research* (BMJ Open, doi:10.1136/bmjopen-2020-039921).

## Contents

- `simulation.qmd`: simulation study, figure, results and interpretation.
- `data/raw/`: five NHANES 2015–2016 XPT files.
- `scripts/original_script.R`: supplied original code, unchanged.
- `scripts/functions.R`: data preparation and simulation functions.
- `scripts/setup_renv.R`: dependency setup and lockfile generation.
- `results/`: generated outputs.

## Reproduce

Open the project in RStudio with R and Quarto installed. Run:

```r
source("scripts/setup_renv.R")
renv::restore()
quarto::quarto_render("simulation.qmd", output_format = "html")
```

The default is 1,000 repetitions across 36 scenarios (36,000 regressions). For a quick test, set `N_SIM=10`, then unset it and run the full study. Rendering writes `results/scenario_summary.csv`, `results/simulation_results.rds`, and `results/simulation_figure.png`.

**Before final submission:** Run the setup script and commit the resulting `renv.lock` and `renv/activate.R`, then render the full R study and commit its outputs. R was unavailable in the initial construction environment, so these files have not yet been generated.

The empirical HbA1c reference coefficient is not a known population parameter. The confidence-interval reference-inclusion rate is exploratory and cannot be interpreted as 95% population coverage.

Raw data: CDC NHANES 2015–2016, provided for this course via https://github.com/mlarpis/markup/tree/main/documents/week-4/raw_data .
