# Manipulating FracFocus Data using R

Hydraulic fracking fluids are large solutions of chemicals used for recovering oil and gas in unconventional shale plays. The overall usage of specific chemicals in the industry is poorly understood by researchers, however a large database hosted by [Fracfocus.org](http://fracfocus.org/) reports hydraulic fracking fluid compositions in a manner that is unorganized and hard to sort through. The objective of this project is to develop a script(s) in R to query data from the Fracfocus registry to report on specific hydraulic fracking chemicals used by the industry. The script(s) will also be used to perform statistal analysis on specific ingredients to help understand which ingredients the industry as a whole is preferring to use along with the concentrations these chemicals are used during a hydraulic fracturing job. 

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

### Obtaining SSMS(SQL Server Management Studio)

SSMS is an integrated environment for managing any SQL infrastructure. SSMS provides tools to configure, monitor
and produce/host instances of an SQL server and databases. To download SSMS, click [here](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15)
where you will be able to find an SSMS for your needs.


### Downloading and Restoring FracFocus Database

A replica database of the entire FracFocus registry is available for download as a backup file [Here](http://fracfocus.org/data-download). This data is updated the 15th of every month with the most recent disclosures. The download will contain a backup version of the Microsoft SQL Server 2012 database that provides the same information available through the FracFocus website. Once the database is downloaded, it must be restored (From its backup version to a useable file) using a SQL Server Managment Studio application. FracFocus includes detailed insturctions here on how to restore the backup database.

Since the backup database was created using Microsoft SQL 2012, it is reccommended that the 2012 edition of SQL Server Managment Studio is used to restore the database. To download and install the proper edition of SSMS, follow the instructions found here. 

Explain how the server is a local host on your computer.

#### Structure of the FracFouc Database

Now that the database is retored and is located in SSMS application, it is important to understand how the data is stored. Every disclosure in FracFoucs is composed on three different components of which they are stored in three different tables. The tables that can you will find in the restored database include:

* RegistryUpload – This table contains each disclosure’s header information such as the job date, API number, location, base water volume, and total vertical depth.

* RegistryUploadPurpose – This table contains each disclosure’s additive names, suppliers, and the purposes for the additives used.

* RegisryUploadIngredients – This table contains each disclosure’s chemical information, where available, such as the CAS number and the maximum percentages in which they are found in the additive and job.






