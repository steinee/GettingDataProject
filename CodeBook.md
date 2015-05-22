---
title: "CodeBook"
author: "Erik E Stein"
date: "Friday, May 22, 2015"
output: html_document
---

This codebook contains these sections:

* Background
* License
* Analysis
* Feature Descriptions
* Original Feature Selection


Background:
===========
This file describes the data and processing used in the Course Project for Getting and Cleaning Data. 
The data in this project is sourced from an experiment conducted by conducted by the UCI Machine Learning 
Laboratory and you can find references to the background and data here:

*** http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

The experiment consisted of placing 30 subjects into 6 different "activity" states and sampling the accelerameter
and gyrosope signals from smartphones attached to their wrists. The raw data underwent considerable processing 
which can be described as having three phases:
  1) Filtering to remove noise and removal of gravity from the accelerometer data.
  2) Time domain derivatives taken to derive jerk of both lenear and angular acceleration and a Fast Fourier Transform (FFT) to obtain frequency domain signals.
  3) Derivation of the feature vector from the collection of time and frequency domain data.

See the Feature Selection section below for the original description of the processing, reproduced here for your convenience.

The above data serves as the inputs to this project, the goal of which is to produce a tidy data set.

This file and the attendant R script only concern themselves with the details of processing the above data for the creation of the tidey data set. 

Here is the obligatory license for use of the data.

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity
Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International
Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the
authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

Analysis:
=========

I was unable to download a clean version of the data set on on my Win 8 box using R, so I downloaded the file
manually from here:
*** url <- "https://d396qusza40orc.cloudfront.net/getdata-projectfiles-UCI HAR Dataset.zip"

I extracted the data, which has both training and test data spread through multiple levels of subdirectories.
The accompanying R script assumes the R working directory is at the root of the extracted zip file. The data for both training and test are similar in that there is 1) the actual feature vector of 561 features, 2) identifiers (anonymized) for the 30 subjects and 3) human readable activity labels that correspond to the rows in the set of feature vectors.

The test files and training files were read and the feature vectors merged with the subject IDs and the activity labels to produce two data frames of identical columns, one for test and one for training. These two dta frames were then combined to crete a single data frame of all the test and training data. Note that the resulting column names may have been slightly altered due to ensuring the names were unique.

As the project assignment directed we extract means and standard devation variables from the data, I read in the full list of feature vector variables and created a vector of variable names that had either 'mean' or 'std' in them. This was used to select the desired columns from the original data set using dplyr. Then the human readable activity labels were merged into the data.

Finally, the means of all the data grouped by Subject and Activity were computed. Note that the means of some of the 
data are nonsensical, but that is what the asssignment called for. This final file was written out in text form. The data are grouped by Activity, then by Subject e.g. all "WALKING" data are grouped together.

The R script cleans up its environment and removes all data sets other than the final one. This code can be removed if one desires to examine any of the intermediate results.

Feature Descriptions:
=====================
In R, column 1 is integer, column 2 is a factor. All others are numerics.


1                              Activity One of 6 possible values:
*                                                  WALKING
*                                                  WALKING_UPSTAIRS
*                                                  WALKING_DOWNSTAIRS
*                                                  SITTING
*                                                  STANDING
*                                                  LAYING
2                               Subject Integer from 1 to 30 identifying a test subject

