# Data Science Module 4 - Exploratory Data Analysis - Course Project 1
# Script for generating plot3
#
# Requirements:
#  This script requires the 'grep' utility to be available in the operating system.
#  On Mac/Linux systems, this utility is already normally available.
#  On Windows, this utility can be made available by installing RTools or an equivalent alternative.

# read data into memory (only the desired range of dates will be read from the file)
#21/12/2006
#df <- read.table(pipe('grep "^[1-2]/2/2007" "C:/Temp/Coursera/4 Exploratory Data Analysis/Course Project 1/household_power_consumption.txt"'), sep=";")
df <- read.table(
        pipe('grep "^[1-2]/2/2007" "C:/Temp/Coursera/4 Exploratory Data Analysis/Course Project 1/household_power_consumption.txt"'), 
        sep=";", 
        colClasses = c("character", "character", "character", "character", "character", "character", "character", "character", "character")
      )
colnames(df) = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Convert date and time
df$DateTime = strptime(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")

# Convert "?" values to NA
df$Global_active_power  [ df$Global_active_power == "?"   ] = NA
df$Global_reactive_power[ df$Global_reactive_power == "?" ] = NA
df$Voltage              [ df$Voltage == "?"               ] = NA
df$Global_intensity     [ df$Global_intensity == "?"      ] = NA
df$Sub_metering_1       [ df$Sub_metering_1 == "?"        ] = NA
df$Sub_metering_2       [ df$Sub_metering_2 == "?"        ] = NA
df$Sub_metering_3       [ df$Sub_metering_3 == "?"        ] = NA

# Convert measurements from character to numeric data type
df$Global_active_power   = as.numeric(df$Global_active_power)
df$Global_reactive_power = as.numeric(df$Global_reactive_power)
df$Voltage               = as.numeric(df$Voltage)
df$Global_intensity      = as.numeric(df$Global_intensity)
df$Sub_metering_1        = as.numeric(df$Sub_metering_1)
df$Sub_metering_2        = as.numeric(df$Sub_metering_2)
df$Sub_metering_3        = as.numeric(df$Sub_metering_3)

# Prepare the device for 1 plot
png(filename="plot3.png", width=480, height=480)
par(mfrow=c(1,1))

# Draw the line plot
plot(df$DateTime, df$Sub_metering_1, type="l", xlab=NA, ylab = "Energy sub metering", col="black")
points(df$DateTime, df$Sub_metering_2, type="l", col="red")
points(df$DateTime, df$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"),
       lty=1)

# Close the graphics device
dev.off()