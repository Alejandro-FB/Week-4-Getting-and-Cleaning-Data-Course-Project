The `run_analysis.R` script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

1. Assigning all data frames

   - `features` <- `read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))` : 561 rows, 2 columns
     *The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.*

   - `activities` <- `read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))` :  6 rows, 2 columns
     *List of activities performed when the corresponding measurements were taken and its codes (labels)*

     

   - `x_test` <- `read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)` : 2947 rows, 561 columns
     *contains recorded features test data*

   - `y_test` <- `read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")` : 2947 rows, 1 columns
     *contains test data of activities’code labels*

   - `subject_test` <- `read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")` : 2947 rows, 1 column
     *contains test data of 9/30 volunteer test subjects being observed*

     

   - `x_train` <- `read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)` : 7352 rows, 561 columns
     *contains recorded features train data*

   - `y_train` <- `read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")` : 7352 rows, 1 columns
     *contains train data of activities’code labels*

   - `subject_train` <- `read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")` : 7352 rows, 1 column
     *contains train data of 21/30 volunteer subjects being observed*

     

1. Step 1: Merges the training and the test sets to create one data set

   - `x_data` (10299 rows, 561 columns) is created by merging `x_train` and `x_test` using **rbind()** function

   - `y_data` (10299 rows, 1 column) is created by merging `y_train` and `y_test` using **rbind()** function

   - `subject_data` (10299 rows, 1 column) is created by merging `subject_train` and `subject_test` using **rbind()** function

   - `merged_Data` (10299 rows, 563 column) is created by merging `subject_data`, `y_data` and `x_data` using **cbind()** function

     

1. Step 2: Extracts only the measurements on the mean and standard deviation for each measurement

   - `tidy.Data` (10299 rows, 88 columns) is created by subsetting `merged_Data`, selecting only columns: `subject`, `code` and the measurements on the `mean` and *standard deviation* (`std`) for each measurement

     

1. Step 3: Uses descriptive activity names to name the activities in the data set

   - Entire numbers in `code` column of the `tidy.Data` replaced with corresponding activity taken from second column of the `activities` variable

     

1. Step 4: Appropriately labels the data set with descriptive variable names

   - `code` column in `tidy.Data` renamed into `activities`

   - All `Acc` in column’s name replaced by `Accelerometer`

   - All `Gyro` in column’s name replaced by `Gyroscope`

   - All `BodyBody` in column’s name replaced by `Body`

   - All `Mag` in column’s name replaced by `Magnitude`

   - All start with character `f` in column’s name replaced by `Frequency`

   - All start with character `t` in column’s name replaced by `Time`

     

1. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

   - `Final.Data` (180 rows, 88 columns) is created by sumarizing `tidy.Data` taking the means of each variable for each activity and each subject, after groupped by subject and activity.
   - Export `Final.Data` into `Final_Data.txt` file.