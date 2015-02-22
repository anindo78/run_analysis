# Coursera: Getting and Cleaning Data
# Week 3 Course Project
# Author: Anindo Chakraborty



#create new directory for course project

dir.create("./quiz3data")
setwd("./quiz3data")

#download data

zip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zip, destfile="data quiz2.zip")
unzip("data quiz2.zip", exdir="./data quiz2")

#create path to read all files

path2 <- paste(getwd(),"/data quiz2/UCI HAR Dataset", sep="")



# Read and Prepare ALL Test Data

xtest <- read.table(file.path(path2, "test", "X_test.txt"),header=F)
testlab <- read.table(file.path(path2, "test", "y_test.txt"),header=F)
testact <- read.table(file.path(path2, "test", "subject_test.txt"),header=F)

# Labels are not clear. I am using "label" and "who"

names(testlab) <- c("label")
names(testact) <- c("who")

# Read activity file to get descriptions on label

activity <- read.table(file.path(path2, "activity_labels.txt"),header=F)
names(activity)<- c("label", "nameact")

# Merge label file and activity file

testlabact <- merge(testlab, activity, all.x=T, by="label", sort=F)

# create alltest data set with a tag of type = test to indicate where the row originated

alltest <- cbind(testlabact, testact, xtest)
alltest$type <- c("test")

#read feature data - This will be used later

feat <- read.table(file.path(path2, "features.txt"),colClasses = c("character"))


# Read and Prepare ALL Test Data
# Follow all steps as above to read test data

xtrain <- read.table(file.path(path2, "train", "X_train.txt"),header=F)
trainlab <- read.table(file.path(path2, "train", "y_train.txt"),header=F)
trainact <- read.table(file.path(path2, "train", "subject_train.txt"),header=F)

names(trainlab) <- c("label")
names(trainact) <- c("who")


trainlabact <- merge(trainlab, activity, all.x=T, by="label", sort=F)

alltrain <- cbind(trainlabact, trainact, xtrain)


# combine test and train into one dataset

overall <- rbind(alltest, alltrain)

# assign labels to the measurements
lab <- feat[,2]
colnames(overall)[,4:564] <- lab

#extract only mean and std

featmeanstd <- overall[,grepl("mean|std|who|nameact|label", names(overall))]

# create new variable to summarize by (1) activity and (2) who i.e. subject

featmeanstd <- mutate(featmeanstd, groupby=paste(featmeanstd$nameact, featmeanstd$who, sep="-"))
final_d <- featmeanstd[,-1:-3]

# summarise the data
final_d1 <- aggregate(final_d[,-80], by=list(final_d$groupby), FUN=mean)
names(final_d1)[1] <- c("Activity-Subject")


#write to local disk

write.table(final_d1, file = "final data.txt", row.names=F)
