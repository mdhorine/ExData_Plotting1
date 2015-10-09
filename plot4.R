plot4 <- function() {
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
    
    # Plot4: Open the PNG device, create the plot and write to file
    png(filename = "plot4.png",  bg = "transparent", width = 504, height = 504, type = "quartz")
    par(mfrow = c(2, 2))
    with( dataFile, {
        # Top-left plot
        plot(as.POSIXlt(DateTime), Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        # Top-right plot
        plot(as.POSIXlt(DateTime), Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        # Bottom-left plot
        plot(as.POSIXlt(DateTime), Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
        points(as.POSIXlt(DateTime), Sub_metering_1, type = "l")
        points(as.POSIXlt(DateTime), Sub_metering_2, type = "l", col = "red")
        points(as.POSIXlt(DateTime), Sub_metering_3, type = "l", col = "blue")
        legend("topright", lwd = 2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        # Bottom-right plot
        plot(as.POSIXlt(DateTime), Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
    })
    dev.off()
}