####################################################################
##  Oliver Zarate,  October 29, 2018 
##  Coursera R Getting and Cleaning data Week 4, Data Course Project
## Reading & tidying data from:
## Human Activity Recognition Using Smartphones Data Set   
#####################################################################
# code reads in various datasets to create a tidy final set 
# each step is broken down and described below
#####################################################################
install.packages("tidyverse")
library(tidyverse)
# required for summarize - library called
install.packages("fansi")  
library(fansi)
#####################################################################
## preprocessing step - read in datasets and combine into data frame -
## read in training dataset, training labels(activity), training 
## subject(subject indentifier), test dataset, test labels(activity), 
## and test subject (identifier).
#####################################################################

setwd("~/Data Science/Johns Hopkins DS Specialization/Getting and cleaning data/week 4/wear_proj/UCI HAR Dataset/train")
## read in training data and training labels
train.data<- read.table(file="X_train.txt",header = FALSE,sep = "")
train.label<-read.table(file="y_train.txt",header = FALSE,sep = "")
train.subject<- read.table(file="subject_train.txt",header= FALSE,sep = "") # subject labels
## read in test data & test lables
setwd("../test")  # go to the test folder
test.data<- read.table(file="X_test.txt",header = FALSE,sep = "")
test.label<-read.table(file="y_test.txt",header = FALSE,sep = "")
test.subject <- read.table(file="subject_test.txt",head = FALSE,sep = "") # subject labels
## pull in feature vector
setwd("../")  # go to to main folder
features<- read.table(file="features.txt",header = FALSE,sep = "")
## add activity label feature vector to training and test set
train.data$activity<-train.label[,1]
test.data$activity<-test.label[,1]
## add subject label feature vector to training and test set
train.data$subject<-train.subject[,1]
test.data$subject<-test.subject[,1]

##########################################################
## Step 1 - join datasets (test and train)
##########################################################
combined.data<-rbind(train.data,test.data)

## assign column names from feature dataframe. Keep activity & subject
colnames(combined.data)[1:561]<-as.character(features[,2])
##########################################################
## Step 2 - extract measurements with only mean or standard deviation
##########################################################
## identify column names with mean or std
keep.cols<-grep("[Mm]ean|std",names(combined.data))
# append column list to include activity & subject vector
keep.cols<- c(keep.cols,which(colnames(combined.data)=="activity"|colnames(combined.data)=="subject"))
# reduce number of features to include on mean or std
combined.data<-combined.data[,keep.cols]
#############################################################################
## Step 3 - Uses descriptive activity names to name the activities in the 
## data set
## 1st create a dataframe with activity number and activity 
## description. Then join with combined dataframe and remove original feature 
## vector of activity number
##########################################################
act.list <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS"
              ,"SITTING","STANDING","LAYING")

activity.df <- data.frame(activity=  seq(1:6),activity.name=act.list)
## joining dataset with activity list data frame, then join and remove 
combined.data<-combined.data %>% 
    left_join(activity.df,by="activity") %>% 
    select(-activity)  

##########################################################
## Step 4 - add descriptive labels to variable names
##########################################################
new.varset<-names(combined.data)                # assign name to temp vector
#new.varset<-sapply(new.varset,tolower)          # make all characters lower case
new.varset<-gsub("^t|\\(t","time.",new.varset)  # add time label 
new.varset<-gsub("^f","frequency.",new.varset)           # add frequency label
new.varset<-gsub("BodyBody","body",new.varset)           # remove redundant Body
new.varset<-gsub("[Bb]ody","body.",new.varset)      
new.varset<-gsub("Gravity","gravity.",new.varset)
new.varset<-gsub(".Acc",".accelerometer.",new.varset)
new.varset<-gsub(".Gyro",".gyroscope.",new.varset)
new.varset<-gsub("Mag","magnitude",new.varset)
new.varset<-gsub("Jerk","jerk.",new.varset)
new.varset<-gsub("Mean","mean",new.varset)              # making 'mean' lower case
new.varset<-gsub("\\(|\\)","",new.varset)               # remove all parenthesis
new.varset<-gsub("Freq",".frequency",new.varset)                  # remove redundant frequency identifier
new.varset<-gsub("gravitymean","gravity.mean",new.varset)
new.varset<-gsub("std","standard_deviation",new.varset)
# axis labels
new.varset<-gsub("X","x.axis",new.varset)
new.varset<-gsub("Y","y.axis",new.varset)
new.varset<-gsub("Z","z.axis",new.varset)

## clean angle feature names
new.varset<-gsub("^angle","angle_between:",new.varset)  # description of angle measurement
new.varset<-gsub(",",".&.",new.varset)                  # providing demarkation of '&' 

# clean trailing "."
new.varset<-gsub("\\.-",".",new.varset)                 # remove trailing '.'

## assign updated variable names 
names(combined.data)<-new.varset

##########################################################
## Step 5 - summarise and create tidy dataset
##########################################################
 
## group to summarise and calculate average
tidy.combined.df<-combined.data %>% 
    group_by(activity.name,subject) %>% 
    summarise_all(mean)


