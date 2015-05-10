# Script: plot1.R

# Usage: Read in an electric consumption data file to plot a histogram of global active 
# power for two specified days as a .png image. The script uses the dplyr package to 
# simplify filtering dates. Install package. Place the data file and this script in the
# current R working directory, and then source it with: source(".//plot1.R") within the console.

        library(dplyr)

        # Read in consumption text file into a table data frame - specify row count to assist R with memory
        dfConsumption <- tbl_df(read.csv("./household_power_consumption.txt",
             sep = ";", 
             na.strings = "?", header = TRUE, nrows = 2075259, 
             stringsAsFactors = FALSE))
       
        # Subset data frame for key dates, reformat and convert to date format.
        dfConsumption$Date <- as.Date(dfConsumption$Date, format = "%d/%m/%Y")
        dfSub <- filter(dfConsumption, Date ==  "2007-02-01" | Date == "2007-02-02")

        # Plot histogram of Global Active Power variable with parameters needed to match example.
        png(file = "./plot1.png", bg = "white", height = 504, width = 504)
        hist(dfSub$Global_active_power,
             col = "red",
             main = "Global Active Power", 
             xlab = "Global Active Power (kilowatts)", 
             ylab = "Frequency")
        dev.off()

     
