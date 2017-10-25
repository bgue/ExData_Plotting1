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


#The second plot is a frequency plot of GAP (y) vs timestamped data(x)

plot(subpwr$timestamp, subpwr$Global_active_power, 
     type = 'l',
     main = 'Global active power', 
     xlab = NA,
     ylab = 'Global active power (kilowatts)'
)
dev.copy(png, file="plot2.png")
dev.off()