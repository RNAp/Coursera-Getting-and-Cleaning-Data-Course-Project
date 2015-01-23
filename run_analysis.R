

X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")


X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

X_complete <- rbind(X_train, X_test)
y_complete <- rbind(y_train, y_test)
subject_complete <- rbind(subject_train, subject_test)

feature_name <- read.table("./features.txt", colClasses=c("numeric", "character"),col.names=c("feature_id", "names"))

#####################################

data <- X_complete %>% mutate(motion_type = factor(y_complete$V1, labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))) %>% mutate(volunteer_label = factor(subject_complete$V1)) %>% group_by(volunteer_label, motion_type)

colnames(data) <- c(feature_name$names, "motion_type", "volunteer_label")

