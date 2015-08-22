## This is a markdown file for the analysis.R script
This Readme is for the course project of Getting and Cleaning data Course in Coursera <br />

The course project requires us to create a script called run_analysis.R that does the following<br />
1. Merges the training and the test sets to create one data set.<br />
2. Extracts only the measurements on the mean and standard deviation for each measurement.<br /> 
3. Uses descriptive activity names to name the activities in the data set<br />
4. Appropriately labels the data set with descriptive variable names.<br /> 
5. From the data set in step 4, creates a second, independent tidy data set with the average of<br /> 
each variable for each activity and each subject.<br /><br />

Background of Data <br />
The data consist of information gathered from 30 participants who performed 6 acitivites( WALKING,<br /> 
WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone.<br /><br />

Information gathered consist of sensor signals from the accelerometer and gyroscope embedded in <br />
phone body which is then pre-processed by applying noise filters and sampled in fixed-width <br />
sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, <br />
which has gravitational and body motion components, was separated using a Butterworth low-pass <br />
filter into body acceleration and gravity. The gravitational force is assumed to have only low <br />
frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. <br />
From each window, a vector of features was obtained by calculating variables from the time and <br />
frequency domain.<br />

More information on the data manipulated in the course project;<br />
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones<br /><br />

Below details the steps taken in creating a new dataset from the data in the above link.<br />
1) Run the necessary library packages (dplyr, reshape2)to run the script<br />
2) Download the dataset zip file and unzip data<br />
3) Load the names of the variables (features)in the dataset which is found in features.txt (Shown in Readme<br />
of the data downloaded). <br />
4) Rename the names (Variablename)with make.names function as the names in features contain duplicated names. <br />
5) Find the class of each variable (classestr,classeste) for both train and test dataset for faster loading time <br />
6) Load the train and test dataset (train,test)found in X-train.txt and X-test.txt <br />
7) Merge the rows of both dataset (mergeddata) with bind_rows function<br />
8) Input names of the merged dataset <br />
9) Select all data (msdata)from the merged dataset that consist of mean or standard deviation <br />
10) Modify the names (Modname)of selected data to make it more descriptive.<br />
11) Input modified names to selected data set.<br />
12) Load activity labels (activitylabel) found in activity_labels.txt (Shown in Readme)<br />
13) Load the activity data set (activitytrain,activitytest)for both train and test data sets found in y_train.txt and y_test.txt<br />
(Shown in Readme). Merge activity data set (activity)together with function bind_rows <br />
14) Merge the activity data set (activity) with activity labels with merge function. Argument sort is<br />
set to false as we do not want to sort by columns. This will describe the activity resulting in the observation<br />
15) Add the activity data set to the previously selected data set (msdatawlab) with mutate function.<br />
16) Create independent set of data with melt and dcast functions (meltdata, newdata)<br />
17) Export as txt.file with write.table function <br />
