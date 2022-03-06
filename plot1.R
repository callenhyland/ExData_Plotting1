## JHU Exploratory Data Analysis
# Course Project 1
# Code for creating Plot 1
# Created by Callen Hyland, March 5, 2022

library(data.table)

# read in the large data table from text file
dt <- fread("household_power_consumption.txt", sep = ";")

# Reformat to 4 digit years
dt$Date <- as.Date(dt$Date, "%d/%m/%Y")

# Select date range between 2007-02-01 and 2007-02-02
sub <- dt[Date %between% c("2007-02-01", "2007-02-02")]

# Convert the global active power to numberic
sub$Global_active_power <- as.numeric(sub$Global_active_power)

rm(dt); # remove the big data table

# Construct plot
png("plot1.png", width = 480, height = 480)

hist(sub$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

dev.off()

