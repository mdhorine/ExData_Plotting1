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
    
    # Combine Date and Time so we can use DateTime in plots
    dataFile$DateTime <- paste(dataFile$Date, dataFile$Time)
    
    # Plot2: Open the PNG device, create the plot and write to file
    png(filename = "plot2.png",  bg = "transparent", width = 480, height = 480, type = "quartz")
    plot(as.POSIXlt(dataFile$DateTime), dataFile$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    dev.off()
}

