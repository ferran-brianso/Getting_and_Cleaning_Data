#####################################################################
## Script corresponding to 'Getting and Cleaning Data' course project
#####################################################################
##
## Author: ferran.brianso@gmail.com
## Created on:    2015/06/13
## Last modified: 2015/06/21
##
####################################################################
## Here are the data for the project:
##    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
## Download and uncompress the zipped file into your working dir,
## so having a folder "UCI HAR Dataset" there to run this script.
####################################################################


#########################################################################
### 1. LOADING AND MERGING TRAIN AND TEST DATA INTO A SINGLE DATA SET ###
#########################################################################
tmpX1 <- read.table("UCI HAR Dataset/train/X_train.txt")
tmpX2 <- read.table("UCI HAR Dataset/test/X_test.txt")
X <- rbind(tmpX1, tmpX2)

tmpS1 <- read.table("UCI HAR Dataset/train/subject_train.txt")
tmpS2 <- read.table("UCI HAR Dataset/test/subject_test.txt")
S <- rbind(tmpS1, tmpS2)

tmpY1 <- read.table("UCI HAR Dataset/train/y_train.txt")
tmpY2 <- read.table("UCI HAR Dataset/test/y_test.txt")
Y <- rbind(tmpY1, tmpY2)

## Removing temporal data
rm(tmpX1)
rm(tmpX2)
rm(tmpS1)
rm(tmpS2)
rm(tmpY1)
rm(tmpY2)


#########################################################################
### 2.  EXTRACTING ONLY THE MEASUREMENTS ON THE MEAN AND STDEV...     ### 
#########################################################################
feats <- read.table("UCI HAR Dataset/features.txt")
featsOK <- grep("-mean\\(\\)|-std\\(\\)", feats[, 2])
X <- X[, featsOK]
names(X) <- feats[featsOK, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))


#########################################################################
###  3. USING ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET   ###
#########################################################################
acts <- read.table("UCI HAR Dataset/activity_labels.txt")
acts[, 2] = gsub("_", "", tolower(as.character(acts[, 2])))
Y[,1] = acts[Y[,1], 2]
names(Y) <- "activity"


#########################################################################
###  4.   LABELING THE DATA SET WITH DESCRIPTIVE ACTIVITY NAMES       ###
#########################################################################
names(S) <- "subject"
merged <- cbind(S, Y, X)
write.table(merged, "merged_data.txt", row.names = FALSE)


#########################################################################
###  5.  CREATING THE INDEPENDENT TIDY DATA SET WITH AVERAGES...      ###
#########################################################################
numSubs = length(unique(S)[,1])
uniqSubs = unique(S)[,1]
numActs = length(acts[,1])
numCols = dim(merged)[2]
mergedAvg = merged[1:(numSubs*numActs), ]

row = 1
for (s in 1:numSubs) {
  for (a in 1:numActs) {
    mergedAvg[row, 1] = uniqSubs[s]
    mergedAvg[row, 2] = acts[a, 2]
    tmp <- merged[merged$subject==s & merged$activity==acts[a, 2], ]
    mergedAvg[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(mergedAvg, "final_averages.txt", row.names = FALSE)
mergedAvg[1:12, 1:5]
dim(mergedAvg)
mergedAvg[180, 1:5]
