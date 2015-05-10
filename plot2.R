# Script: plot2.R

# Usage: Read in an electric consumption data file to create a .png grpahic of a line plot
# of global active power for two specified days. The script uses the dplyr package to 
# simplify filtering dates. Install the package first. Place the data file and this script in the
# current R working directory, and then source it with: source(".//plot2.R") within the console.


        library(dplyr)

        # Read in consumption text file - specify rows to assist R with memory and specify format 

        dfConsumption <- tbl_df(read.csv("./household_power_consumption.txt", sep = ";", 
             na.strings = "?", header = TRUE, nrows = 2075259, 
             stringsAsFactors = TRUE))
       
        # Convert character date filed to date and then combine date and time variables as POSIXct
        # in order for plot to show weekday names on x-axis automatically.

        dfConsumption$Date <- as.Date(dfConsumption$Date, format = "%d/%m/%Y")
        dfSub <- filter(dfConsumption, Date ==  "2007-02-01" | Date == "2007-02-02")
        dCatDateTime <- paste(as.Date(dfSub$Date), dfSub$Time)
        dfSub$Date <- as.POSIXct(dCatDateTime)

        # Setup graphical parameters adn filename for plot()- the example plots show on screen as 504x504 pixels
        png(file = "./plot2.png", bg = "white", height = 504, width = 504)
        par(col="black")
        plot(dfSub$Global_active_power ~ dfSub$Date,
               ylab="Global Active Power (kilowatts)",
               xlab="",
               type="l")
        dev.off()