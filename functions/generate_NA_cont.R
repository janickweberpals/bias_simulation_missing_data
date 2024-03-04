generate_NA_cont <- function(
    seed = 42,
    data = NULL,
    prop = 0.5,
    pattern = NULL,
    weights = NULL,
    type = "RIGHT"
    ){
  
  set.seed(seed)
  ampute_return <- mice::ampute(
    data = data,
    prop = prop,
    mech = "MAR",
    patterns = pattern,
    weights = weights,
    bycases = TRUE,
    type = type
    )
  
  return(ampute_return)
  
}