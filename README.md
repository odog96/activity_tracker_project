###activity_tracker_project
pull and tidy data for tracking

Oliver Zarate,  October 29, 2018 
Coursera R Getting and Cleaning data Week 4, Data Course Project
Reading & tidying data from:
Human Activity Recognition Using Smartphones Data Set   

original data from :
*Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.*
activityrecognition@smartlab.ws
www.smartlab.ws

The objective of the excercise was to readin and tidy data from the 
aforementioned experiment read from smartphones strapped to 30 subjects waist during various 
activities. 
reading data
The following is a list and description of all files read-in to build out required tidy data set.
The dataset spanned various files that included seperate:
test data - all featureset data assigned to test set
training data - same format, but assigned to training set
features.txt - file contained the column names only. In the same order as the prior column data.
test label - single vector for numeric identifier of activity for each record. In same row-wise order
             as test and training data.
training label - same as test label  but corresponding to training data set
test subject - single vector for numeric identifier of subject for test set. In same order as 
                  corresponding training data set
training subject - single vector for numeric identifier of subject for training set set. In same order as 
                  corresponding training data set
                  
                  
                  
                  


test and training data set were read in via readtable commands.

additional 


