## Exploratory Data Analysis
## Course Project 1
## Plot 4 Script
## John Tracy Cunningham
## 9 May 2015
## This script was written by me on 4 December 2014, the first time I took this
## course.  I did not complete the course then.  The assignment has not 
## changed, and the script still works, so I am submitting it for this instance
## of the course.

## This script accepts the household_power-consumption.txt file and produces
## four plots in a single png formatted file:
## 1. Top left.  A plot of Global Active Power vs time.  Same as Plot 2.
## 2. Bottom left.  A plot of the three submeterings vs time.  sub-metering_1 
## is shown as a black line, 2 as red, and 3 as blue.  Same as Plot 3.
## 3. Top right.  A plot of voltage vs time.
## 4. Bottom right.  A plot of global_reactive_power vs time.

## Observations were made every minute from the beginning of 1 February 2007
## to the end of 2 February 2007.

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

## Open the png device for file plot2.png

png("plot4.png")

## Set up a matrix of four plots, two by two, to be filled column-wise.

par(mfcol = c(2,2))

## Plot global_active_power vs time with a line connecting data points and an
## appropriate y-axis label.

plot(powercon$date_time, powercon$global_active_power, type = "l", xlab ="", 
     ylab = "Global Active Power")

## Plot the three submeterings vs time with lines connecting data points, with 
## an appropriate y-axis label and an appropriate legend.

plot(powercon$date_time, powercon$sub_metering_1, type = "n", xlab="", ylab = 
             "Energy sub metering")
points(powercon$date_time, powercon$sub_metering_1, type = "l")
points(powercon$date_time, powercon$sub_metering_2, type = "l", col = "red")
points(powercon$date_time, powercon$sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))

## Plot voltage vss time with a line connecting data points.

plot(powercon$date_time, powercon$voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")

## Plot global_reactive_power vs time with a line connecting data points.

plot(powercon$date_time, powercon$global_reactive_power, type = "l", xlab =
        "datetime", ylab = "Global_reactive_power")

## Close the png device

dev.off()

## End of script