library(readr)
library(reshape2)
library(dplyr)

rootDataDir <- "./UCI HAR Dataset/"

buildName <- function(filename) {
	paste(rootDataDir, filename, sep = "")
}

#	STEP 1 -- build mydata Data Frame (66 columns from original data)
#	======
#
	#
	#	First, select features of interest from the full set.
	#
	#		This is pretty easy to automate in this case --
	#		Build a data frame from the "features.txt" file, then 
	#		just grep for the feature names containing "mean()" and
	#		"std()"
	#
	featureFile <- buildName("features.txt")
	featureDF <- read.table(featureFile, sep = " ")
	nFeatures = length(featureDF$V1)

	meanNdx <- grep("mean()", featureDF$V2, fixed = TRUE)
	stdNdx <- grep("std()", featureDF$V2, fixed = TRUE)

	#	Indices of selected features
	#		This will be used to extract the set of columns required.
	#
	myNdx <- sort(c(meanNdx, stdNdx))

	#	Names of selected features
	myFeatureNames <- as.character(featureDF$V2[myNdx])

	#
	#	This helps to automate the codebook description
	#
	codebookDF <- data.frame(cbind(myFeatureNames, myNdx))
	colnames(codebookDF) <- c("features", "originalindex")

	#
	#	Second, extract the corresponding data.
	#
	#
	#	Read training data, then subset to the columns of interest.
	#
	trainingDatafile <- buildName("train/X_train.txt")
	trainDF <- read_fwf(trainingDatafile, fwf_widths(rep.int(16, nFeatures)))
	#	Subset features of interest.
	trainDF <- trainDF[, myNdx]


	#
	#	Read testing data, then subset to the columns of interest.
	#
	testingDatafile <- buildName("test/X_test.txt")
	testDF <- read_fwf(testingDatafile, fwf_widths(rep.int(16, nFeatures)))
	#	Subset features of interest.
	testDF <- testDF[, myNdx]

	#
	#	Third, combine the training and test data, then rename the columns.
	#
	#		Potential issue(s):
	#			Might want to rename columns to better (i.e., smaller) names.
	#			Data size could have been an issue, so unwanted columns are eliminated quickly.
	#
	#		Make sure to use the training, then test order in rbind for
	#			for the data, subjects, dataset IDs, and activities.
	#
	mydata <- rbind(trainDF, testDF)
	colnames(mydata) <- myFeatureNames

#	STEP 2 -- build the combined vector of subject IDs
#	======
#
	#	Read the subject data
	#		and combine the training set subjects and the test set subjects
	#
	trainingSubFile <- buildName("train/subject_train.txt")
	trainingSubjectDF <- read.table(trainingSubFile)
	nTrain <- length(trainingSubjectDF$V1)

	testSubjectDF <- read.table(buildName("test/subject_test.txt"))
	nTest <- length(testSubjectDF$V1)
	subjects <- rbind(trainingSubjectDF, testSubjectDF)

	#	Convert the coulmn of integer values (subject IDs)
	#		to a factor column with 30 levels
	#	There may be an easier way to do this, but this works...
	#
	subjects$V1 <- as.character(subjects$V1)
	subjects$V1 <- factor(subjects$V1, levels = 1:30)


#	STEP 3 -- build the combined vector of source datasets
#	======
#
	#	Create a factor column with two levels to indicated the source dataset
	#		Use either "train" or "test" to indicate the original dataset.
	#
	dataset <- factor(c(rep.int(1, nTrain), rep.int(2, nTest)), levels = c("1", "2"), labels = c("train", "test"))


#	STEP 4 -- build the combined vector of activities
#	======
#
	#	Now combine the activity data (and turn it info a factor column)
	#
	activities <- rbind(read.table(buildName("train/y_train.txt")), read.table(buildName("test/y_test.txt")))
	#
	#	Probably should set these by reading in the "activity_labels.txt" file to automate,
	#		but this is small enough to do by hand and I might want to modify the labels.
	#
	activityLevels <- c("1", "2", "3", "4", "5", "6")
	activityLabels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
	#
	activity <- factor(activities$V1, levels = activityLevels, labels = activityLabels)

#	STEP 5 -- build the combined tidy data.frame 
#	======
#
	#	Build a data.frame from the new columns with appropriate column names
	#
	#	newDataColumns <- cbind(subjects, activity, dataset)
	#	colnames(newDataColumns) <- c("subject", "activity", "dataset")
	#
	#	Decided against the dataset column
	#
	newDataColumns <- cbind(subjects, activity)
	colnames(newDataColumns) <- c("subject", "activity")
	#
	#	Merge new data columns with the extracted data frame of numerical data
	#
	tidyData <- cbind(newDataColumns, mydata)


	meltedData <- melt(tidyData, 1:2)

	#	foo1 <- group_by(meltedData, subject, activity, variable)
	#	foo2 <- summarize(foo1, mean(value))
	
	tidyData2 <- meltedData %>% group_by(subject,activity,variable) %>% summarize(mean(value))
	write.table(tidyData2, "tidyData2.txt", sep = ",", row.names = FALSE)





