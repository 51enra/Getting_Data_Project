# Getting_Data_Project
Repository for the course project of "Getting and Cleaning Data" on Coursera

## Study Design
The R script run_analysis.R performs analysis of smartphone sensor data contained
in the folder "UCI_HAR_Dataset". The data is described at

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

n.b.:
To read the data into R, the folder UCI HAR Dataset was renamed to to UCI_HAR_Dataset.
The working directory name is set at the beginning of the script. The folder
UCI_HAR_Dataset must be located in the working directory.

The full data set contains observations for 30 test subjects each performing 6 different
activities. A number of observations for 561 different measurement features are stored
for each subject and each activity. The data are subdivided into a training data set and
a test data set.

The following analysis is performed by run_analysis.R: 
- Merging of training and test sets to create one data set
- Using the measurement feature names to create decsriptive variable names for each set of observations
- Using the descriptive activity names to name the activities in the data set
- Extracting only the 66 mean and standard deviation measurement features out of the total 561
- Creating a new, tidy data set containing the average of each variable for each activity and each subject
- Writing the data to a file result.txt

## Codebook
The R script generates two output data sets:
"full" containing 10299 observations of 68 variables
"labelUnique" containing 180 observations of 68 variables

"full":
Column 1 "Subject" [1..30] refers to the test subject for the measurement record
Column 2 "Activity" [STANDING, SITTING, LAYING, WALKING, WALKING_DOWNSTAIRS,
WALKING_UPSTAIRS] refers to the activity for the measurement record
Column 3...68 contain the mean and standard deviation for different motion sensor
readings from the smartphone. Multiple readings are recorded for each individuum
(subject) and each activity.

"labelUnique":
Column 1 "Subject" [1..30] refers to the test subject for the measurement record
Column 2 "Activity" [STANDING, SITTING, LAYING, WALKING, WALKING_DOWNSTAIRS,
WALKING_UPSTAIRS] refers to the activity for the measurement record
Column 3...68 contain the mean and standard deviation for different motion sensor
readings from the smartphone. Each record contains the average of all readings
in the full data set for the same subject and activity.
