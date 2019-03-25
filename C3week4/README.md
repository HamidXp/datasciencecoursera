## How the script run_analysis.R  work ?


This script requires the dplyr package. It  assumes the existence of the file to be  analyzed  in a directory named UCI HAR Dataset. it applies the following processing to the data :
*	Read data.
*	Merges the training and the test sets to create one data set.
*	Extracts only the measurements on the mean and standard deviation for each measurement.
*	Uses descriptive activity names to name the activities in the data set
*	Appropriately labels the data set with descriptive variable names.
*	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
*	Write the data set to the tidy_data.txt file.
