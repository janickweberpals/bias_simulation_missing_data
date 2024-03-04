# performs propensity score analysis on
# multiple imputed dataset

# treatment effect estimates after matching are estimated using Cox PH regression
# as described here: https://kosukeimai.github.io/MatchIt/articles/estimating-effects.html#survival-outcomes

ps_analysis_mids <- function(data = NULL, # complete dataset or imputed datasets/mids object
                             seed = i
                             ){
  
  # ps formula
  ps_fit <- as.formula(X ~ Z2 + U)
  
  if(any(class(data) == "mids")){
    
    # 1:1 nearest neighbor matching without replacement
    # with propensity score calculated
    # using logistic regression
    # and a caliper of 20% of the standard deviation of the propensity score
    set.seed(seed)
    ps_matched_datasets <- MatchThem::matchthem(
      formula = ps_fit,
      datasets = data,
      ratio = 1,
      approach = "within",
      method = "nearest",
      distance = "glm",
      link = "logit",
      caliper = 0.2,
      replace = F
      )
  
  # balance check
  # cobalt::love.plot(ps_matched_datasets, thresholds = .1)
  
  # outcome regression on matched datasets
  # For Cox models, coxph() will produce correct 
  # standard errors when used with weighting but 
  # svycoxph() will produce more accurate 
  # standard errors when matching is used.
    
  # in MatchThem/mice, the function <pool()> uses the robust
  # standard error estimate for pooling when it can extract
  # <robust.se> from the <tidy()> object.
  # https://github.com/amices/mice/blob/master/R/pool.R#L82C4-L84C51
  # https://github.com/FarhadPishgar/MatchThem/blob/master/R/pool.R#L119
  ps_matched_results <- with(
    data = ps_matched_datasets,
    expr = survival::coxph(formula = survival::Surv(eventtime, status) ~ X,
                           weights = weights, 
                           cluster = subclass, 
                           robust = TRUE
                           )
    )
  
  # pool results using Rubin's rule
  final_ps_matched_result <- MatchThem::pool(ps_matched_results) |> 
    broom::tidy(exponentiate = TRUE, conf.int = TRUE)
  
  }else{ # analysis with complete dataset ("true") or complete case analysis (removing patients with NA)
    
    # for single "ground truth" complete dataset we use MatchIt package/function
    set.seed(seed)
    ps_matched_out <- MatchIt::matchit(
      formula = ps_fit,
      data = na.omit(data), # remove missing cases in case of complete case analysis
      ratio = 1,
      method = "nearest",
      distance = "glm",
      link = "logit",
      caliper = 0.2,
      replace = F
      )
    
    # extract matched data
    ps_matched_dataset <- MatchIt::match.data(ps_matched_out)
    
    final_ps_matched_result <- survival::coxph(
      formula = survival::Surv(eventtime, status) ~ X, 
      data = ps_matched_dataset,
      weights = weights, 
      cluster = subclass, 
      robust = TRUE
      ) |> 
      broom::tidy(exponentiate = TRUE, conf.int = TRUE)
    
  }
  
  return(final_ps_matched_result)
  
}