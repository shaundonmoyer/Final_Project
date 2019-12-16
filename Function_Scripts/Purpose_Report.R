#Purpose Report Function

purpose_report <- function(purpose){
  
  if (!is.character(purpose)) {
    stop("Purpose must be a character vector.")
  }
  
  
  data <- RUP[which(RUP$Purpose == purpose), "TradeName" ]
  count_data <- data %>% 
    count(TradeName, sort = TRUE)
  count_data <- count_data[c(1:10), ]
  
  plot_title <- paste("10 most used", purpose, "in FracFocus")
  New_Plot <- ggplot(count_data, aes(x=TradeName, y=n)) + geom_bar(stat="identity", color="blue",fill="white") + 
    labs(x="TradeName", y="Frequency",title=plot_title) +geom_text(aes(label=n), vjust=1.6, color="black", size=3.5)+theme(axis.text.x=element_text(size=10,angle=45,hjust=1,vjust=1))
  
  New_Plot
}