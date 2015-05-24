# "run_analysis.R"
The codebook
---
In this codebook you will find a short explanation on the functions and variables used in "run_analysis.R"

### Functions:
---

1. Function 1 - GetLabels() - The purpose of this function is to retrieve the 561 labels from the "features.txt." file and return a string vector

2. Function 2 - GetData561(path) - The purpose of this func. is to retrieve, clean, and tabulate the raw data from these files:

* "UCI HAR Dataset//test//X_test.txt"

* "UCI HAR Dataset//train//X_train.txt"

3. Nested Function 1 - VectorSplitClean(x) - The purpose of this nested function is to take a single-element character vector, x, and split it between the spaces, unlist the result, turn it into numeric datatype, and remove all NAs. Return the resulting vector with many elements (ideally 561)

4. Function 3 - GetSubjects(path) - The purpose of this function is to retrieve, clean, and return a vector from the subject data found in the following files:

* "UCI HAR Dataset//test//subject_test.txt"

* "UCI HAR Dataset//train//subject_train.txt"

5. Function 4 - GetActivities(path) - The purpose of this function is to retrieve, clean, and return a vector from the activity data found in the following files:

* "UCI HAR Dataset//test//y_test.txt"

* "UCI HAR Dataset//train//y_train.txt"
	
6. Nested Function 2 - DesignateActivity(num) - The purpose of this nested function is to take a vector of strings and change each string depending on its value.

7. Function 5 - KeepMeanSD(df) - The purpose of this function is to reduce the dataframe, df, to only columns of calculated mean and standard deviation.

8. Function 6 - AverageDF(df) - The purpose of this function is to get the average of all the data fields for every activity, for every subject.

9. Nested function 3 - SplitMean(df, subject, activity) - The purpose of this function is to take a dataframe, df, a subject, "1" through "30", and an activity ("walking", etc.) and to create a subset dataframe of the rows with matching subject and activity. Then, we average every column (after column 3). This will return a single-row dataframe.
	
10. Nested function 4 - ListMerger(df) - The purpose of this function is to take in a dataframe, call SplitMean() on it for every subject and activity, and merge the Resulting rows together. Returns the resulting data.frame.

### Variables
---

1. features - assigned the return value of GetLabels()

2. df_x_test - assigned the return value of GetData561("UCI HAR Dataset//test//X_test.txt")

3. df_x_train - assigned the return value of GetData561("UCI HAR Dataset//train//X_train.txt")

4. names(df_x_test) - assign the value of "features" to the column names of "df_x_test"

5. names(df_x_train) - assign the value of "features" to the column names of "df_x_train"

6. test_activities - assigned the return value of GetActivities("UCI HAR Dataset//test//y_test.txt")

7. test_subjects - assigned the return value of GetSubjects("UCI HAR Dataset//test//subject_test.txt")

8. train_activities - assigned the return value of GetActivities("UCI HAR Dataset//train//y_train.txt")

9. train_subjects - assigned the return value of GetSubjects("UCI HAR Dataset//train//subject_train.txt")

Merging of all test data, train data, and those two together in the next three variables

10. df_test_full - assigned the return value of cbind(test_subjects, test_activities, df_x_test). Test subdataframe.

11. df_train_full - assigned the return value of cbind(train_subjects, train_activities, df_x_train). Train subdataframe.

12. df_full - assigned the return value of rbind(df_train_full, df_test_full). This is the entire data table that is requested before averaging out.

13. df_reduced - assigned the return value of KeepMeanSD(df_full)

14. df_average - assigned the return value of AverageDF(df_reduced)
