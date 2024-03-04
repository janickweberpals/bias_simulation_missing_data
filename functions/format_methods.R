# function to format method labels

# this function takes input data
# in form of "results dataframe' object
# in LONG format (Pivot_long)
# and properly labels imputation methods
# for plotting and visualization
format_methods <- function(data = NULL # dataset including "method" column
                           ){
  
  assertthat::assert_that("method" %in% names(data), msg = "<data> does not contain a 'method' column")
  
  # create a clean imputation name for plotting
  # order by ad-hoc, parametric, non-parametric
  data <- data |> 
    dplyr::mutate(
      method = factor(
        method,
        levels = c(
          "Unadjusted",
          "Complete case", 
          "Imputed"
          )
        )
      )
  
  return(data)
  
}

