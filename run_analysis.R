
### Set working directory ###
setwd("D:/Data Scientist Specialisation/Getting and Cleaning Data/project/UCI HAR Dataset")

### Read data tables ###

# Test datasets #
X_test <- read.table("./Test/X_test.txt")
y_test <- read.table("./Test/y_test.txt")
subject_test <- read.table("./Test/subject_test.txt")

# Train datasets#

X_train <- read.table("./Train/X_train.txt")
y_train <- read.table("./Train/y_train.txt")
subject_train <- read.table("./Train/subject_train.txt")

# Activity names 
activity_names <- read.table("activity_labels.txt")

# Variable names 

varNames <- read.table("features.txt")

### Exploratory data analysis ###

head(X_test)
class(X_test)
head(y_test)
summary(y_test)
summary(subject_test)

### Create test and training datasets

test <- cbind(subject_test,y_test,X_test)
train <- cbind(subject_train, y_train, X_train)

### Merge test and training datasets

data <- rbind(test,train)

variable <- varNames[,2]
variable <- as.character(variable)

names(data) <- c("subject", "activity", variable)

### Extracts only the measurements 
### on the mean and standard deviation for each measurement. 

# Find variables that contains mean and std expression
mean_std <- grep("[Mm]ean()|[Ss]td()", names(data))

# create new dataset with newly selected variables
data_meanstd <- data[,c(1,2,mean_std)]

### Format variable names

lowcase <-   function(x) {tolower(x)}

nVarName <- c()

for (i in 1:length(names(data_meanstd) )) {
  
  nVarName[i] <- lowcase(names(data_meanstd[i]))
  
}

nVarName1 <- gsub("[,|()|-]", "", nVarName)

### Assign formatted variable names to the dataset
names(data_meanstd) <- nVarName1

### Create final dataset
# Load data table package to aggregate the data
library(data.table)
DT <- as.data.table(data_meanstd)

final_dataset <- DT[,lapply(.SD,mean),by=list(subject,activity),.SDcols=3:88]

activity_names <- as.character(activity_names[,2])

final_dataset$activity <- factor(final_dataset$activity, levels = 1:6,
                                    labels = activity_names)

# Order data by subject and activity
tidy_data <- final_dataset[order(final_dataset$subject, 
                                 final_dataset$activity),]

# save .txt file in the working directory
write.table(tidy_data, file="tidy_data.txt", row.name=FALSE)
