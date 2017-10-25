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


#The first plot is a frequency plot of Global active power vs frequency for a specified date (2007-02-02) 

subpwr <- subset(pwr, Date=="2/2/2007" | Date=="1/2/2007") # we could also convert to dates and do arithmetic, but this string comparison is much faster.
h <- hist(
  as.numeric(subpwr$Global_active_power), 
  col="red", 
  main="Global Active Power",
  xlab="Global active power (kilowatts)"
)
dev.copy(png, file="plot1.png")
dev.off()