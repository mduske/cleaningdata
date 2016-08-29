# cleaningdata
Peer Graded Assignment: Getting and Cleaning Data Course Project

This repository contains the assignment on gathering and cleaning data, it is based on the "Human Activity Recognition Using Smartphones Dataset"

##Data Source
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Preparing to Run the Code
1. Download the file "run_analysis.R"
2. Download data file "getdata_projectfiles_UCI HAR Dataset.zip" to the same folder and extract it, a sub-folder named "UCI HAR Dataset" should exist in the current folder

##Running the Code
1. Open RStudio and set your working directory to the folder where the file "run_analysis.R" was saved
2. From the RStudio shell run the following command: source("run_analysis.R")
3. Two data sets will be made available: data and tidydata

##Process by which the data was generated
1. Subject IDs, Feature list, and Activity Labels; kepts in separated files, are read as data frames
2. The original data set contained in the "X" file for both test and training sets is read to data frames
3. Only columns providing the Standard Deviation or Mean for a given reading are kept
4. The data set is enhanced by including the subject identifier and also the activity name for each observation
5. This data set is available as the variable "data"

## Generating the Tidy data set from the original data set
1. The data set is melted in order to have all columns except for subject and activity defined as values of the new "variable" and "value" columns
2. The data set is grouped by: subject, activity and measure
3. The average for the groups is generated and stored  as the column "average"
4. This data set is available as the variable "tidydata"

##Cobe Book

###Variables
The tidydata variable contains the following columns:
* subject - Unique subject identifier
* activity - Label for the activity being performed
* variable - Variable being reported, refer to the original study (file "features.txt") for the full list of variables, only those related to std and mean were kept
* average - Average generated from readings for the same subject, activity and variable from the original dataset (stored in the variable named "data")
