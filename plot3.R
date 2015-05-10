# Script: plot3.R

# Usage: Read in an electric consumption data file to create a .png grapic of three line
# plots of energy sub_metering 1, 2, and 3 for two days. The script uses the dplyr package to 
# simplify filtering dates. Install the package first. Place the data file and  script in the
# current R working directory, and then source it with: source(".//plot3.R") within the console.


        library(dplyr)

        # Read in consumption text file - specify rows to assist R with memory and specify format 

        dfConsumption <- tbl_df(read.csv("./household_power_consumption.txt",
             sep = ";", 
             na.strings = "?", 
             header = TRUE,
             nrows = 2075259, 
             stringsAsFactors = TRUE))
       
        # Convert to date, combine with time, and then convert to POSIXct for plotting
  
        dfConsumption$Date <- as.Date(dfConsumption$Date, format = "%d/%m/%Y")
        dfSub <- filter(dfConsumption, Date ==  "2007-02-01" | Date == "2007-02-02")
        dCatDateTime <- paste(as.Date(dfSub$Date), dfSub$Time)
	  dfSub$Date <- as.POSIXct(dCatDateTime)

        # plot three data series to one chart - outout as .png
        par(col="black")
        png(file = "./plot3.png", bg = "white", height = 504, width = 504)
        plot(dfSub$Sub_metering_1 ~ dfSub$Date,
               ylab="Energy sub metering",
               xlab="",
               type="l")
        lines(dfSub$Sub_metering_2 ~ dfSub$Date, type = "l", col = "red")
        lines(dfSub$Sub_metering_3 ~ dfSub$Date, type = "l", col = "blue")
        legend("topright", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               pch = "-", col = c("black","red","blue"), cex = 0.85) 
        dev.off()
