#============== Training files ===============
file.X.train       <- ".\\UCI HAR Dataset\\train\\X_train.txt"
file.y.train       <- ".\\UCI HAR Dataset\\train\\y_train.txt"
file.subject.train <- ".\\UCI HAR Dataset\\train\\subject_train.txt"

#=============  Test files ==================
file.X.test       <- ".\\UCI HAR Dataset\\test\\X_test.txt"
file.y.test       <- ".\\UCI HAR Dataset\\test\\y_test.txt"
file.subject.test <- ".\\UCI HAR Dataset\\test\\subject_test.txt"

#============  Features file ================
file.features<- ".\\UCI HAR Dataset\\features.txt"


# ===================================================================
# 0 - Rreading files  
# ===================================================================

X.train       <- read.table(file.X.train        , header = F)  
y.train       <- read.table(file.y.train        , header = F)  
subject.train <- read.table(file.subject.train  , header = F) 

X.test        <- read.table(file.X.test         , header = F)  
y.test        <- read.table(file.y.test         , header = F)  
subject.test  <- read.table(file.subject.test   , header = F)

features      <- read.table(file.features       , header = F) 


# ===================================================================
# 1 - Merges the training and the test sets to create one data set
# ===================================================================

data.train  <- cbind( X.train, y.train, subject.train)
data.test   <- cbind( X.test , y.test, subject.test)	
data        <- rbind(data.train, data.test)

# ===================================================================
# 2 - Extracts only the measurements on the mean and standard deviation for each measurement
# ===================================================================

# col n° 562 :  the activities
# col n  563 :  the subject
positions.mean.std <- features[ (grepl("mean\\(",features[,2]) | grepl("std\\(",features[,2])) ,]
data.selected      <- data[,c(positions.mean.std[,1],562,563)]

# ===================================================================
# 3 - Uses descriptive activity names to name the activities in the data set
# ===================================================================

# the activities are in the before latest col (n° length(data.selected) -1 )
l         <- length(data.selected) -1 
data.temp <- data.selected[,l]
data.temp <- gsub("1", "WALKING"             ,data.temp)
data.temp <- gsub("2", "WALKING_UPSTAIRS"    ,data.temp)
data.temp <- gsub("3", "WALKING_DOWNSTAIRS"  ,data.temp)
data.temp <- gsub("4", "SITTING "            ,data.temp)
data.temp <- gsub("5", "STANDING"            ,data.temp)
data.temp <- gsub("6", "LAYING"              ,data.temp)

data.selected[,l] <- data.temp

# ===================================================================
# 4 - Uses descriptive activity names to name the activities in the data set
# ===================================================================

titles <- positions.mean.std[,2]
titles <- sub("\\(",  "",   titles)
titles <- sub("\\)",  "",   titles)
titles <- sub("\\-" ,  "",  titles)
titles <- sub("\\-" ,  "",  titles)

titles <- gsub("mean", "Mean",              titles)
titles <- gsub("std",  "StandardDeviation", titles)
titles <- gsub("Freq", "Frequency",         titles)
titles <- gsub("Mag",  "Magnitude",         titles)
titles <- gsub("Acc",  "Accelerometer",     titles)
titles <- gsub("Gyro", "Gyroscope",         titles)
titles <- gsub("^f",   "frequencyDomain",   titles)
titles <- gsub("^t",   "timeDomain",        titles)

names(data.selected) <- c(titles,"activity","subject")

# ===================================================================
# 5 - creates a second, independent tidy data set with the average of 
#     each variable for each activity and each subject.
# ===================================================================

TheMeans <-  data.selected                %>% 
             group_by( activity, subject) %>%
             summarise_each(list(mean))

			 
# ===================================================================
#   create de file "data.selected.txt"
# ===================================================================
write.table(TheMeans, "tidydata.txt", row.names = F, quote = F)
