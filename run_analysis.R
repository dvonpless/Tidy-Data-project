# run_analysis.R
# D. Von Pless
# Fri Oct 24 20:33:38 EDT 2014
#
#
# Take a collection of eight text files describing wearable computing
# device and create a tidy data set for analysis.  The analysis here will
# be a simple average of any variables which report the mean or standard
# deviation of an observation.
#
# We first assemble the files from the Train and Test phases of the experiment
# To these data, we append the associated Activity (e.g. WALKING, STANDING)
# and Subject information.  Finally, we rename the columns with meaningful
# names.
#
# Once we have the dataset assembled, reduce it to only those columns
# which deal with mean() or std(), as defined by the original authors in the
# 'features_info.txt' file.  We will then create a new table which contains
# the mean for each of these data points, by each activity and subject.

library(plyr)  #used for join()
library(dplyr) #used for group_by(), summarise_each()

# Get the measurement and activity labels
features<-read.table("features.txt",stringsAsFactors=FALSE)
activity<-read.table("activity_labels.txt")

# Build a list of column indices containing '-mean()' and '-std()'
colIndex<-grep("(-mean|-std)\\(\\)",features$V2)
my_colnames<-vector(mode="character")
for(i in colIndex) { my_colnames<-append(my_colnames,features$V2[i]);}

# Read in the TRAIN data sets: subjects, activity(y), data(X)
subjects<-read.table("train/subject_train.txt")
y<-read.table("train/y_train.txt")
X<-read.table("train/X_train.txt")

# Read in the TEST data sets: subjects, activity(y), data(X)
subjects1<-read.table("test/subject_test.txt")
y1<-read.table("test/y_test.txt")
X1<-read.table("test/X_test.txt")

# rbind() the train and test sets together
subjects<-rbind(subjects,subjects1)
y<-rbind(y,y1)
X<-rbind(X,X1)

# make meaningful activity codes from their indices
activity_codes<-join(y,activity)

# use cbind() to add two new columns: Activity and Subject
X<-cbind(X,activity_codes$V2)
X<-cbind(X,subjects)

# assign meaningful names to the numeric variables.
# use the data from the features.txt file for this purpose.
names(X)<-tolower(c(features$V2,"activity","subject"))
names(X)<-sub("^t","time",names(X))
names(X)<-sub("^f","frequency",names(X))
names(X)<-sub("acc","linearacceleration",names(X))
names(X)<-sub("gyro","angularvelocity",names(X))
names(X)<-sub("mag","magnitude",names(X))
names(X)<-sub("std","standarddeviation",names(X))
names(X)<-gsub("(\\(|\\)|-)","",names(X))
names(X)<-sub("bodybody","body",names(X))
# The large data set is now tidy and ready to be used.
# Strip it down to what we need.

# First, a little hack to transform column names to indices, as
# we have already stored the desired numeric fields by index.
myCols<-c("activity","subject")
colNums<-match(myCols,names(X))

# Create a new table with just the info we want.
tblData<-tbl_df(X[,c(colIndex,colNums)])

# Use the convenience of continuation scripting from dplyr() to make
# our job easy in assembling the final output table.
OutputData<-tblData %>%
    group_by(activity,subject) %>%
    summarise_each(funs(mean))

# write out the data for later upload to Coursera.
write.table(OutputData,"tidy_data.txt",row.names=FALSE)
