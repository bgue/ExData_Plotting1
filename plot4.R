#Download the source data:

localfile <- "power_consumption.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dir <- "data"
extracted_filename = "household_power_consumption.txt"
# Download and unzip only if the file isn't already local. 
if(!file.exists(localfile)){
  download.file(url,localfile, mode = "wb") # use binary mode since it's a zip file
}
if(!file.exists(dir)){
  unzip(localfile, files = NULL, exdir=".")
}

#Load the extracted data file and condition it. We'll add a timestamp column for convenience of generating the plots. 
pwr <- read.table(extracted_filename, sep=";", header=TRUE, colClasses="character")
pwr$timestamp = paste(pwr$Date, pwr$Time, sep=' ')
pwr$timestamp = strptime(pwr$timestamp,format ='%d/%m/%Y %H:%M:%S')                      




#Finally, the fourth plot is a combination of a number of plots. 

par(mfrow=c(2,2))

with(subpwr, {
  plot(timestamp, Global_active_power, type="l", ylab="Global Active Power", xlab="")
  plot(timestamp, Voltage, type="l", ylab="Voltage", xlab="datetime")
  plot(timestamp, Sub_metering_1, type="l",ylab = "Energy sub metering", xlab="" , col="black")
  points(timestamp, Sub_metering_2, type="l", col="red")
  points(timestamp, Sub_metering_3, type="l", col="blue")
  legend("topright", 
         lty = c(1, 1, 1), # line type 1 is a solid line. Required argument 
         col = c("black", "red", "blue"),  # colors
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         bty="n",
         cex=.7, xjust=1, yjust=1
  )
  plot(timestamp, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
})

# output PNG file
dev.copy(png, file="plot3.png",width = 480, height = 480)
dev.off()