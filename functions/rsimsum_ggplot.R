rsimsum_ggplot <- function(tidy_simsum = NULL, metric = c("rmse", "bias", "coverage", "empse", "variance")){
  
  # call format function
  source(here::here("functions", "format_methods.R")) 
  
  tidy_simsum <- tidy_simsum |> 
    dplyr::group_by(simulation)
  
  if(metric == "rmse"){
    
    tidy_simsum_metric <- tidy_simsum |> 
      dplyr::filter(stat == "mse") |> 
      # take sqrt to get RMSE from MSE
      dplyr::mutate(
        est = sqrt(est),
        lower = sqrt(lower),
        upper = sqrt(upper)
        ) |> 
      dplyr::mutate(stat = "rmse")
    
    y_label <- "Root mean square error (RMSE)" 
    y_intercept <- NULL
    
    
  }else if(metric == "bias"){
    
    tidy_simsum_metric <- tidy_simsum |> 
      dplyr::filter(stat == "bias")
    
    y_label <- "Bias" 
    y_intercept <- ggplot2::geom_hline(yintercept = 0, linetype = "dashed", color = "forestgreen")
    
  }else if(metric == "coverage"){
   
    tidy_simsum_metric <- tidy_simsum |> 
      dplyr::filter(stat == "cover")
    
    y_label <- "Coverage" 
    y_intercept <- NULL
    
  }else if(metric == "empse"){
    
    tidy_simsum_metric <- tidy_simsum |> 
      dplyr::filter(stat == "empse")
    
    y_label <- "Empirical standard error" 
    y_intercept <- NULL
    
  }else if(metric == "variance"){
      
    tidy_simsum_metric <- tidy_simsum |> 
      dplyr::filter(stat == "se2mean")
    
    y_label <- "Variance" 
    y_intercept <- NULL
    
    }
  
  plot <- tidy_simsum_metric |> 
    format_methods() |> 
    ggplot2::ggplot(ggplot2::aes(x = method, y = est)) +
    ggplot2::geom_point() +
    ggplot2::geom_errorbar(ggplot2::aes(ymin = lower, ymax = upper)) +
    ggplot2::labs(
      y = y_label
      ) +
    ggplot2::theme_bw() +
    ggplot2::theme(
      axis.title.x = element_blank(),
      axis.text.x = element_text(angle = 35, vjust = 1, hjust=1),
      text = element_text(size = 13)
      ) +
    ggplot2::facet_wrap(~simulation) +
    y_intercept
    
  # store table
  tidy_simsum_table <- tidy_simsum_metric |> 
    format_methods() |>
    dplyr::arrange(method) |> 
    dplyr::select(method, est, lower, upper, simulation) |> 
    dplyr::mutate(dplyr::across(dplyr::where(is.numeric), ~round(.x, 3)))
  
  return(
    list(
      plot = plot,
      table = tidy_simsum_table
      )
    )
  
}
