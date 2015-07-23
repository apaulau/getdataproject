library(data.table)
library(dplyr)
library(reshape2)

# Download data
dir <- "data/"
name <- "dataset"
zip <- paste0(dir, name, ".zip")

if (!dir.exists(dir)) {
    dir.create(dir)
}

if (!file.exists(zip)){
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                  destfile=zip, method="curl")
}
unzip(zip, exdir = dir)

# Load names for coded labels
features <- read.table("data/UCI HAR Dataset/features.txt", header = FALSE, stringsAsFactors = FALSE)[, 2]
labels <- select(read.table("data/UCI HAR Dataset/activity_labels.txt", header = FALSE, stringsAsFactors = FALSE), V2)

# Load test datasets
test_x <- read.table("data/UCI HAR Dataset/test/X_test.txt")
colnames(test_x) <- features
test_y <- read.table("data/UCI HAR Dataset/test/y_test.txt")
test_y <- sapply(test_y, function (x) { labels[x, ] })
colnames(test_y) <- c("activity")
test_subject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
colnames(test_subject) <- c("subject")

# Load train datasets
train_x <- read.table("data/UCI HAR Dataset/train/X_train.txt")
colnames(train_x) <- features
train_y <- read.table("data/UCI HAR Dataset/train/y_train.txt")
train_y <- sapply(train_y, function (x) { labels[x, ] })
colnames(train_y) <- c("activity")
train_subject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
colnames(train_subject) <- c("subject")

# Combine each type of datasets into one
test <- data.table(test_subject, test_x, test_y)
train <- data.table(train_subject, train_x, train_y)

# Merge test and train data
merged <- rbind(test, train)

# Extract measurements of the mean and standard deviation
extracted <- select(merged, matches("mean|std", features), label, subject)

# Create independent tidy data with average of each variable for each activity and each subject
molten <- melt(extracted, id.vars = c("subject", "label"))
tidy <- dcast(molten, activity + subject ~ variable, mean)