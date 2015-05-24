# Coursera - Getting and Cleaning Data
# Project assignment
# 5/22/2015
# The Purpose of this script is to fulfill the required task by
#     the assignment.

proj_directory <- "C://Users//Gilberto Resendez//mystuff//_Coursera//_L3_Get_Clean_Data//Project"
if (getwd() != proj_directory) setwd(proj_directory)

# Load packages ---------------------------------------------------------------
#library("R.utils")    # Need the function countLines

# Function list ---------------------------------------------------------------

## Function 1 - GetLabels()
## The purpose of this function is to retrieve the 561 labels from the
##     "features.txt." file and return a string vector
GetLabels <- function() {
  readLines("UCI HAR Dataset//features.txt")
}

## Function 2 - GetData561(path)
## The purpose of this func. is to retrieve, clean, and tabulate the raw data
##    from these files: 
##      "UCI HAR Dataset//test//X_test.txt"
##      "UCI HAR Dataset//train//X_train.txt"
GetData561 <- function(path) { # DONT FORGET TO CHANGE THE FUNCTION BACK !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  ### Nested Function 1 - VectorSplitClean(x)
  ### The purpose of this nested function is to take a single-element
  ###     character vector, x, and split it between the spaces, unlist the
  ###     result, turn it into numeric datatype, and remove all NAs. Return
  ###     the resulting vector with many elements (ideally 561)
  VectorSplitClean <- function(x) {
    x_split <- as.numeric(unlist(strsplit(x, split = " ")))
    x_clean <- t(x_split[!is.na(x_split)])
    x_clean
  }
  
  vector_long_lines <- readLines(path)
  num_fields <- length(VectorSplitClean(vector_long_lines[1]))
  num_lines <- length(vector_long_lines)
  df <- as.data.frame(matrix(nrow = num_lines, ncol = num_fields))
  
  # THIS IS THE FULL FOR-LOOP. USE WHEN SCRIPT IS COMPLETE.
  
  for (i in 1:num_lines) {
    if (i%%100 == 0) print(i)
    df[i, ] <- VectorSplitClean(vector_long_lines[i])
  }
  

  # THIS IS THE SHORT FOR-LOOP. USE UNTIL SCRIPT IS COMPLETE.
  "
  for (i in 1:200) {
    if (i%%100 == 0) print(i)
    df[i, ] <- VectorSplitClean(vector_long_lines[i])
  }
  "

  df
}

## Function 3 - GetSubjects(path)
## The purpose of this function is to retrieve, clean, and return a vector
##    from the subject data found in the following files:
##      "UCI HAR Dataset//test//subject_test.txt"
##      "UCI HAR Dataset//train//subject_train.txt"
GetSubjects <- function(path) {
  x <- readLines(path)
  df <- as.data.frame(x)
  names(df) <- "SUBJECT"
  df
}

## Function 4 - GetActivities(path)
## The purpose of this function is to retrieve, clean, and return a vector
##    from the activity data found in the following files:
##      "UCI HAR Dataset//test//y_test.txt"
##      "UCI HAR Dataset//train//y_train.txt"
GetActivities <- function(path) {
  x <- readLines(path)
  
  ### Nested Function 2 - DesignateActivity(num)
  ### The purpose of this nested function is to take a vector of strings
  ###   and change each string depending on its value.
  DesignateActivity <- function(num) {
    switch(num,
           "1" = "walking",
           "2" = "walking_upstairs",
           "3" = "walking_downstairs",
           "4" = "sitting",
           "5" = "standing",
           "6" = "laying")
  }
  df <- as.data.frame(as.vector(vapply(x, DesignateActivity, FUN.VALUE = "")))
  names(df) <- "ACTIVITY"
  df
}

## Function 5 - KeepMeanSD(df)
## The purpose of this function is to reduce the dataframe, df, to only
##    columns of calculated mean and standard deviation.
KeepMeanSD <- function(df) {
  b_mean <- grepl("mean", names(df), ignore.case = TRUE)
  b_std  <- grepl("std", names(df), ignore.case = TRUE)
  b_col <- b_mean | b_std
  b_col[1:2] <- c(T,T)
  df[ , b_col]
}

## Function 6 - AverageDF(df)
## the purpose of this function is to get the average of all the data fields
##    for every activity, for every subject.
AverageDF <- function(df) {
  #df <- df[1:nrow(df), 1:10]
    
  ### Nested function 3 - SplitMean(df, subject, activity)
  ### The purpose of this function is to take a dataframe, df,
  ###   a subject, "1" through "30", and an activity ("walking", etc.)
  ###   and to create a subset dataframe of the rows with matching
  ###   subject and activity. Then, we average every column (after column 3).
  ###   This will return a single-row dataframe.
  SplitMean <- function(df, subject, activity) {
    df <- df[(df[ , 1] == subject & df[ , 2] == activity), ]
    cbind(df[1, 1:2], t(sapply(df[ , 3:ncol(df)], mean)))
  }
  
  ### Nested function 4 - ListMerger(df)
  ### The purpose of this function is to take in a dataframe, call
  ###   SplitMean() on it for every subject and activity, and merge the
  ###   Resulting rows together. Returns the resulting data.frame.
  ListMerger <- function(df) {
    subjects <- as.character(1:30)
    activities <- c("walking", "walking_upstairs", "walking_downstairs",
                    "sitting", "standing", "laying")
    df_of_splitmeans <- data.frame()
    for (i in 1:length(subjects)) {
      for (j in 1:length(activities)) {
        df_of_splitmeans <- rbind(df_of_splitmeans,
                                  SplitMean(df, subjects[i], activities[j]))
      }
    }
    df_splitmeans_nona <- df_of_splitmeans[complete.cases(df_of_splitmeans), ]
    row.names(df_splitmeans_nona) <- NULL
    df_splitmeans_nona
  }
  ListMerger(df)
}

# Main code block -------------------------------------------------------------
features <- GetLabels()
# temporary comment # 
df_x_test <- GetData561("UCI HAR Dataset//test//X_test.txt")
# temporary comment # 
df_x_train <- GetData561("UCI HAR Dataset//train//X_train.txt")
names(df_x_test)  <- features
names(df_x_train) <- features
test_activities   <- GetActivities("UCI HAR Dataset//test//y_test.txt")
test_subjects     <- GetSubjects("UCI HAR Dataset//test//subject_test.txt")
train_activities  <- GetActivities("UCI HAR Dataset//train//y_train.txt")
train_subjects    <- GetSubjects("UCI HAR Dataset//train//subject_train.txt")

# Merging of all test data, train data, and those two together.
df_test_full <- cbind(test_subjects, test_activities, df_x_test)
df_train_full <- cbind(train_subjects, train_activities, df_x_train)
df_full <- rbind(df_train_full, df_test_full)
df_reduced <- KeepMeanSD(df_full)
df_average <- AverageDF(df_reduced)
write.table(df_average, file = "sensor_data.txt", row.names = F)