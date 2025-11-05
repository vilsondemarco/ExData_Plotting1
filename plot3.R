# Reading data and calling packages
packages <- installed.packages()
if("lubridate" %in% rownames(packages) == FALSE) 
  install.packages("lubridate")
library(lubridate)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="data.zip")
unzip("data.zip")
hpc_data <- subset(read.csv(file.path("household_power_consumption.txt"), 
                            sep=";"), Date == "1/2/2007" | Date == "2/2/2007", 
                            select = Date:Sub_metering_3)

# Creating a time frame for the X axis
daytime_aux <- paste(dmy(hpc_data$Date), hpc_data$Time)
hpc_data$DayTime <- as.POSIXct(daytime_aux)

# Creating the canvas
par(mfrow = c(1,1))

# Ploting the initial Line graphic
plot(hpc_data$Sub_metering_1~hpc_data$DayTime, type="l",
     ylab="Energy sub metering", xlab="",xaxt="n")
  with(hpc_data,lines(DayTime,Sub_metering_1))
  with(hpc_data,lines(DayTime,Sub_metering_2, col = "red"))
  with(hpc_data,lines(DayTime,Sub_metering_3, col = "blue"))

# Naming the X axis with the abbreviated weekdays, incrementing the intervals 
# with 86400 seconds, which corresponds to a day
axis.POSIXct(1,at=seq(min(hpc_data$DayTime),max(hpc_data$DayTime)+86400,
                      by="day"),format="%a")

# Creating the legend. We didn't find any configuration that allowed us to 
# resize the graphic as a PNG that correctly displayed the border of the legend,
# so we used bty = "n" to remove it completly
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.55, 
         inset = c(0.02,0), bty = "n")

# Saving the png file
dev.copy(png, file="plot3.png",height=504, width=504)
dev.off()