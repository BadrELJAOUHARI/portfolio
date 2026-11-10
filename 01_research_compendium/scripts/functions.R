# Helper functions for the Boulesteix et al. replication.

read_nhanes <- function(path = "data/raw") {
  files <- c("DEMO_I.XPT", "BPX_I.XPT", "BMX_I.XPT", "GHB_I.XPT", "TCHOL_I.XPT")
  vars <- list(
    c("SEQN", "RIAGENDR", "RIDAGEYR"),
    c("SEQN", "BPXSY1"),
    c("SEQN", "BMXBMI"),
    c("SEQN", "LBXGH"),
    c("SEQN", "LBDTCSI")
  )
  data <- lapply(seq_along(files), function(i) {
    file <- file.path(path, files[i])
    stopifnot(file.exists(file))
    x <- as.data.frame(haven::read_xpt(file))
    x[vars[[i]]]
  })
  d <- Reduce(function(x, y) merge(x, y, by = "SEQN"), data)
  d$age <- d$RIDAGEYR
  d$age[d$age < 18] <- NA_real_
  d$sex <- d$RIAGENDR
  d$bp <- d$BPXSY1
  d$bmi <- d$BMXBMI
  d$HbA1C <- d$LBXGH
  d$chol <- d$LBDTCSI
  d[complete.cases(d[c("age", "sex", "bmi", "HbA1C", "bp")]), ]
}

run_simulation <- function(dc, scenarios, repetitions, reference) {
  # Same scenario order and per-repetition seed as the original script.
  var_exp <- var(dc$HbA1C)
  var_conf <- var(dc$bmi)
  n <- nrow(dc)
  estimates <- matrix(NA_real_, repetitions, nrow(scenarios))
  reference_inside_ci <- matrix(NA, repetitions, nrow(scenarios))

  for (k in seq_len(repetitions)) {
    set.seed(k)
    for (i in seq_len(nrow(scenarios))) {
      var_me_exp <- var_exp * scenarios$me_exp[i] / (1 - scenarios$me_exp[i])
      var_me_conf <- var_conf * scenarios$me_conf[i] / (1 - scenarios$me_conf[i])

      dc$HbA1C.me <- dc$HbA1C + rnorm(n, 0, sqrt(var_me_exp))
      dc$bmi.me <- dc$bmi + rnorm(n, 0, sqrt(var_me_conf))
      fit <- lm(bp ~ HbA1C.me + age + bmi.me + as.factor(sex), data = dc)
      estimate <- coef(fit)["HbA1C.me"]
      se <- summary(fit)$coefficients["HbA1C.me", "Std. Error"]
      margin <- qt(0.975, df.residual(fit)) * se
      estimates[k, i] <- estimate
      reference_inside_ci[k, i] <- (estimate - margin <= reference) &&
        (reference <= estimate + margin)
    }
  }
  list(estimates = estimates, reference_inside_ci = reference_inside_ci)
}

summarise_simulation <- function(sim, scenarios, reference) {
  data.frame(
    me_exp_pct = 100 * scenarios$me_exp,
    me_conf_pct = 100 * scenarios$me_conf,
    estimate = colMeans(sim$estimates),
    bias_from_reference = colMeans(sim$estimates) - reference,
    mc_sd = apply(sim$estimates, 2, sd),
    reference_inclusion_rate = colMeans(sim$reference_inside_ci)
  )
}
