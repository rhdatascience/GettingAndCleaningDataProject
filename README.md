## Project - README

The data for this project can be obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# Prerequisites

Download the data from the zip file above into your working folder.
Extract the data into a subfolder called data. Manually move all files under .\data\UCI HAR Dataset into .\data.
You should have two folders under data: train and test.

# Running the script:

Install the R packages plyr and reshape2.
install.packages("plyr")
install.packages("reshape2")

Download the script run_analysis.R from this GitHub repo into your working directory.
run_analysis.R contains one function called run_analysis() and returns the tidy data corresponding to part 5 of the project.

If you want to look at the other variables from the script, you can simply copy the content of the function and run it in RStudio.

# More info
The CodeBook will give more info about how I am clening the data.
