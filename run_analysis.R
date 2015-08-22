## This is a R script that tidies the data set collected from the accelerometers
## from the Samsung Galaxy S smartphone. 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## run library package dplyr
library(dplyr)
library(reshape2)

##Create directory called data and download zip file from the net and unzip
if(!file.exists("./data"))
        {
        dir.create("./data")        
        }
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(url,destfile = "./data/Dataset.zip", mode = "wb")
unzip("./data/Dataset.zip", exdir = "./data")

##Names of the variables (or measures) are found in features.txt
features<-read.table("./data/UCI HAR Dataset/features.txt")

##Names of the variables requires modification as it contains duplicated names
Variablename<-make.names(features[[2]],unique=TRUE)

##Data size is about 57mb. To reduce loading time, find classes of datasets.
findclassoftrain<-read.table("./data/UCI HAR Dataset/train/X_train.txt",nrows=100,stringsAsFactors=FALSE)
findclassoftest<-read.table("./data/UCI HAR Dataset/test/X_test.txt",nrows=100,stringsAsFactors=FALSE)

classestr<-sapply(findclassoftrain,class)
classeste<-sapply(findclassoftest,class)

##Load training and test data 
train<-read.table("./data/UCI HAR Dataset/train/X_train.txt",colClasses=classestr)
test<-read.table("./data/UCI HAR Dataset/test/X_test.txt",colClasses=classeste)

##Merge data
mergeddata<-bind_rows(train,test)

#Give names to dataset
names(mergeddata)<-Variablename

#Extract only mean and std observations from dataset 
msdata<-select(mergeddata,contains("mean"),contains("std"))

##To modify variable names to make it descriptive
Modnames<-names(msdata)
Modnames<-sub("....","",Modnames,fixed=TRUE)
Modnames<-sub("...","",Modnames,fixed=TRUE)
Modnames<-sub("..","",Modnames,fixed=TRUE)
Modnames<-sub(".","",Modnames,fixed=TRUE)
Modnames<-sub("mean","",Modnames,fixed=TRUE)
Modnames<-sub("Mean","",Modnames,fixed=TRUE)
Modnames<-sub("BodyBodyGyro","BodyGyro",Modnames,fixed=TRUE)
Modnames<-sub("BodyGyro"," BodyGyro",Modnames,fixed=TRUE)
Modnames<-sub("BodyAcc"," BodyAcc",Modnames,fixed=TRUE)
Modnames<-sub("std"," std",Modnames,fixed=TRUE)
Modnames<-sub("GravityAcc", " GravityAcc",Modnames,fixed=TRUE)
Modnames<-sub("Mag", " Mag",Modnames,fixed=TRUE)
Modnames<-sub("Jerk", " Jerk",Modnames,fixed=TRUE)
Modnames<-sub("anglet", "Angle",Modnames,fixed=TRUE)
Modnames<-sub("angle", "Angle",Modnames,fixed=TRUE)
Modnames<-sub(".gravity.", " Gravity",Modnames,fixed=TRUE)
Modnames<-sub(".gravityMean.", " Gravity",Modnames,fixed=TRUE)
Modnames<-sub("gravityMean.", " Gravity",Modnames,fixed=TRUE)
Modnames<-sub("Freq", " Freq",Modnames,fixed=TRUE)
Modnames<-sub("X", " XAXIS",Modnames,fixed=TRUE)
Modnames<-sub("Y", " YAXIS",Modnames,fixed=TRUE)
Modnames<-sub("Z", " ZAXIS",Modnames,fixed=TRUE)
Modnames<-sub("fBody", "f",Modnames,fixed=TRUE)

names(msdata)<-Modnames
              
#Load activity labels that links activity set to activity name
activitylabel<-read.table("./data/UCI HAR Dataset/activity_labels.txt")

#Load and merge activity set for both train and test datasets (with the train set as first argument)
activitytrain<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
activitytest<-read.table("./data/UCI HAR Dataset/test/y_test.txt")

activity<-bind_rows(activitytrain, activitytest)

#Merge activity set with activity labels together and NOT sort them. 
activity<-merge(activity,activitylabel,all=TRUE,sort=FALSE)

#Mutate Merged data, msdata, by mutating to add activity. This will identifying 
#the observations in the merged data with the corresponding activity.
msdatawlab<-mutate(msdata, Activity = activity[[2]])

##Create independent set of data with average of each variable for each activity and subject
## Doing this by melt and dcast function from reshape2 package

meltdata<-melt(msdatawlab,id="Activity",measure.vars=Modnames)
newdata<-dcast(meltdata,Activity~ variable,mean)
        
write.table(newdata,"newdata.txt",row.name=FALSE)
