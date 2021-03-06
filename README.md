# Getting-and-Cleaning-Data-Course-Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Download the dataset if it does not already exist in the working directory
2. Load the activity and feature info
3. Loads both the training and test datasets, keeping only those columns which
   reflect a mean or standard deviation
4. Loads the activity and subject data for each dataset, and merges those
   columns with the dataset
5. Merges the two datasets
6. Converts the `Activity` and `subNum` columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The end result is shown in the file `result.txt`.

[Data for the project](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

[R Script Link](https://github.com/fshnkarimi/Getting-and-Cleaning-Data-Course-Project/blob/main/run_analysis.R)

[Final tidy dataset](https://github.com/fshnkarimi/Getting-and-Cleaning-Data-Course-Project/blob/main/tidy_dataset.csv)

Author: Ali Rabiee
