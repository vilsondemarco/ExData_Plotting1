# Reading data and calling packages
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="data.zip")
unzip("data.zip")
hpc_data <- subset(read.csv(file.path("household_power_consumption.txt"), 
                  sep=";"), Date == "1/2/2007" | Date == "2/2/2007", select = 
                    Date:Sub_metering_3)

# Creating the canvas
par(mfrow = c(1,1))

# Ploting the Histogram
hist(as.numeric(hpc_data$Global_active_power),xlab = 
       "Global Active Power (kilowatts)", col = "red", 
        main = "Global Active Power")

# Saving the png file
dev.copy(png, file = "plot1.png",height=504, width=504)
dev.off()