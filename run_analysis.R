## Getting and Cleaning Data: Course Project
## Create one R script called run_analysis.R that does the following. 

## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data set with
## the average of each variable for each activity and each subject.

## n.b.: needed to rename folder UCI HAR Dataset to UCI_HAR_Dataset

oldwd <- getwd()
setwd("~/Homework/Getting_Data_Project")
train <- read.table("~/UCI_HAR_Dataset/train/X_train.txt")
test <- read.table("~/UCI_HAR_Dataset/test/X_test.txt")
## 'full' is the merged data set of train and test data (Step 1) 
full <- rbind(train, test)
feat <- read.table("~/UCI_HAR_Dataset/features.txt", 
                   colClasses = "character")
## remove some "illegal characters" from the feature names to be used as R variable names
feat[,2] <- gsub("-", "_", gsub("()", "_", feat[,2], fixed = T), fixed = T)
## Use the feature elements as descriptive column titles (Step 4) 
colnames(full) = feat[,2]
## filter all "-mean()" and "std()" rows out of feat
featureFilter <- feat[grepl("_mean_", feat[,2], fixed = T) | grepl("_std_",
                                                                    feat[,2], fixed = T),]
## select appropriate columns out of test (Step 2)
full <- full[,featureFilter$V2]
rm(train, test, feat)
trainSubj <- read.table("~/UCI_HAR_Dataset/train/subject_train.txt")
testSubj <- read.table("~/UCI_HAR_Dataset/test/subject_test.txt")
trainActiv <- read.table("~/UCI_HAR_Dataset/train/y_train.txt")
testActiv <- read.table("~/UCI_HAR_Dataset/test/y_test.txt")
actLabels <- read.table("~/UCI_HAR_Dataset/activity_labels.txt")
fullSubj <- rbind(trainSubj, testSubj)
fullActiv <- rbind(trainActiv, testActiv)
fullActiv$V1 <- factor(fullActiv$V1, levels = actLabels[,1], labels = actLabels[,2])

## Add the Subject and descriptive Activity information to the data frame (Step 3) 
full <- data.frame(Subject = fullSubj$V1, Activity = fullActiv$V1, full)
labelUnique <- unique(data.frame( Subject = fullSubj$V1, Activity = fullActiv$V1))
labelUnique <- labelUnique[order(labelUnique$Subject),]
rm(trainSubj, testSubj, fullSubj,trainActiv, testActiv, fullActiv)

## condMean calculates the mean of specific values in one column of data frame "allData".
## The values to average over are selected according to their "Subject" and "Activity" value
## being equal to variable x and y, resepctively.
## The column to average is selected by the character variable z.
condMean <- function(x,y,z) {mean(full[full$Subject == x &
                                             full$Activity == y, z])}

## Fill "labelUnique" as second, independent tidy data set with
## the average of each variable for each activity and each subject (Step 5)
for(name in featureFilter[,2]){
##    print(name)
    labelUnique[name] <- mapply(condMean, labelUnique$Subject, labelUnique$Activity, name)
}

write.table(labelUnique, "~/result.txt", row.names = F)
setwd(oldwd)
