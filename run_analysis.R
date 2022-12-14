# Step 0. Preparing the documents

setwd("C:/Users/rikig/OneDrive/??????? ????/Getting and cleaning data - project")
getwd()

## Checking if archieve already exists, if not - download it

if (!file.exists(filename)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile = file.path("C:/Users/rikig/OneDrive/??????? ????/Getting and cleaning data - project/", "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
, method="curl")
}
filename <- "Getting and Cleaning data - downloaded.zip"

## Checking files in destination

list.files("C:/Users/rikig/OneDrive/??????? ????/Getting and cleaning data - project/")

## Checking if folder exists and unzip it

if (!file.exists("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")) { 
  unzip(filename) 
}

setwd("C:/Users/rikig/OneDrive/??????? ????/Getting and cleaning data - project/UCI HAR Dataset/")
getwd()


#R script called run_analysis.R that does the following:

## 1. Merges the training and the test sets to create one data set.

### Assigning all tables

features <- read.table("C:/Users/rikig/OneDrive/??????? ????/Getting and cleaning data - project/UCI HAR Dataset/features.txt", col.names = c("index", "featureNames"))
activities <- read.table("C:/Users/rikig/OneDrive/??????? ????/Getting and cleaning data - project/UCI HAR Dataset/activity_labels.txt", col.names = c("index", "activity"))
subject_test <- read.table("C:/Users/rikig/OneDrive/??????? ????/Getting and cleaning data - project/UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("C:/Users/rikig/OneDrive/??????? ????/Getting and cleaning data - project/UCI HAR Dataset/train/subject_train.txt")

X_test <- read.table("C:/Users/rikig/OneDrive/??????? ????/Getting and cleaning data - project/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("C:/Users/rikig/OneDrive/??????? ????/Getting and cleaning data - project/UCI HAR Dataset/test/y_test.txt")

X_train <- read.table("C:/Users/rikig/OneDrive/??????? ????/Getting and cleaning data - project/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("C:/Users/rikig/OneDrive/??????? ????/Getting and cleaning data - project/UCI HAR Dataset/train/y_train.txt")

### Merging rows

subject <- rbind(subject_train, subject_test)

X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)

### Merging columns to one set

merged <- cbind(subject, y, X)
dim(merged)
# [1] 10299   563

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

library(magrittr)
library(dplyr)

data_Mean_Std <- grep(".*[Mm]ean.*|.*[Ss]td.*", features[, 2])
requiredColumns <- c(data_Mean_Std)
merged_mean_std <- merged[,c(requiredColumns)]
dim(merged_mean_std)
# [1] 10299    86

## 3. Uses descriptive activity names to name the activities in the data set

merged <- cbind(subject, y, X)
merged[, 2] <- activities[merged[,2], 2]

## 4. Appropriately labels the data set with descriptive variable names.

names(merged) <- c("Subject", "Activities", as.character(unlist(features[,2])))

#tfeatures <- t(features)
#column_names <- c("Subject", "Activities", tfeatures[2,])
#final <- rbind(column_names, merged)
#names(final) <- as.character(unlist(final[1,]))
#final = final[-1,]
#dim(final)
#[1] 10299   563

names(merged)<-gsub("^t", "Time", names(merged))
names(merged)<-gsub("^f", "Frequency", names(merged))
names(merged)<-gsub("Acc", "Accelerometer", names(merged))
names(merged)<-gsub("Gyro", "Gyroscope", names(merged))
names(merged)<-gsub("Mag", "Magnitude", names(merged))
names(merged)<-gsub("BodyBody", "Body", names(merged))
names(merged)<-gsub("angle", "Angle", names(merged))
names(merged)<-gsub("gravity", "Gravity", names(merged))
names(merged)<-gsub("tBody", "TimeBody", names(merged))

names(merged)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Final <-aggregate(. ~Subject + Activities, merged, mean, na.rm = TRUE)
Final <-Final[order(Final$Subject,Final$Activities),]

write.table(Final, "uman Activity Recognition Using Smartphones.txt", row.name=FALSE)



