
# Source of data for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This R script does the following:

#0 Read test and training data into R:

testData_X <- read.table("C:\Users\Indre\Documents\RStudio\Getting_and_cleaning_data\UCI HAR Dataset\test\X_test.txt",header=FALSE)
testData_Y <- read.table("C:\Users\Indre\Documents\RStudio\Getting_and_cleaning_data\UCI HAR Dataset\test\y_test.txt",header=FALSE)
testData_subj <- read.table("C:\Users\Indre\Documents\RStudio\Getting_and_cleaning_data\UCI HAR Dataset\test\subject_test.txt",header=FALSE)
trainData_X <- read.table("C:\Users\Indre\Documents\RStudio\Getting_and_cleaning_data\UCI HAR Dataset\train\X_train.txt",header=FALSE)
trainData_Y <- read.table("C:\Users\Indre\Documents\RStudio\Getting_and_cleaning_data\UCI HAR Dataset\train\y_train.txt",header=FALSE)
trainData_subj <- read.table("C:\Users\Indre\Documents\RStudio\Getting_and_cleaning_data\UCI HAR Dataset\train\subject_train.txt",header=FALSE)

# 3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("C:\Users\Indre\Documents\RStudio\Getting_and_cleaning_data\UCI HAR Dataset\activity_labels.txt",header=FALSE,colClasses="character")
testData_Y$V1 <- factor(testData_Y$V1,levels=activities$V1,labels=activities$V2)
trainData_Y$V1 <- factor(trainData_Y$V1,levels=activities$V1,labels=activities$V2)

# 4. Appropriately labels the data set with descriptive activity names

features <- read.table("C:\Users\Indre\Documents\RStudio\Getting_and_cleaning_data\UCI HAR Dataset\features.txt",header=FALSE,colClasses="character")
colnames(testData_X)<-features$V2
colnames(trainData_X)<-features$V2
colnames(testData_Y)<-c("Activity")
colnames(trainData_Y)<-c("Activity")
colnames(testData_subj)<-c("Subject")
colnames(trainData_subj)<-c("Subject")

# 1. merge test and training sets into one data set, including the activities

testData<-cbind(testData_X,testData_Y)
testData<-cbind(testData,testData_subj)
trainData<-cbind(trainData_X,trainData_Y)
trainData<-cbind(trainData,trainData_subj)
AllData<-rbind(testData,trainData)

# 2. extract only the measurements on the mean and standard deviation for each measurement

AllData_mean<-sapply(AllData,mean,na.rm=TRUE)
AllData_sd<-sapply(AllData,sd,na.rm=TRUE)


# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject

DT <- data.table(AllData)
tidy_data<-DT[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidy_data,file="tidy_data_set.txt",sep=",",row.names = FALSE)




