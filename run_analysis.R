#License:
# ========
# Use of this dataset in publications must be acknowledged by referencing the following publication [1]
#
#[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity
#Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International
#Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
#
#This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the
#authors or their institutions for its use or misuse. Any commercial use is prohibited.
#
#Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
#
#

rm(list=ls())
#setwd("~\Documents\DataScienceSpec\GettingAndCleaningData\PerAssesment1")

# Following does not work on my Win 8 box. If you cannot download via R, then download the file and 
# extract it. The following code assumes working directory is at the root of the extracted zip file.
# url <- "https://d396qusza40orc.cloudfront.net/getdata-projectfiles-UCI HAR Dataset.zip"
# zFile <- download.file(url,dest,method="curl")

# Set up paths for the various files we need to read.
wd <- normalizePath(getwd() ,"\\")

trainPath <- "\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\"
testPath <- "\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\"
mainPath <- "\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\"

testFiles <- c( "X_test.txt", "subject_test.txt", "y_test.txt")
trainFiles <- c( "X_train.txt", "subject_train.txt", "y_train.txt")

# Read in the labels and feature names
activityLabels <- data.frame(read.table(file=paste(wd,mainPath,"activity_labels.txt",sep="")))
colnames(activityLabels) <- c("ActivityCode","Activity")
features <- data.frame(read.table(file=paste(wd,mainPath,"features.txt",sep="")))

# Read in the data files and the associated subject and activity data and column bind into a single dataframe 
dFile <- data.frame(read.table(file=paste(wd,testPath,testFiles[1],sep="")))
colnames(dFile) <- features[,2]
sFile <- data.frame(read.table(file=paste(wd,testPath,testFiles[2],sep="")))
colnames(sFile) <- c("Subject")
yFile <- data.frame(read.table(file=paste(wd,testPath,testFiles[3],sep="")))
colnames(yFile) <- c("ActivityCode")

testFile <- cbind(dFile,sFile)
testFile <- cbind(testFile,yFile)

dFile <- data.frame(read.table(file=paste(wd,trainPath,trainFiles[1],sep="")))
colnames(dFile) <- features[,2]
sFile <- data.frame(read.table(file=paste(wd,trainPath,trainFiles[2],sep="")))
colnames(sFile) <- c("Subject")
yFile <- data.frame(read.table(file=paste(wd,trainPath,trainFiles[3],sep="")))
colnames(yFile) <- c("ActivityCode")

trainFile <- cbind(dFile,sFile)
trainFile <- cbind(trainFile,yFile)

# Row bind to merge the test and training data and ensure the column names are uniue
allFile <- rbind(testFile,trainFile)
colnames(allFile) <-  make.names(colnames(allFile),unique=TRUE)

# From the list of feature names, extract a list of names with either 'std' or 'mean' in them, per the 
# instructions for the assignment.
cl <- data.frame(colnames(allFile),seq(1:length(colnames(allFile))))
ml <- cl[grepl('mean',ignore.case=TRUE,cl[,1]),]
sl <- cl[grepl('std',ignore.case=TRUE,cl[,1]),]
xl <- rbind(ml,sl)
colnames(xl) <- c("cn","Ordering")
xl <- xl[order(xl$Ordering),]


# Using dplyr, select only the columns of interest to us - Subject, ActivityCode and the std and mean columns
library(dplyr)

outFile <- select(allFile,matches("Subject"))
outFile <- cbind(outFile,select(allFile,matches("ActivityCode")))

for (i in 1:nrow(xl)) {
        aColName <- as.character(xl$cn[i])
        outFile <- cbind(outFile, select(allFile, matches(aColName)))
}

# Merge in the Activity labels for human readability
outFile <- merge(activityLabels,outFile,"ActivityCode")

# Finally, compute the means of all the data grouped by Subject and Activity. Note the means of some of the 
# data are nonsensical, but that is the asssignment.
attach(outFile)
tidyData <-aggregate(outFile[,4:93], by=list(Subject=Subject,Activity=Activity),FUN=mean, na.rm=TRUE)
detach(outFile)
head(tidyData[,1:9],70) # visual check 
write.table(tidyData,file="tidyData.txt")

# Clean up the environment
mlist <- ls()
mlist <- mlist[!mlist=="tidyData"]
rm(list=mlist)
rm(mlist)
