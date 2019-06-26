# Script created on R version 3.6.0 (2019-04-26)

#  Load requried Library
        library(data.table)
        library(lubridate)


# Download assignment dataset
# First line creates ./data directory if not already present

        if(!file.exists("./data")){dir.create("./data")}
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl,destfile="./data/exdata%2Fdata%2Fhousehold_power_consumption.zip")
        unzip(zipfile="./data/exdata%2Fdata%2Fhousehold_power_consumption.zip",exdir="./data")

# Stores the dataset as a datatable
        
        hpc <- data.table::fread("./data/household_power_consumption.txt", na.strings = "?")

# Converts character strings to proper data classes, date, time and numeric.
        hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
        hpc$Time <- format(hpc$Time, format = "%H:%M:%S")
     
# Creates subset for the assignment's date range
        subhpc <- subset(hpc, Date == "2007-2-1" | Date == "2007-02-02")
        
# Using Lubridate to create a datetime vector
        datetime <- with(subhpc, ymd(subhpc$Date) + hms(subhpc$Time))
        
# Lineplot of the subset,, H/W of 480, saved to WD folder as "plot2.png" in .png format
        png("plot2.png", width=480, height=480)
        plot(datetime, subhpc$Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power (kilowatts)")
        dev.off()