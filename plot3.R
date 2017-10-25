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


#The third plot shows three sub metering values on our two-day period of data. 

plot(subpwr$timestamp, subpwr$Sub_metering_1, type="l",ylab = "Energy sub metering", xlab="" , col="black")
points(subpwr$timestamp, subpwr$Sub_metering_2, type="l", col="red")
points(subpwr$timestamp, subpwr$Sub_metering_3, type="l", col="blue")


# add a legend
legend("topright", 
       lty = c(1, 1, 1), # line type 1 is a solid line. Required argumen 
       col = c("black", "red", "blue"),  # colors
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

# output PNG file
dev.copy(png, file="plot3.png")
dev.off()