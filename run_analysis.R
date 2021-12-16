# This script performs the following steps for the wearable dataset collected from the link below.
# This is for the final course project for the course Getting and Cleaning Data on Coursera
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# ====== Part 1 ======= 
# Reading the test files and Checking Heads
test_subjects_index<- read.table("./UCI HAR Dataset/test/subject_test.txt", sep = " ")
head(test_subjects_index)
test_activity_index <- read.table("./UCI HAR Dataset/test/y_test.txt", sep = " ")
head(test_activity_index)
test_measurement_reading <- read.table("./UCI HAR Dataset/test/X_test.txt")
head(test_measurement_reading)

# Adding subject index and activitiy index as two left columns to the reading 
test_measurement_reading <- cbind(test_subjects_index, test_activity_index, test_measurement_reading)

# Reading the training files and Checking Heads
training_subjects_index <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep = " ")
head(training_subjects_index)
training_activity_index <- read.table("./UCI HAR Dataset/train/y_train.txt", sep = " ")
head(training_activity_index)
training_measurement_reading <- read.table("./UCI HAR Dataset/train/X_train.txt")
head(training_measurement_reading)

# Adding subject index and activitiy index as two left columns to the reading 
training_measurement_reading <- cbind(training_subjects_index, training_activity_index, training_measurement_reading)

#Combining train and test data sets
full_dataset <- rbind(test_measurement_reading, training_measurement_reading)

# Reading the list of features from features.txt and Checking Heads
features_list <- read.table("./UCI HAR Dataset/features.txt")
head(features_list)


# Giving variable alternative names per features.txt
names(full_dataset) <- c("SubjectIndex", "Activity" , as.character(features_list[, 2]))
head(full_dataset)

# ====== Part 2 ======= 
# Picking the variable names including "mean" or "std" in their names
mean_std_vars <- grepl("mean|std", features_list[, 2])

# First two TRUEs to include subject index and activitiy index per each row
mean_std_measurements <- full_dataset[, c(TRUE, TRUE, mean_std_vars)]


# ====== Part 3 ======= 
# Replacing 6 activity codes with corresponding activities for better readability
an <- as.character(mean_std_measurements[, 2])
an <- sub("1", "WALKING", an)
an <- sub("2", "WALKING_UPSTAIRS", an)
an <- sub("3", "WALKING_DOWNSTAIRS", an)
an <- sub("4", "SITTING", an)
an <- sub("5", "STANDING", an)
an <- sub("6", "LAYING", an)
mean_std_measurements[, 2] <- an #Replaing activities in the dataset with intuitive names


# ====== Part 4 ======= 
# To make variable names more readable we swap the begging "t"s and "f"s with
# "Time" and "Frequency" per variable descriptions. Also replacing "Acc" with Acceleration
vn <- names(mean_std_measurements)
vn <- sub("^t", "Time", vn)
vn <- sub("^f", "Frequency", vn)
vn <- sub("Acc", "Acceleration", vn)
vn <- gsub("\\-m", "M", vn)
vn <- gsub("\\-s", "S", vn)
vn <- gsub("\\W", "", vn)
names(mean_std_measurements) <- vn


# ====== Part 5 ======= 
library(dplyr)

# Columns to group by
grp_cols <- names(mean_std_measurements)[1:2]

# Convert character vector to list of symbols
dots <- lapply(grp_cols, as.symbol)

# Perform frequency counts
mean_per_subject_per_activity <- mean_std_measurements %>%
  group_by_(.dots=dots) %>%
  summarise_each(funs(mean))

write.table(mean_per_subject_per_activity, file = "tidydata.txt", row.names = FALSE)
