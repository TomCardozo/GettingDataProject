#Code Book
##Getting and Cleaning Data: Course Project

This describes the tidyData dataset that is the result of the first four steps of the course final project.

###Feature Selection 

The original dataset from the UCI HAR Dataset are described in the "feature_info.txt" file
in the "./UCI HAR Dataset" directory and
the set of features used in that data set are listed in the file "features.txt", located in the same directory.

###Description of the Original Data:
Quoted from the "feature_info.txt" file:  

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

###Data Subset Used in this Project
The subset of variables selected for this subset are the mean and standard deviation from the following data items:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

    tBodyAcc-XYZ  
    tGravityAcc-XYZ  
    tBodyAccJerk-XYZ  
    tBodyGyro-XYZ  
    tBodyGyroJerk-XYZ  
    tBodyAccMag  
    tGravityAccMag  
    tBodyAccJerkMag  
    tBodyGyroMag  
    tBodyGyroJerkMag  
    fBodyAcc-XYZ  
    fBodyAccJerk-XYZ  
    fBodyGyro-XYZ  
    fBodyAccMag  
    fBodyAccJerkMag  
    fBodyGyroMag  
    fBodyGyroJerkMag  

The subset of the variables that were estimated from these signals and that we are interested in are: 

    mean(): Mean value  
    std():  Standard deviation  

That is 66 columns of data extracted from the 561 columns in the original two data sets
The complete list of variables of each feature vector is available in "./UCI HAR Dataset/features.txt".
The subset of interest here is listed in the table below, followed by the original column index in
the source data sets.

The two data sets "./UCI HAR Dataset/train/X_train.txt" and "./UCI HAR Dataset/test/X_test.txt"
are combined into a new data set.
In addition, there are three new variables for each observation that are added to the new data set:

"subject", a factor variable with 30 levels corresponding to the subjects in each observation.
It is built from combining the files "./UCI HAR Dataset/train/subject_train.txt" and
the file "./UCI HAR Dataset/test/subject_test.txt".  It was then converted to a factor variable with 30 levels.

"activity", a factor variable that corresponds to the activity being performed in each observation
It is built from combining the files "./UCI HAR Dataset/train/y_train.txt" and
the file "./UCI HAR Dataset/test/y_test.txt".  It was then converted to a factor variable with six activity codes (6 levels)
having the labels: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", and "LAYING".

DROPPED: "dataset", a factor variable constructed to label each observation with it's original data set, either "train" or "test".  I decided to drop this from the new data frame as irrelevant to the project.



                                          
                Feature Name            Original Column Index  
    =========================================================
                           subject           new  
                          activity           new  
                           
    1            tBodyAcc-mean()-X             1  
    2            tBodyAcc-mean()-Y             2  
    3            tBodyAcc-mean()-Z             3  
    4             tBodyAcc-std()-X             4  
    5             tBodyAcc-std()-Y             5  
    6             tBodyAcc-std()-Z             6  
    7         tGravityAcc-mean()-X            41  
    8         tGravityAcc-mean()-Y            42  
    9         tGravityAcc-mean()-Z            43  
    10         tGravityAcc-std()-X            44  
    11         tGravityAcc-std()-Y            45  
    12         tGravityAcc-std()-Z            46  
    13       tBodyAccJerk-mean()-X            81  
    14       tBodyAccJerk-mean()-Y            82  
    15       tBodyAccJerk-mean()-Z            83  
    16        tBodyAccJerk-std()-X            84  
    17        tBodyAccJerk-std()-Y            85  
    18        tBodyAccJerk-std()-Z            86  
    19          tBodyGyro-mean()-X           121  
    20          tBodyGyro-mean()-Y           122  
    21          tBodyGyro-mean()-Z           123  
    22           tBodyGyro-std()-X           124  
    23           tBodyGyro-std()-Y           125  
    24           tBodyGyro-std()-Z           126  
    25      tBodyGyroJerk-mean()-X           161  
    26      tBodyGyroJerk-mean()-Y           162  
    27      tBodyGyroJerk-mean()-Z           163  
    28       tBodyGyroJerk-std()-X           164  
    29       tBodyGyroJerk-std()-Y           165  
    30       tBodyGyroJerk-std()-Z           166
    31          tBodyAccMag-mean()           201
    32           tBodyAccMag-std()           202
    33       tGravityAccMag-mean()           214
    34        tGravityAccMag-std()           215
    35      tBodyAccJerkMag-mean()           227
    36       tBodyAccJerkMag-std()           228
    37         tBodyGyroMag-mean()           240
    38          tBodyGyroMag-std()           241
    39     tBodyGyroJerkMag-mean()           253
    40      tBodyGyroJerkMag-std()           254
    41           fBodyAcc-mean()-X           266
    42           fBodyAcc-mean()-Y           267
    43           fBodyAcc-mean()-Z           268
    44            fBodyAcc-std()-X           269
    45            fBodyAcc-std()-Y           270
    46            fBodyAcc-std()-Z           271
    47       fBodyAccJerk-mean()-X           345
    48       fBodyAccJerk-mean()-Y           346
    49       fBodyAccJerk-mean()-Z           347
    50        fBodyAccJerk-std()-X           348
    51        fBodyAccJerk-std()-Y           349
    52        fBodyAccJerk-std()-Z           350
    53          fBodyGyro-mean()-X           424
    54          fBodyGyro-mean()-Y           425
    55          fBodyGyro-mean()-Z           426
    56           fBodyGyro-std()-X           427
    57           fBodyGyro-std()-Y           428
    58           fBodyGyro-std()-Z           429
    59          fBodyAccMag-mean()           503
    60           fBodyAccMag-std()           504
    61  fBodyBodyAccJerkMag-mean()           516
    62   fBodyBodyAccJerkMag-std()           517
    63     fBodyBodyGyroMag-mean()           529
    64      fBodyBodyGyroMag-std()           530
    65 fBodyBodyGyroJerkMag-mean()           542
    66  fBodyBodyGyroJerkMag-std()           543



##Credits

For more information about the original dataset contact: activityrecognition@smartlab.ws

###License:
========  
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
