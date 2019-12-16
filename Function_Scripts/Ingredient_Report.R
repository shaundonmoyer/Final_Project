# Ingredient Report Function

ing_report <- function(ingredient){
  
  
  ing_name <- paste(ingredient)
  
  
  ing_summary <- new_RUI %>%
    
    filter(IngredientName == ing_name) %>%
    
    summarize(MeanWtPercent = mean(PercentHFJob, na.rm = TRUE), Minimum = min(PercentHFJob, na.rm=TRUE), Maximum = max(PercentHFJob, na.rm = TRUE), Count = n(), Quan10 = quantile(PercentHFJob, .1, na.rm = TRUE), Quan30 = quantile(PercentHFJob, .3, na.rm =TRUE), Quan50 = quantile(PercentHFJob, .5, na.rm = TRUE), Quan80 = quantile(PercentHFJob, .8, na.rm = TRUE))
  
  names(ing_summary)[names(ing_summary) == "MeanWtPercent"] <- "Mean Wt %"
  names(ing_summary)[names(ing_summary) == "Quan10"] <- "10th Percentile"
  names(ing_summary)[names(ing_summary) == "Quan30"] <- "30th Percentile"
  names(ing_summary)[names(ing_summary) == "Quan50"] <- "50th Percentile"
  names(ing_summary)[names(ing_summary) == "Quan80"] <- "80th Percentile"
  
  table_title <- paste("Ingredient Summary Report for", ing_name)
  
  new_table <- ing_summary %>%
    kable(digits = 10, caption = table_title, booktabs = TRUE) %>%
    kable_styling()
  
  return(new_table)
  
}