# Describing variable and analysis

This dataset includes a summary of the original study described below. After taking the raw measurements in the two test and train folders the following steps were done to generate the final dataset:

1. Merging: in this step the train and test datasets are combined into one dataset. Rows are bound because they all represent the same valriables.
2. Subject and Activity: next we added two columns to the same data set for Subject and Activity. This is an important step toward a tidy sataset because it identifies each row as to belonging to what subject and what activity.
3. Extracting Mean and Standard Deviation: per requirements of teh problem we then selected only those measurements related to mean or standard deviation of variables. We did so by choosing only variables whose names included "mean" or "std". This gave us 81 variables.
4. Activity Names: We replaced activity codes in the data set with human readable phrases per documentation: 1:WALKING, 2:WALKING_UPSTAIRS, 3:WALKING_DOWNSTAIRS, 4:SITTING, 5:STANDING, 6:LAYING
5. Intuitive Names: another step toward a tidy dataset was to adjust variable names for better readability. We changes t and f to Time and Frequency. We also changed Acc to Acceleration.
6. Aggregation: last step was to create a new table in which each variable in the data set was replaced with the mean per subject per activity. It gave us 180 rows (30 subjects, 6 activities) and 81 variables as selected before.

# The dataset includes the following files:
'README.txt'

'features_info.txt': Shows information about the variables used on the feature vector.

'features.txt': List of all features.

'activity_labels.txt': Links the class labels with their activity name.

'train/X_train.txt': Training set.

'train/y_train.txt': Training labels.

'test/X_test.txt': Test set.

'test/y_test.txt': Test labels.

# The following files are available for the train and test data. Their descriptions are equivalent.

'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

# Notes:
Features are normalized and bounded within [-1,1].
Each feature vector is a row on the text file.
For more information about this dataset contact: activityrecognition@smartlab.ws
