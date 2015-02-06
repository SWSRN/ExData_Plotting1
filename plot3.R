# Plots of variables sub_metering 1,2 and 3 from data file
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

#========== plot3.R ==========================
png(filename = "plot3.png",
    width = 480, height = 480)
    
with(dt, plot(datetime, Sub_metering_1,   
  		xlab="",
  		type="n",
  		ylab="Energy sub metering"))
with(dt, lines(datetime, Sub_metering_1, type="l"))  # line  
with(dt, lines(datetime, Sub_metering_2, type="l", col="red"))  # line  
with(dt, lines(datetime, Sub_metering_3, type="l", col="blue"))  # line  
legend("topright", 
     legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
     col=c("black", "red", "blue"), lty=1)
title(main = "")
  
dev.off() 

