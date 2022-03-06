## JHU Exploratory Data Analysis
# Course Project 1
# Code for creating PLOT 3
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

# Convert the sub_metering columns to numeric
sub$Sub_metering_1 <- as.numeric(sub$Sub_metering_1)
sub$Sub_metering_2 <- as.numeric(sub$Sub_metering_2)
sub$Sub_metering_3 <- as.numeric(sub$Sub_metering_3)

# Convert the Time column from string to date/time
sub <- mutate(sub, date_time = paste(Date, Time))
sub[['date_time']] <- strptime(sub[['date_time']], format = "%Y-%m-%d %H:%M:%S")

# MAKE THE PLOT
png("plot3.png", width = 480, height = 480)

plot(sub$date_time, sub$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering",
     type = "l",
     col = "black")
lines(sub$date_time, 
      sub$Sub_metering_2, 
      type = "l", 
      col = "red")
lines(sub$date_time, 
      sub$Sub_metering_3, 
      type = "l", 
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty=c(1,1))

dev.off()
