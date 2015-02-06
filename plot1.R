# Plots histogram of variable Global_active_power from data file
# household_power_consumption.txt.

library(data.table)
library(grDevices)

# Should be faster to read if use data.table library.
# Note: no ?'s (NA's) in date range 2007-02-01 through 2007-02-02
dt <- read.table("./data/household_power_consumption.txt",
	header = TRUE, 
	sep=";",
	na.strings = "?"
	)
	
dt$Date <- as.Date(dt$Date, format= "%d/%m/%Y")	# convert to date format

# Remove unwanted rows using subsetting.
startdate <- as.Date("2007-02-01", format= "%Y-%m-%d")
enddate <- as.Date("2007-02-02", format= "%Y-%m-%d")
dt <- subset(dt, (Date >= startdate) & (Date <= enddate))
      
# Create datetime variable
dt$datetime <- strptime(paste(as.character(dt$Date), as.character(dt$Time)), 
  			"%Y-%m-%d %H:%M:%S")

#========== plot1.R ==========================
png(filename = "plot1.png",
    width = 480, height = 480)
hist(dt$Global_active_power,  col="red", 
  		xlab="Global Active Power (kilowatts)", main="")
title("Global Active Power")
dev.off() 

