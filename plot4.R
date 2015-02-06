# Plots 4 plots of various variables from data file household_power_consumption.txt.

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



#========== plot4.R ==========================
  png(filename = "plot4.png",
    width = 480, height = 480)
  
  par(mfrow=c(2,2))
  
  plot(dt$datetime, dt$Global_active_power,   #upper left graph
  		xlab="",
  		type="n",
  		ylab="Global Active Power")
  lines(dt$datetime, dt$Global_active_power, type="l")  # line  
  title(main = "")

   
  with(dt, plot(datetime, Voltage, type="n"))					# upper right graph
  with(dt, lines(datetime, Voltage, type="l"))  # line  
  #title(main = "Global Active Power")
  
  plot(dt$datetime, dt$Sub_metering_1,   		# lower left graph
  		xlab="", type="n", ylab="Energy sub metering")
  lines(dt$datetime, dt$Sub_metering_1, type="l")  # line  
  lines(dt$datetime, dt$Sub_metering_2, type="l", col="red")  # line  
  lines(dt$datetime, dt$Sub_metering_3, type="l", col="blue")  # line  
  # no legend box. Use lines for legends.
  legend("topright", 
     legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
     col=c("black", "red", "blue"), lty=1, bty="n")
  title(main = "")
  
  with(dt, plot(datetime, Global_reactive_power, type="n"))					# upper right graph
  with(dt, lines(datetime, Global_reactive_power, type="l"))  # line  
  # title(main = "")
  
  
  dev.off() 
