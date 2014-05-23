
# CodeBook - Getting and Cleaning Data Project

## Sources

For this program is used some data collected from the accelerometers from the Samsung Galaxy S smartphone.
If you want more description visit the webpage: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The "run_analysys.R" program: 

        * download the file from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
        * unzip the file on folder: "UCI HAR Dataset"
        
                The files from the zip used are: 
                - 'features.txt': List of all features.
                - 'activity_labels.txt': Links the class labels with their activity name.
                - 'train/X_train.txt': Training set.
                - 'train/y_train.txt': Training labels.
                - 'test/X_test.txt': Test set.
                - 'test/y_test.txt': Test labels.
                - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
                - 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
                
## Variables

* features
 - id: key 
 - name: name of the feature 
* activity
 - id:key
 - name: name of the activity. Like walking, sitting, etc
* trainX
 - all the names of features are the columns in this table
* testX
 - all the names of features are the columns in this table
* trainY
 - activity: the id of the activity
* testY
 - activity: the id of the activity
* subtest y subtrain 
 - subject: id of the subject
 

## Transformation: 

1. if the file "data.zip" doesn´t exist:
        - download the file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip with the name "data.zip"
        - unzip the file in the folder: "UCI HAR Dataset"
2. Read the files from a file to a variable in R:
                - 'features_info.txt' to features
                - 'activity_labels.txt' to activity
                - 'train/X_train.txt' to trainX
                - 'train/y_train.txt'to trainY
                - 'test/X_test.txt' to testX
                - 'test/y_test.txt' to testY
                - 'train/subject_train.txt'to subtrain
                - 'test/subject_test.txt' to subtest
                
3. The columns of trainX and testX are renamed by information on the features.names rows. 

4. Merge the training and the test sets to create one data set. To obtain this rbind y cbind is used to conmbine the information.

5. The data set obtained in the previous step is wrtied in the data1.txt file. 

6. Then the measurements on the mean and standard deviation for each measurement are obtained and saved to totalMS variable.

7. The column "desActivity" is added to the totalMS variable. desActivity describe the activity and this description is obtained from the variable activity. 

8. The pharentesys and "-"s are eliminated from the columns  to make the variable usable.

9. Make the a second data set  with the average of each variable for each activity and each subject. For this, it Transpose the information using 'subject'and  'desActivity' as ids, then  the average of each variable for each activity and each subject are calculated and saved into dtotalMS

10. The second data set is saved as data2.txt

Code book<- describes the variables, the data, and any transformations or work that you performed to clean up the data

##Annex

- The columns bandsEnergy are duplicated, but doesn´t matter because there aren´t used in this program.
- the names of variables combines capital and tiny letters for better lecture.
