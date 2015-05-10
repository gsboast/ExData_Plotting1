# Script: plot4.R

# Usage: Read in an electric consumption data file and plot four charts in a 2x2 grid 
# power for two specified days. The script uses the dplyr package which must be installed
# on top of the base R package. Then, place the data file and this script in the current 
# R working directory, and then source it by entering source(".//plot4.R") within the console

        library(dplyr)

        # Read in consumption text file - specify rows to assist R with memory and specify format 

        dfConsumption <- (read.csv("./household_power_consumption.txt", sep = ";", 
             na.strings = "?", header = TRUE, nrows = 2075259, 
             stringsAsFactors = TRUE))
       
        # Convert charter date to date, combine with time, create POSIXct variable to plot weekdays on x-axis.

        dfConsumption$Date <- as.Date(dfConsumption$Date, format = "%d/%m/%Y")
        dfSub <- filter(dfConsumption, Date ==  "2007-02-01" | Date == "2007-02-02")
        dCatDateTime <- paste(as.Date(dfSub$Date), dfSub$Time)
	  dfSub$Date <- as.POSIXct(dCatDateTime)
      
        png(file = "./plot4.png", bg = "white", height = 504, width = 504)
        par(mfrow =c(2,2))
       
        #First plot
        par(cex = 0.75)
        plot(dfSub$Global_active_power ~ dfSub$Date,
               ylab="Global Active Power",
               xlab="",
               type="l",
               col = "black")

        #Second plot
         plot(dfSub$Voltage ~ dfSub$Date,
               ylab="Voltage",
               xlab="datetime",
               type="l")

        #Third plot
        plot(dfSub$Sub_metering_1 ~ dfSub$Date,
               ylab="Energy sub metering",
               xlab="",
               type="l")
        lines(dfSub$Sub_metering_2 ~ dfSub$Date, type = "l", col = "red")
        lines(dfSub$Sub_metering_3 ~ dfSub$Date, type = "l", col = "blue")
        legend("topright", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               pch = "-", 
               col = c("black","red","blue"),
               bty = "n") 

        #Fourth plot  
        plot(dfSub$Global_reactive_power ~ dfSub$Date,
               ylab="Global_reactive_power",
               xlab="datetime",
               type="l")
        dev.off()
     
