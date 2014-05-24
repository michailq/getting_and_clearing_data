rm(list=ls())

setwd("C:/Users/Misza/Desktop/Data Scientist Specialisation/Getting and Cleaning Data/week 3/UCI HAR Dataset")

# Loading two data sets

DATA_TRAIN <- read.table("./train/X_train.txt")
DATA_TEST <- read.table("./test/X_test.txt")

# Summary

str(DATA1)
str(DATA2)

summary(DATA1)
names(DATA1)

# Adding subject ID and Activity to both data sets

DATA_TRAIN_sub <- read.table("./train/subject_train.txt")
DATA_TEST_sub <- read.table("./test/subject_test.txt")


DATA_TRAIN_act <- read.table("./train/y_train.txt")
DATA_TEST_act <- read.table("./test/y_test.txt")


DATA_TRAIN1 <- cbind(DATA_TRAIN, DATA_TRAIN_sub, DATA_TRAIN_act)
DATA_TEST1 <- cbind(DATA_TEST, DATA_TEST_sub, DATA_TEST_act)

head(DATA_TEST1)

# Merging two data sets 

MERGED_DATA <- rbind(DATA_TEST1, DATA_TRAIN1)


# Adding Variable labels 1:561, 562 - Subject ID, 563 - Activity #

Labels <- read.table("features.txt", colClasses="character")
Labels <- Labels[,2] 

names(MERGED_DATA) <- c(Labels,"Subject","Activity")

names(MERGED_DATA)

# Adding activity names to Merged DAta set

AC_Labels <- read.table("activity_labels.txt")
names(AC_Labels) <- c("Activity","Descrip")

MERGED_DATA1 <- merge(MERGED_DATA,AC_Labels, by ="Activity")
class(MERGED_DATA1$Descrip) # factor variable


## Extract only measurements that have mean and std in the variable name


# 1. We take the vector of variable names
Labels

# 2. Finds variable containing mean and std
myVariables <- grep("std|mean", Labels, ignore.case=TRUE)

## Calculates mean and std for each measurement
myMean <- apply(MERGED_DATA1[,myVariables], 2, mean)
myStd <- apply(MERGED_DATA1[,myVariables], 2, sd)

Labels[myVariables]

names(myMean) <- Labels[myVariables]
names(myStd) <- Labels[myVariables]

myMean # for each variable
myStd # for each variable

#### Tidy Data

# Split data by subject and calculate mean for each activity and variable

SPLITED.DATA <- split(MERGED_DATA1, MERGED_DATA1[,563])
table(MERGED_DATA1[,563])
CalculateVarMeanSub <- list()
DataFrame <- data.frame()


for (i in 1:length(SPLITED.DATA)) {
  
  for (j in 1:561) {
    
    DataFrame[1:6,j] <- tapply(SPLITED.DATA[[1]][,j+1], 
                            as.factor(SPLITED.DATA[[1]]$Activity), 
                            mean)
    
    CalculateVarMeanSub[[i]] <- DataFrame
    CalculateVarMeanSub[[i]]$Subject <- seq(i,i,length=6)
    CalculateVarMeanSub[[i]]$Activity <- 1:6
  }
  
}


DataFrame <- rbind(CalculateVarMeanSub[[1]], CalculateVarMeanSub[[2]])


for (i in 1:27) {
  
  DataFrame[13*i:13*i+12,] <- rbind(CalculateVarMeanSub[[i+2]], CalculateVarMeanSub[[i+3]])
  
 
}

DataFrame


aaa <- rbind(CalculateVarMeanSub[[1]], CalculateVarMeanSub[[1+1]])
dim(aaa)

TidyData <- rbind(CalculateVarMeanSub[[1]], 
      CalculateVarMeanSub[[2]],
  CalculateVarMeanSub[[3]], 
CalculateVarMeanSub[[4]],
CalculateVarMeanSub[[5]], 
CalculateVarMeanSub[[6]],
CalculateVarMeanSub[[7]], 
CalculateVarMeanSub[[8]],
CalculateVarMeanSub[[9]], 
CalculateVarMeanSub[[10]],
CalculateVarMeanSub[[11]], 
CalculateVarMeanSub[[12]],
CalculateVarMeanSub[[13]], 
CalculateVarMeanSub[[14]],
CalculateVarMeanSub[[15]], 
CalculateVarMeanSub[[16]],
CalculateVarMeanSub[[17]], 
CalculateVarMeanSub[[18]],
CalculateVarMeanSub[[19]], 
CalculateVarMeanSub[[20]],
CalculateVarMeanSub[[21]], 
CalculateVarMeanSub[[22]],
CalculateVarMeanSub[[23]], 
CalculateVarMeanSub[[24]],
CalculateVarMeanSub[[25]], 
CalculateVarMeanSub[[26]],
CalculateVarMeanSub[[27]], 
CalculateVarMeanSub[[28]],
CalculateVarMeanSub[[29]], 
CalculateVarMeanSub[[30]])





# Adding variable names
names(TidyData) <- c(Labels, "Subject", "Activity"
TidyData$Activity <- as.factor(TidyData$Activity)

Label1 <- AC_Labels[,2]

levels(TidyData$Activity) <- Label1

# Saving TidyData in my working directory

write.table(TidyData, file="TidyData.txt")

