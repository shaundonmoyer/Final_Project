# Manipulating FracFocus Data using R

Hydraulic fracking fluids are large solutions of chemicals used for recovering oil and gas in unconventional shale plays. The overall usage of specific chemicals in the industry is poorly understood by researchers, however a large database hosted by [Fracfocus.org](http://fracfocus.org/) reports hydraulic fracking fluid compositions in a manner that is unorganized and hard to sort through. The objective of this project is to develop a script in R to query data from the Fracfocus registry to report on specific hydraulic fracking chemicals used by the industry. The script will also be used to perform statistal analysis on specific ingredients to help understand which ingredients the industry as a whole is preferring to use along with the specific concentrations of chemicals used during a hydraulic fracturing job. 

## Getting Started

The following information will provide you with the proper software and data needed to replicate this project along with detailed instructions.

### Prerequisites 

For this project the following software and data are needed:

* R
* RStuido
* Backup and restored version of the FracFocus Registry Database
* SQL Server Managment Studio (SSMS)


### Installing and Downloading R and Rstudio

To get started with this project you will need to download and install R and Rstudio. R is a free open source programming language and Rstudio is the integrated environment that allows code to be written and executed. To download and install the latest version of R click [Here](https://www.r-project.org/) and Rstudio click [Here](https://rstudio.com/) for your operating system.



### Downloading and Restoring FracFocus Database

A replica database of the entire FracFocus registry is available for download as a backup file [Here](http://fracfocus.org/data-download). This data is updated the 15th of every month with the most recent disclosures. The download will contain a backup version of the Microsoft SQL Server 2012 database that provides the same information available through the FracFocus website. Once the database is downloaded, it must be restored (from its backup version to a useable file) using a SQL Server Managment Studio application. FracFocus includes detailed instructions [Here](http://fracfocus.org/sites/default/files/file-attachments/fracfocus-sqltoexcel.pdf) on how to restore the backup database. In general, restoring the database includes importing the backup file into the SQL Server Management Stuido application and manipulating it by following the specific instructions linked above.

Since the backup database was created using Microsoft SQL 2012, it is recommended that the 2012 edition of SQL Server Managment Studio is used to restore the database. To download and install the proper edition of SSMS, follow the instructions found in the Obtaining SSMS section below. 


### Obtaining SSMS (SQL Server Management Studio)

SSMS is an integrated environment for managing any SQL infrastructure. SSMS provides tools to configure, monitor
and produce/host instances of an SQL server and databases. To download the 2012 edition of Microsoft Management Studio needed to restore the database click [Here](https://www.microsoft.com/en-us/download/details.aspx?id=29062). Please note that you must choose the 1.3GB SQLEXPRADV option.


#### Structure of the FracFouc Database

Now that the database is restored and is located in the SSMS application, it is important to understand how the data is stored. Every disclosure in FracFocus is composed of three different components all of which are stored in three different tables. 

The tables are located on the left side of the SSMS application:

![SSMS Tables](Final_Proj_Images/SSMS_Table_SC.JPG)

The tables that you will find in the restored FracFocus database include:

* RegistryUpload – This table contains each disclosure’s header information such as the job date, API number, location, base water volume, and total vertical depth.

* RegistryUploadPurpose – This table contains each disclosure’s additive names, suppliers, and the purposes for the additives used.

* RegisryUploadIngredients – This table contains each disclosure’s chemical information, where available, such as the CAS number and the maximum percentages in which they are found in the additive and job.

Using the SSMS application you can perform simple queries to sort through the extenisve FracFoucs registry. 

For example: To obtain all the disclosures that contain the ingredient "Acetic Acid" use the line of code below.

```
SELECT * FROM [FracFocusRegistry].[dbo].[RegistryUploadIngredients] WHERE IngredientName = 'Acetic Acid'
```
Result of example above:

![Query SC](Final_Proj_Images/Query_SC.JPG)

The above line of SQL code simply calls the RegistryUploadIngredients table and selects on the results where "Acetic Acid" is matched in the IngredientName column. The same syntax can be applied to query any specific data from any of the three data tables available in the FracFocus Registry.

## Connecting R to SSMS

Querying data in SSMS is simple and straight forward, however manipulation of data is not. This is when applying R to your data becomes useful. 

First we will need a package that will allow the connection to an Open Database Driver. The SSMS application is an Open database driver and the following package will be needed in R.

```
install.packages("odbc")
library(odbc)
```
Now we can use the dbConnect function in this package to connect R to our SSMS application. 

```
con <- dbConnect(odbc(),Driver="SQL Server",Server="your_server_name", Database="FracFocusRegistry", Trusted_Connection="True")
```

For this function you will need to provide the server name in which you are hosting the SSMS application (varies by setup of the SSMS application) and then the database in which you would like to connect to. In our case the database we want to connect to is the "FracFocusRegistry". Once the connection is successful you will see a connection in the Connections tab in the upper right corner of Rstudio.

![R Connection](Final_Proj_Images/Connecntion_SC.JPG)


Now that a connection has been established to the FracFoucsRegistry in R through the SSMS application, we can now call in data from the FracFoucsRegistry directly into R. This can be done using the "dbGetQuery" function from the odbc package. This function uses the connection made from above, inconjuction with the SQL syntax you would use to query data in the SSMS application. Referring back to the 'Acetic Acid' query earlier, to bring those results into R as a data table the following code can be used.


First install the "data.table" package

```
install.packages("data.table")
library(data.table)
```

Next, call the connection to the database (previously "con") followed by the same SQL syntax used to query the data in SSMS.

```
AceticAcid <- data.table(dbGetQuery(con, "SELECT * FROM RegistryUploadIngredients Where IngredientName = 'Acetic Acid';"))
```

The same results we yielded earlier as a query in the SSMS application, is now a data table in your global environment in R. The dbGetQuery function allows you to query data directly from your SSMS and allocate the data into R.


## Creating Functions to summarize and manipulate FracFocus data

### Purpose report function

One of the main objectives of this project is to get an understanding of what ingredients the industry is using in their hydraulic fracturing fluids. To do this data from the RegistryUploadPurpose table was used. This table lists an ingredients "TradeName" or name used in industry along with the purpose this ingredient serves. A function was developed in which a specific purpose can be reported on that includes the 10 most used "TradeNames" associated with that purpose.

To do this, first the entire RegistryUploadPurpose table was brought into R and formatted as a data table.

```
RUP <- data.table(dbGetQuery(con, "SELECT * FROM [FracFocusRegistry].[dbo].[RegistryUploadPurpose]"))
```
Next a function was created that in summary, compiles all data that matches the Purpose wanted. Then the function counts how many times a TradeName is repeated for that specific purpose, sorts the TradeNames in descending order and then retrieves only the top 10 results. The function ends by plotting the results nicely in a bar graph.

```
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
```
Usage

```
purpose_report("enter purpose here")
```


An example of a plot created from the Purpose Report Function can be seen below:


```
purpose_report("Breaker")
```


![Breaker Plot](Final_Proj_Images/Breaker_Plot.jpeg)


The above plot yeilds the 10 most used Breakers reported in the FracFocus registry. We can see that the "Vicon NF Breaker" is the most reported Breaker as it is disclosed over 8600 times. This function can be used to report on any ingredient purpose (Sclaing Inhibitor, Friction Reducer, Biocide, Gelling Agent, etc...).


### Ingredient report function

The next objective of this project is to understand the composition of an ingredient being used in a hydraulic fracturing job. To do this data from the RegistryUploadIngredient table was used. This table contains a column of data that reports the weight percentage of an ingredient that was used for one disclosure of a hydraulic fracturing job. This column of data is named PercentHFJob in the RegistryUploadIngredient table. A function was created that can summarize the usage of any ingredient.

First, the RegistryUploadIngredient table was brought into R this time only selecting the "IngredientName" and "PercentHFJob" columns.

```
RUI <- data.table(dbGetQuery(con, "SELECT [IngredientName],[PercentHFJob] FROM [FracFocusRegistry].[dbo].[RegistryUploadIngredients]")
```

Then data was filtered to exclude values in the PercentHFJob column that are equal to 0 and greater than 30. A value of 0 was excluded from the dataset so a "true" minimum value could be retrieved. Also, values exceeding 30 weight percent were excluded because values over 30 weight percent are unrealistic for our research needs. 

```
new_RUI <- RUI %>%
  
  filter(PercentHFJob != "0", PercentHFJob < "30")
```

Finally a function was developed that in summary, compliles all values from the PercentHFJob column that match the ingredient name of interest that is entered into the function. The function then performs anlaysis that reports the mean weight percentage, minimum value, maximum value, a series of percentiled vaules and finally counts how many data points (entries for the specific ingredient) that were used to calculate these values. The function then reports this data in a data table.

```
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
```

Usage:

```
ing_report("name of ingredient")
```

An example of a table created from the ingredient report function can be seen below.

```
ing_report("Ammonium Persulfate")
```

![AMPSF Table](Final_Proj_Images/Persulfate_Plot.jpeg)

We can see from the figure produced by the function that the mean weight percent of Ammonium Persulfate in a hydraulic fracturing job is 0.009% with a maximum value of 2.87%. Over 26,000 entries of Ammonium Persulfate were used to calculate these values. Any ingredient (Acetic Acid, Hydrochloric Acid, Soidum Chloride, etc...) that is used in a hydraulic fracturing fluid solution can be entered into this function for a summary report.

## Deployment/Usage

The results of these functions are applicable for focusing research efforts in the field of hydraulic fracturing. The purpose report function is extremly useful when considering what ingredients are popular in the industry. We can now simply search the most frequently reported TradeName (produced from the purpose report function) online and in most cases the operator of that ingredient will supply additonal information. For example, we can see above that the most disclosed breaker reported in the FracFocus registry is the Vicon NF Breaker. A google search yields this breaker was synthesized by Halliburton and a suite of other information is available on this specific breaker. When considering the ingredient report function, this is primarily applicable to my research. My research includes synthesizing batches of hydraulic fracturing fluid for various fluid rock experiments. When changing the concentration of an ingredient in my fracturing fluid, I can now use this function to see what concentrations a specific ingredient is being used in the industry. This makes designing future experiments much easier and more streamlined.

## Authors

Original work by:

* Shaun Donmoyer (sjd0035@mix.wvu.edu)


## Acknowledgments

I would like to thank Dr. Hessl for help trouble shooting code and support during this project. I would also like to thank my IsoBioGem lab members for suggestions and inspiration for this project.
