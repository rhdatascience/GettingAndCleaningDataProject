run_analysis <- function()
{
        library(plyr)    
        library(reshape2)
        
        ###################################################################
        #
        #  1. Merges the training and the test sets to create one data set.
        #     Merge subject, X and y files in data\\test and data\train.
        #
        ###################################################################
        #Read the train subject, X and y files into data frames
        
        subjectTrain <- read.table(".\\data\\train\\subject_train.txt")
        XTrain <- read.table(".\\data\\train\\X_train.txt")
        yTrain <- read.table(".\\data\\train\\y_train.txt")

        #Read the test subject, X and y files into data frames
        subjectTest <- read.table(".\\data\\test\\subject_test.txt")
        XTest <- read.table(".\\data\\test\\X_test.txt")
        yTest <- read.table(".\\data\\test\\y_test.txt")
        
        # row bind the test and the train data        
        subjectMerged <- rbind(subjectTrain, subjectTest)
        XMerged <- rbind(XTrain, XTest)
        yMerged <- rbind(yTrain, yTest)
        
        # Put it all togeter, subject, y (Activity) and X (measurements).
        oneDataSet <- cbind(rbind(subjectTrain, subjectTest), rbind(yTrain, yTest), rbind(XTrain, XTest))
        
        ###################################################################
        #
        #  2.Extracts only the measurements on the mean and standard 
        #    deviation for each measurement. 
        #
        ###################################################################
        
        features <- read.table(".\\data\\features.txt")
        
        # 1st solution, only return the features that have only mean and std as a whole word them. (no such thing as meanFreq for example)
        
        #nonMeanFreq <- grep("meanFreq", features[,2], invert = TRUE)                
        #mean <- grep("mean", features[,2], fixed = TRUE) # This includes meanFreq as well.
        
        # Filter out meanFeq from mean.
        # These are the index for the columns that have name *mean()*.
        # Is does NOT contain the ones that have the name meanFreq in them, it does not include the values for 
        #meanFeatures <- mean[mean %in% nonMeanFreq]
        
        # Filter all feature with mean and std in their name.
        # According to the features_info file, the mean and standard deviation are specified as follow:
        #  mean(): Mean value
        #  std(): Standard deviation
        # 
        # And this is the reason why I am using these regex        
        featInd <- grep("mean\\(\\)|std\\(\\)", features[,2])
        
        # Extract those columns
        XExtracted <- XMerged[,featInd]
        
        # One data set with subject, activity and the extracted measuments.
        oneDataSetEx <- cbind(subjectMerged, yMerged, XExtracted)
        
        ############################################################################
        #
        #  3.Uses descriptive activity names to name the activities in the data set
        #
        ############################################################################
        
        activity_labels <- read.table(".\\data\\activity_labels.txt")
        
        # Add a column in YMerged with the corresponding activity name.
        # (1=WALKING,2=WALKING_UPSTAIRS,3=WALKING_DOWNSTAIRS, 4=SITTING, 5=STANDING, 6=LAYING)
                
        yMergedWithActivityLabels <- join(yMerged, activity_labels)  
        
        oneDataSetExWithActivity <- oneDataSetEx
        
        # Replace the activity columns with the proper activity name.
        oneDataSetExWithActivity[,2] <- yMergedWithActivityLabels[,2]
        
        ##########################################################################
        #  4. Appropriately labels the data set with descriptive variable names.
        ##########################################################################
        descVariableNames <- features[,2]
        
        descVariableNames <- lapply(descVariableNames, function(x) gsub("-", "", x))                    # remove "-"        
        descVariableNames <- lapply(descVariableNames, function(x) gsub("\\(\\)", "", x))               # remove ()
        descVariableNames <- lapply(descVariableNames, function(x) gsub("^f", "Frequency", x))          # Replace f with Frequency        
        descVariableNames <- lapply(descVariableNames, function(x) gsub("^t", "Time", x))               # Replace t with Time
        descVariableNames <- lapply(descVariableNames, function(x) gsub("Mag", "Magnitude", x))         # Replace Mag with Magnitude
        descVariableNames <- lapply(descVariableNames, function(x) gsub("std", "StandardDeviation", x)) # Replace std with StandardDeviation
        descVariableNames <- lapply(descVariableNames, function(x) gsub("mean", "Mean", x))             # Replace mean with Mean
        descVariableNames <- lapply(descVariableNames, function(x) gsub("Acc", "Acceleration", x))      # Replace Acc with Acceleration        
        descVariableNames <- lapply(descVariableNames, function(x) gsub("Gyro", "Gyroscope", x))        # Replace Gyro with Gyroscope
        descVariableNames <- lapply(descVariableNames, function(x) gsub("([X|Y|Z]$)", "\\1axes", x))    # Replace the X,Y,Z at end with Xaxes, Yaxes or Zaxes
        descVariableNames <- lapply(descVariableNames, function(x) gsub("(Body)\\1", "\\1", x))         # Remove duplicate Body word
        
        tidyOneDataSet <- oneDataSetExWithActivity
        colnames(tidyOneDataSet) <- c("Subject", "Activity", as.character(descVariableNames[featInd]))
        
        #######################################################################
        #  5. Creates a second, independent tidy data set with the average 
        #     of each variable for each activity and each subject.
        #######################################################################
        
        # Start by using the same data frame as in part 4        
        secondDataSet <- tidyOneDataSet
        
        # Aggregate the data using the subject and Activity variables and take the mean of all the variables.        
        tidy <- aggregate(secondDataSet, list(secondDataSet$Activity, secondDataSet$Subject), mean, na.rm=TRUE)
        
        #  Move the Subject column to be the first column, delete the duplicate columns created by aggregate and rename to columns
        tidy <- cbind(tidy$Subject, tidy)
        tidy <- tidy[,-(3:5)]
        colnames(tidy)[1:2] <- c("Subject", "Activity")
        
        tidyData <- ".\\data\\merged\\tidyData.txt"
        
        # I am going to save the merged data into some files.
        if(!file.exists("data\\merged")){ dir.create("data\\merged") }
        write.table(tidy, ".\\data\\merged\\tidyData.txt")
        write.csv(tidy, ".\\data\\merged\\tidyData.csv")
        tidy
}