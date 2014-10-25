README - run_analysis.R
========================================================
This script is an example of creating a tidy data set.
It has been written in response to a course project required by:
Getting and Cleaning Data, a Coursera online course presented by Johns Hopkins.

Per Hadley Wickham (vita.had.co.nz/papers/tidy-data.pdf), a data set is
tidy when:
 1. Each column represents a single variable
 2. Each row represents a unique observation
 3. Each table contains one observational unit
 

REQUIREMENTS:
 1.  plyr library
 2.  dplyr library
 3.  source data, available from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

DIRECTIONS:
Unpack the datasets and this R script to your current working directory.  Source the script to generate a tidy data set.

The script creates tidy data and outputs a subsetted table as practical analysis in the following manner:
 1.  Eight text files are assembled into a single table.  This includes data from:
   a.  Test data sets  (2947 observations)
   b.  Training data sets  (7352 observations)
   c.  Subject identifier (30 total subjects)
   d.  Activity identifier
       1.  Walking
       2.  Standing
       3.  Sitting
       4.  Walking up
       5.  Walking down
       6.  Laying
  e.   Names of the data points collected
 2.  The Activity and Subject data columns are bound to the observational
numeric data.
The Activity names are substituted for their code numbers within
the data set for easier readability.
 3.  Each numeric data column is labeled with a meaningful indicator.
 4.  At this point, the data is tidy and ready for analysis.
 5.  The script continues to create a new data table which includes only those
data points (columns) in the larger table which indicate a mean or standard deviation value.  Per the original experimenters, the following two data types meet this criteria:
    mean(): Mean value
    std(): Standard deviation
Thus, each data column name is scanned for the presence of "mean()" or "std()".  Matching columns are selected for inclusion in the final data set.
 6.  The final data set is examined to present the mean of each numeric data point, arranged by Activity and Subject.
 7.  The data set is written to a text file for upload to Coursera.

The script itself is well-commented and will further explain the sequence of operations.
