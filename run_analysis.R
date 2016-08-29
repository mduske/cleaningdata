##
## Build a tidy data set based on the "Human Activity Recognition Using Smartphones Data Set"
##

require(dplyr)
require(reshape2)

## Load and processes a full data set (test/training)
## Parameters:
## folder = folder name to process (must be the original folder names from the data set: train, test)
##
loadDataSet <- function(folder) {
  ##Load Activity Labels
  activityLabelFile <- "UCI HAR Dataset/activity_labels.txt"
  activityLabel <- read.table(activityLabelFile, header = FALSE, col.names = c("activityid","activityname"), colClasses = "character")
  
  ##Load Feature list - To be used as the column names for the data set
  featureFile <- "UCI HAR Dataset/features.txt"
  featureData <- read.table(featureFile, header = FALSE, col.names = c("featureid","featurename"), colClasses = "character") %>%
    mutate(featurename = tolower(featurename))

  ## Load Subject identifiers
  subectFile <- paste0("UCI HAR Dataset/", folder, "/", "subject_", folder, ".txt")
  subjectData <- read.table(subectFile, header = FALSE, col.names = "subjectid", colClasses = "integer")
  
  ## Load Activity Label Data
  activityFile <- paste0("UCI HAR Dataset/", folder, "/", "y_", folder, ".txt")
  activityLabelData <- read.table(activityFile, header = FALSE, col.names = "activityid", colClasses = "integer") %>%
    merge(activityLabel)
  
  ## Load Data Set - keep only interesting columns
  dataFile <- paste0("UCI HAR Dataset/", folder, "/", "X_", folder, ".txt")
  data <- read.table(dataFile, header = FALSE, colClasses = "numeric", col.names = featureData$featurename) %>%
    select(matches("std|mean")) %>% ## Keep "mean" and "standard deviation" columns
    mutate(subject = subjectData$subjectid, activity = activityLabelData$activityname) ## Include extra columns
  
  ##Remove dots from column names
  names(data) <- gsub("\\.", "", names(data))
  
  ## Return processed data set
  data
}

##Read and merge data sets
data <- rbind(loadDataSet("train"), loadDataSet("test"))

## Transform mesurement columns to rows and provide the average for each reading
tidydata <- melt(data, id=c("subject","activity")) %>%
  group_by(subject, activity, variable) %>%
  summarize(average=mean(value))

## Uncomment to save tidydata to a file
#write.table(tidydata, file = "data2.txt", row.name=FALSE)