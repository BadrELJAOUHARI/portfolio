# Run once from the compendium root to create renv.lock.
if (!requireNamespace("renv", quietly = TRUE)) install.packages("renv")
if (!file.exists("renv.lock")) {
  renv::init(bare = TRUE)
}
renv::install(c("haven", "ggplot2", "knitr", "rmarkdown", "quarto"))
renv::snapshot(prompt = FALSE)
cat("Environment saved in renv.lock. Commit renv.lock and renv/activate.R.\n")
