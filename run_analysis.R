install.packages("dplyr")
library(dplyr)

#Section1: reading data from .txt files
###########################################
# reading training data from train folder
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

#reading test data from test folder
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

#combine X, y , subject data into complete data objects
X_complete <- rbind(X_train, X_test)
y_complete <- rbind(y_train, y_test)
subject_complete <- rbind(subject_train, subject_test)

# reading feature names from features.txt
feature_name <- read.table("./features.txt", colClasses=c("numeric", "character"),col.names=c("feature_id", "names"))

#Section2-4: extract std() and mean() features and assign names to variables.
#####################################
# extract features with -std() and -mean(), then merge subject and activity data into X,y data
stdmeanindex <- grep("-(mean|std)\\(\\)", feature_name$names, value=FALSE)
data <- X_complete[,stdmeanindex] %>% mutate(motion_type = factor(y_complete$V1, labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))) %>% mutate(subject = factor(subject_complete$V1)) %>% group_by(subject, motion_type)
data <- cbind(data$subject, data$motion_type, data[, -(length(data)-1):-length(data)])

# assign proper names to data variables.
colnames(data) <- c("subject", "activity", feature_name$names[stdmeanindex])

#Section5: create a tidy data set with average value for each variable and subject and activity

tidyData <- aggregate(select(data, -(subject:activity)), by=list(data$subject, data$activity), mean)
colnames(tidyData) <- c("subject", "activity", feature_name$names[stdmeanindex])

write.table(tidyData, "tidy.txt", sep="\t", row.name=FALSE)