# Run once from the compendium root. Do not include this setup in the QMD.
if (!requireNamespace("renv", quietly = TRUE)) install.packages("renv")
renv::init(bare = TRUE)
renv::install(c("Hmisc", "mice", "tidyverse", "knitr", "rmarkdown"))
renv::snapshot(prompt = FALSE)
