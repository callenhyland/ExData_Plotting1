## JHU Exploratory Data Analysis
# Course Project 1
# Code for creating PLOT 4
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

# Convert the Voltage to numeric
sub$Voltage <- as.numeric(sub$Voltage)

# Convert the global active power to numeric
sub$Global_active_power <- as.numeric(sub$Global_active_power)

# Convert the global reactive power to numeric
sub$Global_reactive_power <- as.numeric(sub$Global_reactive_power)

# Convert the sub_metering columns to numeric
sub$Sub_metering_1 <- as.numeric(sub$Sub_metering_1)
sub$Sub_metering_2 <- as.numeric(sub$Sub_metering_2)
sub$Sub_metering_3 <- as.numeric(sub$Sub_metering_3)

# Convert the Time column from string to date/time
sub <- mutate(sub, date_time = paste(Date, Time))
sub[['date_time']] <- strptime(sub[['date_time']], format = "%Y-%m-%d %H:%M:%S")

# MAKE THE PLOTS
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2), mar = c(5,5,2,3))

# SUBPLOT 1
plot(sub$date_time, sub$Global_active_power,
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type = "l")

# SUBPLOT 2
plot(sub$date_time, sub$Voltage,
     xlab = "datetime",
     ylab = "Voltage",
     type = "l")

# SUBPLOT 3
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
       lty=c(1,1), 
       cex=0.7)

# SUBPLOT 4
plot(sub$date_time, sub$Global_reactive_power,
     xlab = "datetime",
     ylab = "Global reactive power",
     type = "l")

dev.off()
