{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "name": "run_analysis.ipynb",
      "provenance": [],
      "collapsed_sections": []
    },
    "kernelspec": {
      "name": "ir",
      "display_name": "R"
    }
  },
  "cells": [
    {
      "cell_type": "code",
      "metadata": {
        "id": "UOQ8E0okAWD0"
      },
      "source": [
        "# Getting and Cleaning Data Course Project\r\n",
        "# Author : Ali Rabiee"
      ],
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "l2_bI5tM6TYw"
      },
      "source": [
        "install.packages(\"data.table\", dependencies=TRUE)\r\n",
        "install.packages(\"reshape2\", dependencies=TRUE)"
      ],
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "3F2Dne4aAL5o"
      },
      "source": [
        "# Getting Data from url address\r\n",
        "packages <- c(\"data.table\", \"reshape2\")\r\n",
        "sapply(packages, require, character.only=TRUE, quietly=TRUE)\r\n",
        "download.file(\"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip\", file.path(getwd(), \"my_data.zip\"))\r\n",
        "unzip(zipfile = \"my_data.zip\")"
      ],
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "s8Ht1zhuCgb3"
      },
      "source": [
        "# Extracts the measurements on the mean and standard deviation for each measurement\r\n",
        "act_labels <- fread(file.path(getwd(), \"UCI HAR Dataset/activity_labels.txt\"), col.names = c(\"classLabels\", \"activityName\"))                       \r\n",
        "features <- fread(file.path(getwd(), \"UCI HAR Dataset/features.txt\"), col.names = c(\"index\", \"featureNames\"))                \r\n",
        "mean_std <- grep(\"(mean|std)\\\\(\\\\)\", features[, featureNames])\r\n",
        "measurements <- features[mean_std, featureNames]\r\n",
        "measurements <- gsub('[()]', '', measurements)"
      ],
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "BRDiA1HWDAkS"
      },
      "source": [
        "# Load train dataset\r\n",
        "train <- read.table(\"UCI HAR Dataset/train/X_train.txt\")[mean_std]\r\n",
        "train_act <- read.table(\"UCI HAR Dataset/train/y_train.txt\")\r\n",
        "train_sub <- read.table(\"UCI HAR Dataset/train/subject_train.txt\")\r\n",
        "train <- cbind(train_sub, train_act, train)"
      ],
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "cex1Fra5Dl6L"
      },
      "source": [
        "# Load test dataset\r\n",
        "test <- read.table(\"UCI HAR Dataset/test/X_test.txt\")[mean_std]\r\n",
        "test_act <- read.table(\"UCI HAR Dataset/test/y_test.txt\")\r\n",
        "test_sub <- read.table(\"UCI HAR Dataset/test/subject_test.txt\")\r\n",
        "test <- cbind(test_sub, test_act, test)"
      ],
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "GlVq2zCPE7gI"
      },
      "source": [
        "# Merges the training and the test sets to create one data set\r\n",
        "merged <- rbind(train, test)\r\n",
        "colnames(merged) <- c(\"subNum\", \"Activity\", measurements)"
      ],
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "vlNazD9qGo3p"
      },
      "source": [
        "# turn activities & subjects into factors\r\n",
        "merged$Activity <- factor(merged$Activity, levels = act_labels[,1], labels = act_labels[,2])\r\n",
        "merged$subNum <- as.factor(merged$subNum)\r\n",
        "merged.melted <- melt(merged, id = c(\"subNum\", \"Activity\"))\r\n",
        "merged.mean <- dcast(merged.melted, subNum + Activity ~ variable, mean)\r\n",
        "write.table(merged.mean, \"result.txt\", row.names = FALSE, quote = FALSE)"
      ],
      "execution_count": null,
      "outputs": []
    }
  ]
}