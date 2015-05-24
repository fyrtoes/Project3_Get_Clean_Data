# "run_analysis.R"
The codebook
---
In this codebook you will find a short explanation on the functions and variables used in "run_analysis.R"

### Functions:
---

Function 1 - GetLabels() - The purpose of this function is to retrieve the 561 labels from the "features.txt." file and return a string vector

Function 2 - GetData561(path) - The purpose of this func. is to retrieve, clean, and tabulate the raw data from these files:

* "UCI HAR Dataset//test//X_test.txt"

* "UCI HAR Dataset//train//X_train.txt"

	Nested Function 1 - VectorSplitClean(x) - The purpose of this nested function is to take a single-element character vector, x, and split it between the spaces, unlist the result, turn it into numeric datatype, and remove all NAs. Return the resulting vector with many elements (ideally 561)

Function 3 - GetSubjects(path) - The purpose of this function is to retrieve, clean, and return a vector from the subject data found in the following files:

* "UCI HAR Dataset//test//subject_test.txt"

* "UCI HAR Dataset//train//subject_train.txt"

Function 4 - GetActivities(path) - The purpose of this function is to retrieve, clean, and return a vector from the activity data found in the following files:

* "UCI HAR Dataset//test//y_test.txt"

* "UCI HAR Dataset//train//y_train.txt"
	
	Nested Function 2 - DesignateActivity(num) - The purpose of this nested function is to take a vector of strings and change each string depending on its value.

Function 5 - KeepMeanSD(df) - The purpose of this function is to reduce the dataframe, df, to only columns of calculated mean and standard deviation.

Function 6 - AverageDF(df) - The purpose of this function is to get the average of all the data fields for every activity, for every subject.

	Nested function 3 - SplitMean(df, subject, activity) - The purpose of this function is to take a dataframe, df, a subject, "1" through "30", and an activity ("walking", etc.) and to create a subset dataframe of the rows with matching subject and activity. Then, we average every column (after column 3). This will return a single-row dataframe.
	
	Nested function 4 - ListMerger(df) - The purpose of this function is to take in a dataframe, call SplitMean() on it for every subject and activity, and merge the Resulting rows together. Returns the resulting data.frame.

### Variables
---
