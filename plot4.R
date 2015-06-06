# 1) Down load and unzip file from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# 2) Folder must be in current working directory
# 3) Script uses package "sqldf":  install.packages("sqldf")
# 4) Spript produces Plot 4 for Exploratory Data Analysis Project 1

suppressMessages(library(sqldf))

#Set working directory and file name
#wd <- "place working directory path here and uncomment lines"
#setwd(wd)
myfile <- "exdata-data-household_power_consumption/household_power_consumption.txt"

#Check for file
if (!file.exists(myfile)) {
  stop(paste(myfile,  " not found.  Please download file and set working folder.", sep = ""))
} 

#Load data and filter for required dates
mydf <- read.csv.sql(myfile, sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", sep=";")
closeAllConnections()

#Create DateTime column
mydf$DateTime <- strptime(paste(mydf$Date, mydf$Time), format = "%d/%m/%Y %H:%M:%S")
mydf$Global_active_power <- as.numeric(mydf$Global_active_power)

#Plot 4
png(filename = "plot4.png", width = 600, height = 600, units = "px", bg = "white")
#Set 2x2 frame, load by rows
par("mfrow"=c(2,2))

#Chart1
plot(
  mydf$DateTime, 
  mydf$Global_active_power, 
  type="l", 
  xlab="", 
  ylab="Global Active Power")

#Chart2
plot(
  mydf$DateTime, 
  mydf$Voltage, 
  type="l", 
  xlab="datetime", 
  ylab="Voltage")

#Chart3
plot(mydf$DateTime, 
     mydf$Sub_metering_1, 
     col="black", 
     type = "l",
     xlab = "", 
     ylab = "Energy sub metering") 
#Add lines
lines(mydf$DateTime, mydf$Sub_metering_2, col = "red")
lines(mydf$DateTime, mydf$Sub_metering_3, col = "blue")
#Add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1, 
       bty = "n") 

#Chart4
plot(
  mydf$DateTime, 
  mydf$Global_reactive_power, 
  type="l", 
  xlab="datetime", 
  ylab="Global_reactive_power")

dev.off()
