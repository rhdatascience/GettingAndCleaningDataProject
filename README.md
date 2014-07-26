# Project - README

The data for this project can be obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Prerequisites

Download the data from the zip file above into your working folder.
Extract the data into a subfolder called data. Manually move all files under .\data\UCI HAR Dataset into .\data.
You should have two folders under data: train and test.

## Running the script

Install the R packages plyr and reshape2.
install.packages("plyr")
install.packages("reshape2")

Download the script run_analysis.R from this GitHub repo into your working directory.
run_analysis.R contains one function called run_analysis() and returns the tidy data corresponding to part 5 of the project.

If you want to look at the other variables from the script, you can simply copy the content of the function and run it in RStudio.

## Explanation of the script

My script does following. 

1. Reads the data for subject (subject are people), X (X are measurements) and y (y are activities) from the train and test folders, row combines them and then columns combines them into one dataset.

2. Read the feature names from features.txt and only selects the features containing "mean()" and "std()". Only these features will be extracted from the one dataset above.

3. Replace the activities in the one data set with names taken from activity_labels.txt.

4. Rename the variable names of the measurements. I am doing the following transformations.
	
	* Remove "-", "()" and duplicate "Body".
	* Replace starting 't' with Time and 'f' with Frequency.
	* Replace Mag with Magnitude, std with StandardDeviation, mean with Mean, Acc with Acceleration, Gyro with Gyroscope.
	* Replace the ending 'X', 'Y', 'Z' with 'Xaxes', 'Yaxes', 'Zaxes'
	
5. Use the data set from step 4 and calculate the average of each variable for each activity and each subject.

The CodeBook will give more info about how I am cleaning the data.
