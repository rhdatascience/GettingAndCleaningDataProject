# Project - CodeBook

More info about the data being read can be obtained from the files README.txt and features_info.txt in the data folder.

The code in run_analysis.R also contains plenty of comments.

## Project part 1

subjectMerged - A 10299 x 1 data frame obtained by row binding the data from subject_train.txt and subject_test.txt. This contains the subject identifier as a numeric of the experiment.

yMerged - A 10299 x 1 data frame obtained by row binding the data from y_train.txt and y_test.txt. This contains the activity class as a numeric.

XMerged - A 10299 x 561 data frame obtained by row binding the data from X_train.txt and X_test.txt

oneDataSet - A 10299 x 563 data frame obtained by column binding subjectMerged, yMerged and XMerged.

## Project part 2

features - A 561 x 2 data frame obtained by reading features.txt with read.table. This contains the names of the all the measurements.

featInd - A 66-length integer vector that corresponds to the indices of the features which names only contain "mean()" or "std()". According to the features_info file, the mean and standard deviation are specified as follow:
	* mean(): Mean value
	* std(): Standard deviation

This is the reason why I am using "mean()" or "std()".

oneDataSetEx - A 10299 x 68 data frame. The is the same data frame as oneDataSet but the measurements it contains (columns 3:end) only have mean and standard deviation variables.

## Project part 3

activity_labels - A 6 x 2 data frame obtained by reading activity_labels.

yMergedWithActivityLabels - A 10299 x 2 data frame obtained by joining the merged activities (yMerged) with the activity_labels by the first column. The second column in yMergedWithActivityLabels contains the name of the activity. (i.e LAYING, WALKING, ...)

oneDataSetExWithActivity - A 10299 x 68 data frame. Same data frame as oneDataSetEx but the 2 column (for activity) has been replaced with the name of the activity from yMergedWithActivityLabels.

## Project part 4

descVariableNames <- A list of the 561 feature names from the variable features. I am using this to give descriptive names to these variables. I am doing the following transformations.
* Remove "-", "()" and duplicate "Body".
* Replace starting 't' with Time and 'f' with Frequency.
* Replace Mag with Magnitude, std with StandardDeviation, mean with Mean, Acc with Acceleration, Gyro with Gyroscope.
* Replace the ending 'X', 'Y', 'Z' with 'Xaxes', 'Yaxes', 'Zaxes'

tidyOneDataSet - A 10299 x 68 data frame. Same as oneDataSetExWithActivity but it has now descriptive column names from descVariableNames subsetted with the 66-length vector featInd + "Subject" and "Activity" for the first 2 columns.

## Project part 5

secondDataSet - A 10299 x 68 data frame. This is the same one as tidyOneDataSet. My interpretation here is that all the work the extract the mean and std variables, give descriptive names to variables should be used for the tidy data in part 5 as well.

tidy - A 180 x 68 data frame containing the average of each variable for each activity and each subject. These values where obtained by using the aggregate function from reshape2 on the Activity and Subject variables.
* Column 1 has the subject.
* Column 2 has the activity.
* Columns 3:68 contain the average of all the value for the corresponding subject and activity.

This tidy data is then written into the file .\data\merged\tidyData.txt using write.table and .\data\merged\tidyData.csv using write.csv.





