generate_NA_discrete <- function(
    seed = 42,
    data = NULL,
    prop = 0.5,
    pattern = NULL,
    weights = NULL,
    odds = NULL
    ){
  
  set.seed(seed)
  ampute_return <- mice::ampute(
    data = data,
    prop = prop,
    mech = "MAR",
    patterns = pattern,
    weights = weights,
    bycases = TRUE,
    cont = FALSE,
    odds = odds
    )
  
  return(ampute_return)
  
}