All of the below featuers are either means or stndard deviations as indicated by the name. Importantly, note that the input data for this project was normalized to the range -1 to 1. That is, all the variables were altered by subtracting thei means to center them around zero and then divided by the range of the data to normalize the range to -1 to 1. Thus, some standard deviations will appear here as negative. This processing was performed to make the data more suitable for machine learning.
3                     tBodyAcc.mean...X
4                     tBodyAcc.mean...Y
5                     tBodyAcc.mean...Z
6                      tBodyAcc.std...X
7                      tBodyAcc.std...Y
8                      tBodyAcc.std...Z
9                  tGravityAcc.mean...X
10                 tGravityAcc.mean...Y
11                 tGravityAcc.mean...Z
12                  tGravityAcc.std...X
13                  tGravityAcc.std...Y
14                  tGravityAcc.std...Z
15                tBodyAccJerk.mean...X
16                tBodyAccJerk.mean...Y
17                tBodyAccJerk.mean...Z
18                 tBodyAccJerk.std...X
19                 tBodyAccJerk.std...Y
20                 tBodyAccJerk.std...Z
21                   tBodyGyro.mean...X
22                   tBodyGyro.mean...Y
23                   tBodyGyro.mean...Z
24                    tBodyGyro.std...X
25                    tBodyGyro.std...Y
26                    tBodyGyro.std...Z
27               tBodyGyroJerk.mean...X
28               tBodyGyroJerk.mean...Y
29               tBodyGyroJerk.mean...Z
30                tBodyGyroJerk.std...X
31                tBodyGyroJerk.std...Y
32                tBodyGyroJerk.std...Z
33                   tBodyAccMag.mean..
34                    tBodyAccMag.std..
35                tGravityAccMag.mean..
36                 tGravityAccMag.std..
37               tBodyAccJerkMag.mean..
38                tBodyAccJerkMag.std..
39                  tBodyGyroMag.mean..
40                   tBodyGyroMag.std..
41              tBodyGyroJerkMag.mean..
42               tBodyGyroJerkMag.std..
43                    fBodyAcc.mean...X
44                    fBodyAcc.mean...Y
45                    fBodyAcc.mean...Z
46                     fBodyAcc.std...X
47                     fBodyAcc.std...Y
48                     fBodyAcc.std...Z
49                fBodyAcc.meanFreq...X
50                fBodyAcc.meanFreq...Y
51                fBodyAcc.meanFreq...Z
52                fBodyAccJerk.mean...X
53                fBodyAccJerk.mean...Y
54                fBodyAccJerk.mean...Z
55                 fBodyAccJerk.std...X
56                 fBodyAccJerk.std...Y
57                 fBodyAccJerk.std...Z
58            fBodyAccJerk.meanFreq...X
59            fBodyAccJerk.meanFreq...Y
60            fBodyAccJerk.meanFreq...Z
61                   fBodyGyro.mean...X
62                   fBodyGyro.mean...Y
63                   fBodyGyro.mean...Z
64                    fBodyGyro.std...X
65                    fBodyGyro.std...Y
66                    fBodyGyro.std...Z
67               fBodyGyro.meanFreq...X
68               fBodyGyro.meanFreq...Y
69               fBodyGyro.meanFreq...Z
70                   fBodyAccMag.mean..
71               fBodyAccMag.meanFreq..
72                    fBodyAccMag.std..
73             fBodyAccMag.meanFreq...1
74           fBodyBodyAccJerkMag.mean..
75       fBodyBodyAccJerkMag.meanFreq..
76            fBodyBodyAccJerkMag.std..
77     fBodyBodyAccJerkMag.meanFreq...1
78              fBodyBodyGyroMag.mean..
79          fBodyBodyGyroMag.meanFreq..
80               fBodyBodyGyroMag.std..
81        fBodyBodyGyroMag.meanFreq...1
82          fBodyBodyGyroJerkMag.mean..
83      fBodyBodyGyroJerkMag.meanFreq..
84           fBodyBodyGyroJerkMag.std..
85    fBodyBodyGyroJerkMag.meanFreq...1
86          angle.tBodyAccMean.gravity.
87 angle.tBodyAccJerkMean..gravityMean.
88     angle.tBodyGyroMean.gravityMean.
89 angle.tBodyGyroJerkMean.gravityMean.
90                 angle.X.gravityMean.
91                 angle.Y.gravityMean.
92                 angle.Z.gravityMean.

Original Feature Selection: 
===========================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The above explanation and a further description of the original variables is in 'feature_info.txt' at the UCI site.
The complete list of variables of each feature vector is available in 'features.txt' at the UCI site.

