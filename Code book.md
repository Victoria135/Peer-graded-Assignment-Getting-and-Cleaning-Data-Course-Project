# The run_analysis.R script shows the script that make data tidy, easy to read and ready for the following analysis, it include 5 steps that were described in README.md.

Assignments:

features <- features.txt (561 obs of 2 variables)
activities <- activity_labels.txt (6 obs of 2 variables)
subject_test <- subject_test.txt (2947 obs of 1 variables)
subject_train <- subject_train.txt (7352 obs of 1 variables)
X_test <- X_test.txt (2947 obs of 561 variables)
y_test <- y_test.txt (2947 obs of 1 variables)
X_train <- X_train.txt (7352 obs of 561 variables)
y_train <- y_train.txt (7352 obs of 1 variables)

Merged data:

subject <- merged rows of the tables subject_train and subject_test (10299 obs of 1 variables)
X <- merged rows of the tables X_train and X_test (10299 obs of 561 variables)
y <- merged rows of the tables y_train and y_test (10299 obs of 1 variables)
merged <- merged columns of the tables subject, y and X (10299 obs of 563 variables)

Step 2 of axtracting only measurements on the mean and standard deviation for each measurement:

merged_mean_std <- 10299 obs of 86 variables

Each column has descriptive variable name that was added from the features and edditing by editting abbreviations

t <- Time
f <- Frequency
Acc <- Accelerometer
Gyro <- Gyroscope
Mag <- Magnitude
BodyBody <- Body
angle <- Angle
gravity <- Gravity
tBody <- TimeBody

New tidy data thad includes the average of each variable for each activity and each subject

Final <- 180 obs of 479 variables

Saving data in Human Activity Recognition Using Smartphones.txt file
