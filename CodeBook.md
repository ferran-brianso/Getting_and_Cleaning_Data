Getting and Cleaning Data Course Project Code Book

Original data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Data description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The attached R script (run_analysis.R) performs the following steps to merge and clean up the data:

1.1* Loads "X_train.txt" and "X_test.txt" and merges them with rbind function.
1.2* Loads "subject_train.txt" and "subject_test.txt" and merges them with rbind.
1.3* Loads "y_train.txt" and "y_test.txt" And merges them with rbind.

2.1* Loads the "features.txt" file and extracts only the measurements on the mean and standard deviation with grep.
2.2* Cleans brachets '()' with gsub and puts all names to lower case with tolower.

3.1* Reads activity labels from file "activity_labels.txt". 
3.2* Cleans the activity labels without underscores '_' and as lower case.
3.3* Renames the Y data set with these activity names.

4.1* Merges X values, subjects and Y values into a tiny data set named (merged).
4.2* Saves this data set as file "merged_data.txt" using function write.table.

5.1* Creates a second, independent tidy data set (mergedAvg) with the average of each measurement for each activity and each subject.
5.2* Saves it as the file named "final_averages.txt" using function write.table.
