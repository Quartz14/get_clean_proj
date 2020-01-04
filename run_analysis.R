
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="Dataset.zip")
unzip("Dataset.zip")


# part 1 join train and test data
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

head(test_x)
length(test_x) # 561 columns. labels of columns in features.txt
length(test_y$V1)
head(test_y)
names(test_y) # Row names of subject in subject_test.txt
#meaning of activity number in activity_label.txt
X <- rbind(train_x,test_x)
Y <- rbind(train_y,test_y)
subject <- rbind(train_subject,test_subject) 
length(X$V1)
length(Y$V1)
length(subject$V1)
names(Y)
names(subject) <- c("subject")
tail(Y)
tail(subject)


# Part 2 extract mean,std cols
features <- read.table("UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
x_names <-features$V2
head(x_names)
x_names <- tolower(x_names)
x_names <- gsub("-","",x_names)
x_names <- gsub(",","",x_names)

#select mean,std col
col <- x_names[grepl("mean\\(\\)|std\\(\\)",x_names)]
length(col)
length(X)
names(X)
subset_data_x <- X[,col] 
subset_data_x[is.na(subset_data_x)]
short_x_names <- names(subset_data_x)
short_x_names <- gsub("\\(","",short_x_names)
short_x_names <- gsub("\\)","",short_x_names)
names(subset_data_x) <- short_x_names 


# part 3 adding acitivity labels to y data
head(Y)
names(Y) <- c("activitycode")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
activity_labels
clean_activity <- tolower(activity_labels[,2])
clean_activity <- gsub("_","",clean_activity)
activity_labels$V2 <- clean_activity
names(activity_labels) <- c("code","activity")
new_y <- activity_labels[Y[,1],2]
length(new_y)

#part 4 appropriate labels
clean_df <- cbind(person=subject$subject,subset_data_x,activity = new_y)
length(clean_df)
names(clean_df)
clean_df[is.na(clean_df)]
tail(clean_df,1)
clean_df[is.na(clean_df)]
write.table(clean_df,"clean_data.csv",sep=",",row.names = FALSE)
write.table(clean_df,"clean_data.txt",row.names = FALSE)

# part 5 summarizing data by activity,person
summary_clean_df <- aggregate(clean_df,by=list(action=clean_df$activity,subject=clean_df$person),FUN = mean)
summary_clean_df <- subset(summary_clean_df, select = -c(person, activity))
length(summary_clean_df$action)
names(summary_clean_df)


