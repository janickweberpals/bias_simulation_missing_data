generate_data <- function(
    seed = 42,
    # total simulated patients
    n_total = 10000,
    ## exposure
    X_prevalence = 0.68,
    ## Z2 (serum creatinine) distribution in exposed and unexposed
    Z2_mean_exposed = 0.82,
    Z2_sd_exposed = 0.23,
    Z2_mean_unexposed = 0.85,
    Z2_sd_unexposed = 0.23,
    # pevalence U in exposed and unexposed
    U_unexposed = 0.11,
    U_exposed = 0.20,
    # betas for outcome (HR scale)
    beta_X = log(1),
    beta_Z2 = log(5.16),
    beta_U = log(1.48)
    ){
  
  # Set the seed
  set.seed(seed)
  
  # Build the total cohort
  cohort_X_Z2_U <- tibble::tibble(
    X = rbinom(n = n_total, size = 1, prob = X_prevalence),
    Z2 = ifelse(
      X == 1, 
      rnorm(n = n_total, mean = Z2_mean_exposed, sd = Z2_sd_exposed),
      rnorm(n = n_total, mean = Z2_mean_unexposed, sd = Z2_sd_unexposed)
      ),
    U = ifelse(
      X == 1, 
      rbinom(n = n_total, size = 1, prob = U_exposed),
      rbinom(n = n_total, size = 1, prob = U_unexposed)
      ),
    c_ed = ifelse(
      X == 1, 
      rnorm(n = n_total, mean = 1, sd = 2),
      rnorm(n = n_total, mean = 1, sd = 3)
      ),
    c_gnrc_cnt = ifelse(
      X == 1, 
      rnorm(n = n_total, mean = 11, sd = 5),
      rnorm(n = n_total, mean = 10, sd = 5)
      ),
    c_flu_vaccine = ifelse(
      X == 1, 
      rbinom(n = n_total, size = 1, prob = 0.64),
      rbinom(n = n_total, size = 1, prob = 0.64)
      ),
    c_foot_ulcer = ifelse(
      X == 1, 
      rbinom(n = n_total, size = 1, prob = 0.046),
      rbinom(n = n_total, size = 1, prob = 0.024)
      ),
    c_glaucoma_or_cataract = ifelse(
      X == 1, 
      rbinom(n = n_total, size = 1, prob = 0.52),
      rbinom(n = n_total, size = 1, prob = 0.54)
      ),
    c_ischemic_stroke = ifelse(
      X == 1, 
      rbinom(n = n_total, size = 1, prob = 0.13),
      rbinom(n = n_total, size = 1, prob = 0.093)
      ),
    c_h2ra = ifelse(
      X == 1, 
      rbinom(n = n_total, size = 1, prob = 0.069),
      rbinom(n = n_total, size = 1, prob = 0.076)
      ),
    c_acei = ifelse(
      X == 1, 
      rbinom(n = n_total, size = 1, prob = 0.32),
      rbinom(n = n_total, size = 1, prob = 0.31)
      ),
    c_arb = ifelse(
      X == 1, 
      rbinom(n = n_total, size = 1, prob = 0.18),
      rbinom(n = n_total, size = 1, prob = 0.15)
      ),
    c_statin = ifelse(
      X == 1, 
      rbinom(n = n_total, size = 1, prob = 0.57),
      rbinom(n = n_total, size = 1, prob = 0.60)
      ),
    c_spironolocatone = ifelse(
      X == 1, 
      rbinom(n = n_total, size = 1, prob = 0.023),
      rbinom(n = n_total, size = 1, prob = 0.016)
      ),
    dem_age = ifelse(
      X == 1, 
      rnorm(n = n_total, mean = 76, sd = 8),
      rnorm(n = n_total, mean = 75, sd = 7)
      )
    )
  
  # assign betas for hazard model
  betas_os <- c(
    X = beta_X,
    Z2 = beta_Z2,
    U = beta_U,
    c_ed = log(1.04),
    c_gnrc_cnt = log(1.08),
    c_flu_vaccine = log(0.79),
    c_foot_ulcer = log(1.95),
    c_glaucoma_or_cataract = log(0.77),
    c_ischemic_stroke = log(1.47),
    c_h2ra = log(0.60),
    c_acei = log(1.36),
    c_arb = log(1.42),
    c_statin = log(0.82),
    c_spironolocatone = log(1.90),
    dem_age = log(1.05)
    )
  
  set.seed(seed)
  cohort <- cohort_X_Z2_U |> 
    bind_cols(
      simsurv::simsurv(
        dist = "exponential",
        lambdas = 0.0001,
        betas = betas_os,
        x = cohort_X_Z2_U,
        maxt = 10
      )
    ) |>  
    select(-id)
  
  # event-rate per 1000 person-years of follow-up
  # in original data: ~40 events per 1000 person-years
  event_rate_per_1000py <- round(sum(cohort$status)/sum(cohort$eventtime)*1000, 2)
  #event_rate_per_1000py
  
  return(cohort)
  
}