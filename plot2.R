plot2 <- function() {
    # Read the file into a data table using fread
    path <- file.path("data", "household_power_consumption.txt")
    if(file.exists(path)) {
        dataFile <- fread(path, sep = ";", header = TRUE, na.strings = "?", showProgress = TRUE)
    }
    else {
        stop("File does not exist")
    }
    
    # Make modifications to the file to tidy up data
    # Change date column to data data type
    dataFile$Date <- as.Date(dataFile$Date, "%d/%m/%Y")
    
    # Filter data table so we are just looking at the two days of data we need
    dataFile <- subset(dataFile, dataFile$Date == "2007-02-01" | dataFile$Date == "2007-02-02")
    
    # Combine Date and Time so we can use DateTime in later plots
    dataFile$DateTime <- paste(dataFile$Date, dataFile$Time)
    
    # Plot2: Create the line plot and write to screen device
    plot(as.POSIXlt(dataFile$DateTime), dataFile$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    
    # Copy histogram to PNG and close the device
    dev.copy(png, file = "plot2.png")
    dev.off()
}

