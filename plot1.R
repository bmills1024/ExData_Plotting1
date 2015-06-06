# 1) Down load and unzip file from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# 2) Folder must be in current working directory
# 3) Script uses package "sqldf":  install.packages("sqldf")
# 4) Spript produces Plot 1 for Exploratory Data Analysis Project 1

#install.packages("sqldf")
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

#Plot 1
png(filename = "plot1.png", width = 540, height = 540, units = "px", bg = "white")

hist(
  mydf$Global_active_power, 
  main="Global Active Power", 
  xlab="Global Active Power (kilowatts)", 
  col="red")

dev.off()
