#Readme -- Notes and Description of the Project
##Getting and Cleaning Data: Course Project

###Initial Data

The original dataset is from the UCI HAR Dataset, described as "Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors."

This project assumes that the dataset has been unzipped into the project working directory in a subdirectory named "UCI HAR Dataset", which is the root directory of the data.

This dataset comes in several pieces.  There is a training dataset and a test dataset, each of which is composed of three related files, each in a subdirectory named either train or test.  The files are:

	X_train         Sensor dataset, 561 variables, 7352 observations
	y_train         Activity dataset, 1 variable (activity code)
	subject_train   Subject dataset, 1 variable (activity code)
	X_test          Sensor dataset, 561 variables, 2947 observations
	y_test          Activity dataset, 1 variable (activity code)
	subject_test    Subject dataset, 1 variable (activity code)
	
	Sensor dataset  Total: 10299 observations of 561 variables

The codebook for this dataset is the combination of descriptive "features_info.txt" and the
"features.txt" dataset (2 columns by 561 rows) which provides the column name for the corresponding column number.  There is another file, "activities.txt", which defines the map between activities and activity codes.


###Goal 1:

The first goal (corresponding to project steps 1-4) is to build a tidy dataset that combines all the original data, but selects only the data columns corresponding means and standard deviations.  The code in "run_analysis.R" in the working directory does this in five steps to create the new data frame called "tidyData".  The steps described here correspond to fairly descriptive comments in the code.

Step 1 -- build a tidy data frame from the X_train and X_test with just the columns of interest.  
There are several substeps here:  
First, select the features of interest. Create a data frame from the features.txt file. Grep the feature name coulmn for "mean()" and "std()", which will select the subset of 66 that are of interest. From this create two vectors: myNdx containg the indicies of the columns wanted, and myFeatureNames containing the names of the columns (column names are not in the original data; these will be used to create column names.)  
Second, get the training dataset and subset out the 66 columns of interest.  The do the same for the test dataset.  
Third, combine the two datasets using rbind(), with training first followed by test. Note that this same order must be used in the next several steps.  The set the column names using the myFeatureNames vector.

Step 2 -- build read in the subject_train and subject_test files as one column data frames, then rbind() them in train followed by test order.  Then convert the single column to a factor column with 30 levels corresponding to the 30 subjects.

Step 3 -- builds a factor vector to indicate source dataset, train or test.  This is not actually used as it wasn't really pertinent to the project.

Step 4 -- builds the combined activities data frame (train followed by test) and converts it to a 6 level factor with text labels corresponding to the 6 activities.

Step 5 -- combine the subject and activity datasets using cbind().  Set the column names to "subject" and "activity". The cbind() this dataset with the dataset from Step 1, creating the dataFrame tidyData for Goal 1.

This data set has 68 columns, all with descriptive column names.  The activity column has descriptive labels.  The subject column has factor values 1 through 30 for the subject identification; there was no other viable choice for identifiers other than the original numerical identifiers.  And there is just one observation of 66 variables per row. See CodeBook.md for further details.


###Goal 2:

The second goal (corresponding to project step 5) is to build a new tidy data set with the average of each variable for each activity and each subject.

The first step is to melt the dataset from Goal 1 to create a long dataset with four columns: subject, activity, variable and value.  

Then then group_by subject and activity, and summarize with mean() of value.  

This creates a new table with 4 columns -- the factor columns subject, activity, and variable (one row for each combination) and the fourth column "mean(value)". There are 11880 rows (30 subjects * 6 activities * 66 variables).

Create the output file tidyData2.txt using write.table().  This is the file for Goal 2, to be uploaded as part of the project submission.

###Goal 3

Check in everything and submit project.

###To read the uploaded data file, this should work:

    myFileLink <- "https://s3.amazonaws.com/coursera-uploads/user-5951edcf866a1c3100326779/975117/asst-3/8d81a3107b5811e599d93bffe7214f1e.txt"
    download.file(myFileLink, "myFile.txt")
    myTidyDataTable <- read.table("myFile.txt")
    head(myTidyDataTable)


