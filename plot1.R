## Exploratory Data Analysis
## Course Project 1
## Plot 1 Script
## John Tracy Cunningham
## 9 May 2015
## This script was written by me on 4 December 2014, the first time I took this
## course.  I did not complete the course then.  The assignment has not 
## changed, and the script still works, so I am submitting it for this instance
## of the course.

## This script accepts the household_power-consumption.txt file and produces a
## histogram of Global Active Power in png format.

## Before running this script, download the zipped data file as instructed in
## the assignment, and unzip it into your working directory.

## Turn off warnings and load the sqldf package.

options(warn=-1)
library(sqldf)

## Read the data into the data frame "powercon".  Note that the separator is a 
## semicolon.  Set column classes to character for Date and Time and to 
## numeric for all the others.

powercon <- read.csv.sql("household_power_consumption.txt", sql = "select * 
        from file where Date IN ('1/2/2007', '2/2/2007')", sep = ";", 
        colClasses = c("character", "character", "numeric", "numeric", 
        "numeric", "numeric", "numeric", "numeric", "numeric"))

## Change the column names to lower case.

colnames(powercon) <- tolower(colnames(powercon))

## Convert the Date and Time to a single POSIXt date_time format.

powercon$date <- paste(powercon$date, powercon$time, " ")
powercon$time <- NULL
colnames(powercon)[1] <- "date_time"
powercon$date_time <- strptime(powercon$date_time, "%d/%m/%Y %H:%M:%S")

## Open the png device for file plot1.png

png("plot1.png")

## Plot the histogram of global_active_power with red columns and appropriate
## main title and axis labels.

hist(powercon$global_active_power, col = "red", main = "Global Active Power",
        xlab = "Global Active Power (kilowatts)")

## Close the png device

dev.off()

## End of script