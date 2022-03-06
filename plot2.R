## JHU Exploratory Data Analysis
# Course Project 1
# Code for creating PLOT 2
# Created by Callen Hyland, March 5, 2022

library(data.table)
library(dplyr)

# read in the large data table from text file
dt <- fread("household_power_consumption.txt", sep = ";")

# Reformat to 4 digit years
dt$Date <- as.Date(dt$Date, "%d/%m/%Y")

# Select date range between 2007-02-01 and 2007-02-02
sub <- dt[Date %between% c("2007-02-01", "2007-02-02")]

rm(dt); # remove the big data table

# Convert the global active power to numeric
sub$Global_active_power <- as.numeric(sub$Global_active_power)

# Convert the Time column from string to date/time
sub <- mutate(sub, date_time = paste(Date, Time))
sub[['date_time']] <- strptime(sub[['date_time']], format = "%Y-%m-%d %H:%M:%S")

# MAKE THE PLOT
png("plot2.png", width = 480, height = 480)

plot(sub$date_time, sub$Global_active_power,
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type = "l")

dev.off()
