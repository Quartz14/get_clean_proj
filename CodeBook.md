---
title: "CodeBook.md"
---

# Variables used

train_x stores the x data in train directory
train_y stores the y data in train directory
train_subject stores the subject data in train directory

test_x stores the x data in test directory
test_y stores the y data in test directory
test_subject stores the subject data in test directory

X stores the combined x data
Y stores the combined y data
subject stores the combined subject data 

features stores feature file data
x_names store the feature, used for cleaning
col column names with mean(), std() used to suset X data
subset_data_x X data with only mean, std columns
short_x_names used to remove () from column names od subset_data_x

activity_labels stores the activity file data
clean_activity used to clean the activity_labels by converting to lowercase, and removing "_"
new_y is the Y data with numbers replaced with activity names

clean_df  cleaned dataset with X,Y,subject data
summary_clean_df store the mean for the columns in clean_df, by subject and activity

## Procedure followed to clean dataset
The dataset consiste of 2 folders train,test. Each folder has 3 text files called subject, x,y.
Subject refers to the person who performed the task. X has the measurement values, y has the activity performed.

1) We join these 3 tables in train directory with test directory, to get an unified dataset.
There is a features.txt and its information file, explaining each measurement column.
We use this to provide meaningful column names to the x data

2) The clean dataset has only mean, std column of each feature. This is done by useing regular expressions to subset the joined x dataset and create a subset called "subset_data_x"
We modify the vairable names to make it easier to call later, the changes are: 
  Convert to lower case, replace "-","," with ""
  After subsetting the data, we relace "(",")" with ""
  
3) Next we convert the y data to its activity names. This is achieved by adding the rows of y data to the activity table, to form a new list with activity names instead of numbers.
Suitable column names are provided

4) Next, we create the clean dataset by joining the x,y (with activity names),subject tables column wise.
we check the column names to verify they are in lowercase, without any special charecters.
then we check if any null values are present
After this we write the clean table as "clean_data.csv"

5) To create the summary we use aggregate function in R. We use activity and subject columns(renamed as person), to group the row, and find mean for each feature, in the clean data.
The summary has the mean values for each feature, for each person for each activity.

