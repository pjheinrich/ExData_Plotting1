## plot2 - downloads data and creates plot2, line graph of global active power over time
## note - code is set up for Mac; need to change for PC, Unix


fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "./data/household_power_consumption.zip"
download.file(fileUrl, destfile = zipfile, method = "curl")
## list option on unzip gets the list of files in the zipped file
zipFileInfo <- unzip(zipfile, list=TRUE)
##    this zip has one file; the Name element in the list contains the name
hpc <- read.delim(unz(zipfile, as.character(zipFileInfo$Name)))
## col names in first row are separated by periods, so they need to be added explicitly
colnames <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
## skip 1st row, add col names, rest is semi-colon delimited; also na.string is "?"
hpc <- read.table(unz(zipfile, as.character(zipFileInfo$Name)),skip = 1, col.names = colnames, nrows = 2080000, na.strings = "?", sep = ";")
## dates in DD/MM/YYYY format; subset to 2007-02-01 and 2007-02-02
hpc2 <- hpc[hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007",]
## use lubridate for date conversion
library(lubridate)
## combine date and time into one field and convert to proper date/time and add as new column in data frame
hpc2$dateTime <- dmy_hms(paste(hpc2[,1], hpc2[,2]))
## create line chart by date/time
plot(hpc2$dateTime, hpc2$Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = " ")
lines(hpc2$dateTime, hpc2$Global_active_power, type = "l")
pngfile <- "/Users/pjhpjh/datascience/ExData_Plotting1/plot2.png"
## write out to png file in clone of  forked github exercise folder; need to change to run on another computer
dev.copy(png, pngfile)
dev.off() 









