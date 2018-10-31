**activity_tracker_project**

**Oliver Zarate,  October 29, 2018 
Coursera R Getting and Cleaning data Week 4, Data Course Project
Reading & tidying data from:
Human Activity Recognition Using Smartphones Data Set**   

original data from :
*Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.*
activityrecognition@smartlab.ws
www.smartlab.ws

**Objective**
The objective of the excercise was to read in and tidy data from the aforementioned experiment using smartphones strapped to 30 subjects' waists during various activities. 
**Reading data**
The following is a list and description of all files read-in to build out required tidy data set.
The dataset spanned various files that included seperate:
test data - all featureset data assigned to test set
- training data : same format, but assigned to training set
- features.txt  : file contained the column names only. In the same order as the prior column data.
- test label    : single vector for numeric identifier of activity for each record. In same row-wise order
             as test and training data.
- training label : same as test label  but corresponding to training data set
- test subject : single vector for numeric identifier of subject for test set. In same order as 
                  corresponding training data set
- training subject : single vector for numeric identifier of subject for training set set. In same order as 
                  corresponding training data set

**Configuring initial dataset**
 Once the aforementioned files have been ingested, the dataframes are merged. To begin with two data frames - test.data and training.data - are built. For each data set i add the activity vector as well as subject vector. 
 *Step 1 - Join test and trianing data.* 
 At this point I merge both data and test set into single data frame, using rbind (row binding command in r). 
 I then use the feature list (brought in as a dataframe) from .txt file and extract feature name list, which 
 I pass to the merged dataset ("combined.data")
 **Transform data**
 *Step 2 - extract mean and standard deviation*
This step requires extracting features/variables that are only means or standard deviations. For this, I use "grep" command
and look at variable names that have either any of the  following words : Mean, mean, std. The new dataframe is subset to include
only such, mean and standard deviation variables.
 *Step 3 - Uses descriptive activity names to name the activities*
 This step required a change to the activity number identifier to an actual, descriptive, activity name. To accomplish this, I created a new, small data frame, with the actual required activity names. A second vector was the activity number identifier - 1 - 6 digits.
Using tidy pipe commands I joined this smaller dataframe with the prior "combined.data" dataframe, and the removed the original activity number identifier. Values were re-assigned to combined.data dataframe.
**Step 4 - add descriptive labels to variable names**
 Instead of using encoded variable names, this step required a more descriptive approach. I used exclusively the "gsub" command to 
 methodically remove and acronyms and replace with full names. Additionally all parenthesis were removed, all names were made to be lower case. 
 **Summarize and tidy data**
 The final step required averages for all measurement variables grouped by every activity and subject combination. Further the instructions required a tidy dataset be submitted. This can be found as the file titled tidy_combined_data.csv. One note worth
 mentioning: there were some discussions on the formum weather this summary was considered tidy or a further breakout of variables was required. My interpretation after reading this summary was that the "wide" format was indeed tidy. 


