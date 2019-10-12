# Final Project Proposal

## Objectives
Hydraulic fracking fluids are large solutions of chemicals used for recovering oil and gas in unconventional shale plays. The overall usage of specific chemcials in the industry is poorly understood by researchers, however a large database hosted by Fracfocus.org reports hydraulic fracking fluids compositions in a manner that is unorganized and hard to sort through. The objective of this project is to develop a script in R to query data from the Fracfoucs registry to report on specific hydraulic fracking fluids used by the industry. The script will also be used to perform statistal analysis on specific ingredients to help understand which ingredients the industry as a whole is preferring to use. The script will be developed to report data from West Virginia specifically on Oxidizers in fracking fluids, however the code will be able to work for any ingredient or area that is reported in the database.

## Data sources
The data source that will be used in this project is from an SQL database hosted by Fracfocus.org and can be downloaded [Here](http://fracfocus.org/data-download). Fracfocus.org is a public repository that hosts information on hydrualic fracking fluids from public disclosures. The database that fracfocus uses is an SQL database and can be locally downloaded as a backup database (or .bak file). The backup database can then be restored using an SQl Server Management Studio application. Once the database is restored, multiple packages in R can be used to query from this database.

## Languages Used
The coding language that will be used for this project is R. An application (SQL Server Management Studio) will be used in the data restoration process.

## Implementation
I will use R to develop a working script to pull data on any given hydraulic fracking fluid ingredient that is listed in the Fracfoucs database. Hydraulic fracking fluids are divided into categorires based on usage (oxidizer, geling agent, friction reducer etc.) Further, each category may contain various ingredients for each usage. The script will work by pulling information on a given category and will be able to report statistics on the ingredients such as which ingredient is most used, least used and mean concentration (weight % in the frackig fluid). 

## Expected Products
The expected products from this project is data tables or charts that represent usage on the ingredients from each category. Also, data tables for any specific ingredient could be made. I am interested in the category oxidizers (also known as breakers) and expect to make a data table that represents which oxidziers are most used in the state of West Virginia and at which concentrations these oxidizers are being used at by the industry.

## Questions for insturctor

Which packages are going to be the most useful R?

I have done some reading and tried following the information provided [Here](https://db.rstudio.com/getting-started/database-queries/) with little luck. I am having trouble connecting R to the database I restored.

Some additional resources I have found useful include:

  *[Here](https://datacarpentry.org/R-ecology-lesson/05-r-and-databases.html)
  *[Here](https://db.rstudio.com/)
  
Do you have any other resources that may be useful for me to read?
