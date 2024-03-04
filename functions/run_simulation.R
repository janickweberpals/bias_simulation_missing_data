run_simulation <- function(
  i,
  n_total = 2500,
  prop = 0.5,
  pattern = NULL, # order is X, Z2, U, eventtime, status
  weights = NULL, # order is X, Z2, U, eventtime, status
  type = NULL,
  odds = NULL
  ){
  
  # data generating step
  source(here::here("functions", "generate_data.R"))
  data <- generate_data(
    seed = i, 
    n_total = n_total
    )
  
  # impose missingness
  if(is.null(type) & !is.null(odds)){
    
    source(here::here("functions", "generate_NA_discrete.R"))
    
    ampute_miss <- generate_NA_discrete(
      seed = i,
      data = data,
      pattern = pattern,
      weights = weights,
      odds = odds,
      prop = prop
      )
    
  }else if(is.null(odds) & !is.null(type)){
    
    source(here::here("functions", "generate_NA_cont.R"))
    
    ampute_miss <- generate_NA_cont(
      seed = i,
      data = data,
      pattern = pattern,
      weights = weights,
      type = type,
      prop = prop
      )
    
  }else{
    
    stop("Either both or none of <odds> and <type> are specified. Just choose one at a time.")
    
  }
  
  # unadjusted
  results_unadjusted <- survival::coxph(
    formula = survival::Surv(eventtime, status) ~ X, 
    data = ampute_miss$amp
    ) |> 
    broom::tidy(exponentiate = TRUE) |> 
    dplyr::mutate(method = "Unadjusted") |> 
    dplyr::select(method, estimate, se = std.error)
  
  # propensity score models
  source(here::here("functions", "ps_analysis_mids.R"))
  
  ## complete case
  results_cc <- ps_analysis_mids(
    data = na.omit(ampute_miss$amp), 
    seed = i
    ) |> 
    dplyr::mutate(method = "Complete case") |> 
    dplyr::select(method, estimate, se = robust.se)
  
  ## imputation (pmm)
  set.seed(i)
  mids_data <- mice::mice(
    data = ampute_miss$amp,
    method = "pmm",
    m = 10,
    seed = i,
    print = FALSE
    )
  
  results_imputed <- ps_analysis_mids(
    data = mids_data, 
    seed = i
    ) |> 
    dplyr::mutate(method = "Imputed") |> 
    dplyr::select(method, estimate, se = std.error)
  
  results <- rbind(
    results_unadjusted,
    results_cc,
    results_imputed
    ) |> 
    mutate(replicate = i)
  
  return(results)
  
}