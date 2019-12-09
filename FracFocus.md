# Manipulating FracFocus Data using R

Hydraulic fracking fluids are large solutions of chemicals used for recovering oil and gas in unconventional shale plays. The overall usage of specific chemicals in the industry is poorly understood by researchers, however a large database hosted by [Fracfocus.org](http://fracfocus.org/) reports hydraulic fracking fluids compositions in a manner that is unorganized and hard to sort through. The objective of this project is to develop a script(s) in R to query data from the Fracfocus registry to report on specific hydraulic fracking chemicals used by the industry. The script(s) will also be used to perform statistal analysis on specific ingredients to help understand which ingredients the industry as a whole is preferring to use along with the concentrations these chemicals are used during a hydraulic fracturing job. 

## Getting Started

The following information will provide you with the proper software and data needed to replicate this project along with detailed instructions.

### Prerequisites 

For this project the following software and data is needed:

* R
* RStuido
* Backup and restored version of the FracFocus Registry Database
* SQL Server Managment Studio (SSMS)


### Installing and Downloading R and Rstudio

This next paragraph will expain where and how to download and install R and RStudo.


### Downloading, Restoring and Understanding the FracFocus Database

A replica database of the entire FracFocus registry is available for download as a backup file [Here](http://fracfocus.org/data-download). This data is updated the 15th of every month with the most recent disclosures. The download will contain a backup version of the Microsoft SQL Server 2012 database that provides the same information available through FracFocus. Once the database is downloaded, it must be restored (From its backup version to a useable file) using a SQL Server Managment Studio application. Since, the backup database was created using Microsoft SQL 2012, it is reccommended that the 2012 edition of SQL Server Managment Studio is used to restore the database. To download and install the proper edition of SSMS, follow the instructions found here. 



