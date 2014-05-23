#######################################################################
# Getting and Cleaning Data - Project
# Author: LEAO
#######################################################################
library(data.table)
library(reshape)



# Variables 
filedown<-"data.zip"
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dirFiles<-"./UCI HAR Dataset"
dataSet1<-"data1.txt"
dataSet2<-"data2.txt"

 
# Download the file if doesn´t exists
if(!file.exists(filedown)){
        
        download.file(fileUrl,filedown, mode = "wb")
        
        ## UnZip the files in the folder = "Datos" 
        
        unzip(filedown, files = NULL, list = FALSE, overwrite = TRUE,
              junkpaths = FALSE, exdir = ".", unzip = "internal",
              setTimes = FALSE)
}



# Read feature labels
features <- read.table(paste(dirFiles, 'features.txt', sep = '/'),header = FALSE)
names(features) <- c('id', 'name')

# Read activity labels
activity <- read.table(paste(dirFiles, 'activity_labels.txt', sep = '/'),header = FALSE)
names(activity) <- c('id', 'name')

#######################################################################
##Read the TRAIN
######################################################################
# Read the train X file 
trainX <- read.table(paste(dirFiles, 'train', 'X_train.txt', sep = '/'),header = FALSE)
# Name the columns of trainX  
names(trainX) <- features$name

# Read the subject_train files
subtrain <- read.table(paste(dirFiles, 'train', 'subject_train.txt', sep = '/'),header = FALSE)
names(subtrain)<-"subject"

# Read the train Y file 
trainY <- read.table(paste(dirFiles, 'train', 'Y_train.txt', sep = '/'),header = FALSE)
names(trainY)<-"activity"

#######################################################################
##Read the TEST
######################################################################
# Read the test X file 
testX <- read.table(paste(dirFiles, 'test', 'X_test.txt', sep = '/'),header = FALSE)
# Name the columns of trainX  
names(testX) <- features$name

# Read the subject_train files
subtest <- read.table(paste(dirFiles, 'test', 'subject_test.txt', sep = '/'),header = FALSE)
names(subtest)<-"subject"

# Read the train Y file 
testY <- read.table(paste(dirFiles, 'test', 'Y_test.txt', sep = '/'),header = FALSE)
names(testY)<-"activity"

#######################################################################
#1.Merges the training and the test sets to create one data set.
#######################################################################
# join the data trainX testX,testY,train
dataX  <-rbind(trainX,testX)
dataY  <-rbind(trainY, testY)
dataSub<-rbind(subtrain,subtest)
total<-cbind(dataX,dataSub,dataY)

# Write the fist data set
write.table(total, dataSet1,sep="|")

#######################################################################
#2.Extracts only the measurements on the mean and standard deviation for
#each measurement. 
#######################################################################
totalMS<- total[, c(grep('mean|std', features$name),562,563)]

#######################################################################
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive activity names.
#######################################################################
totalMS["desActivity"]<-activity[totalMS$activity,]$name

#Modify the names of columns appropriately
colnames(totalMS) <- gsub('\\(|\\)',"",names(totalMS))
colnames(totalMS) <- gsub('\\-',"",names(totalMS))

#######################################################################
#5.Creates a second, independent tidy data set with the average of each 
#variable for each activity and each subject 
#######################################################################
# Transpose the mtotalMS data  set

mtotalMS <- melt(totalMS, id=c('subject', 'desActivity'), measured = c("subject","desActivity"))
#Calculate the the average of each variable for each activity and each subject
dtotalMS<-dcast(mtotalMS, desActivity + subject ~ variable, mean)    

# Write the second data set
write.table(dtotalMS, dataSet2,sep = "|")



