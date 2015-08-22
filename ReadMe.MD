## This is a markdown file for the analysis.R script
This Readme is for the course project of Getting and Cleaning data Course in Coursera

The course project requires us to create a script called run_analysis.R that does the following
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of 
each variable for each activity and each subject.

Background of Data 
The data consist of information gathered from 30 participants who performed 6 acitivites( WALKING, 
WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone.

Information gathered consist of sensor signals from the accelerometer and gyroscope embedded in 
phone body which is then pre-processed by applying noise filters and sampled in fixed-width 
sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, 
which has gravitational and body motion components, was separated using a Butterworth low-pass 
filter into body acceleration and gravity. The gravitational force is assumed to have only low 
frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
From each window, a vector of features was obtained by calculating variables from the time and 
frequency domain.

More information on the data manipulated in the course project;
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Below details the steps taken in creating a new dataset from the data in the above link.
1) Run the necessary library packages (dplyr, reshape2)to run the script
2) Download the dataset zip file and unzip data
3) Load the names of the variables (features)in the dataset which is found in features.txt (Shown in Readme
of the data downloaded). 
4) Rename the names (Variablename)with make.names function as the names in features contain duplicated names. 
5) Find the class of each variable (classestr,classeste) for both train and test dataset for faster loading time 
6) Load the train and test dataset (train,test)found in X-train.txt and X-test.txt
7) Merge the rows of both dataset (mergeddata) with bind_rows function
8) Input names of the merged dataset 
9) Select all data (msdata)from the merged dataset that consist of mean or standard deviation 
10) Modify the names (Modname)of selected data to make it more descriptive.
11) Input modified names to selected data set.
12) Load activity labels (activitylabel) found in activity_labels.txt (Shown in Readme)
13) Load the activity data set (activitytrain,activitytest)for both train and test data sets found in y_train.txt and y_test.txt
(Shown in Readme). Merge activity data set (activity)together with function bind_rows 
14) Merge the activity data set (activity) with activity labels with merge function. Argument sort is
set to false as we do not want to sort by columns. This will describe the activity resulting in the observation
15) Add the activity data set to the previously selected data set (msdatawlab) with mutate function.
16) Create independent set of data with melt and dcast functions (meltdata, newdata)
17) Export as txt.file with write.table function 
