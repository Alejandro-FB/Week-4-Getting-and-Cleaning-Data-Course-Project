# Loading required packages
library(tidyverse)



# Assigning all data frames -----------------------------------------------

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# tets data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

# train data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")



# Step 1 ------------------------------------------------------------------
# merge (train + test) data
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)
merged_Data <- cbind(subject_data, y_data, x_data)


# Step 2 -----------------------------------------------------------------
# tidy data 
tidy.Data <- merged_Data %>% 
        select(subject, code, contains("mean"), contains("std"))


# Step 3 -----------------------------------------------------------------
tidy.Data$code <- activities[tidy.Data$code, 2]


# Step 4 -----------------------------------------------------------------
names(tidy.Data)[2] = "activity"
names(tidy.Data)<-gsub("Acc", "Accelerometer", names(tidy.Data))
names(tidy.Data)<-gsub("Gyro", "Gyroscope", names(tidy.Data))
names(tidy.Data)<-gsub("BodyBody", "Body", names(tidy.Data))
names(tidy.Data)<-gsub("Mag", "Magnitude", names(tidy.Data))
names(tidy.Data)<-gsub("^t", "Time", names(tidy.Data))
names(tidy.Data)<-gsub("^f", "Frequency", names(tidy.Data))
names(tidy.Data)<-gsub("tBody", "TimeBody", names(tidy.Data))
names(tidy.Data)<-gsub("-mean()", "Mean", names(tidy.Data), ignore.case = T)
names(tidy.Data)<-gsub("-std()", "STD", names(tidy.Data), ignore.case = T)
names(tidy.Data)<-gsub("-freq()", "Frequency", names(tidy.Data), ignore.case = T)
names(tidy.Data)<-gsub("angle", "Angle", names(tidy.Data))
names(tidy.Data)<-gsub("gravity", "Gravity", names(tidy.Data))


# Step 5 -----------------------------------------------------------------
Final.Data <- tidy.Data %>%
        group_by(subject, activity) %>%
        summarise_all(funs(mean))

write.table(Final.Data, "Final_Data.txt", row.name = F)


