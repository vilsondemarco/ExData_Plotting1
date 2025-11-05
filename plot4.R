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

# Creating a time frame for the X axis for all graphics
daytime_aux <- paste(dmy(hpc_data$Date), hpc_data$Time)
hpc_data$DayTime <- as.POSIXct(daytime_aux)

# Creating the canvas with multiple devices
par(mfrow = c(2,2))

#Ploting the First graphic
plot(hpc_data$Global_active_power~hpc_data$DayTime, type="l",
    ylab="Global Active Power", xlab="",xaxt="n")
  axis.POSIXct(1,at=seq(min(hpc_data$DayTime),max(hpc_data$DayTime)+86400,
    by="day"),format="%a")

#Ploting the Second graphic
plot(hpc_data$Voltage~hpc_data$DayTime, type="l",
    ylab="Voltage", xlab="datetime",xaxt="n")
  axis.POSIXct(1,at=seq(min(hpc_data$DayTime),max(hpc_data$DayTime)+86400,
    by="day"),format="%a")

#Ploting the Third graphic
plot(hpc_data$Sub_metering_1~hpc_data$DayTime, type="l",
    ylab="Energy sub metering", xlab="",xaxt="n")
    with(hpc_data,lines(DayTime,Sub_metering_1))
    with(hpc_data,lines(DayTime,Sub_metering_2, col = "red"))
    with(hpc_data,lines(DayTime,Sub_metering_3, col = "blue"))
  axis.POSIXct(1,at=seq(min(hpc_data$DayTime),max(hpc_data$DayTime)+86400,
    by="day"),format="%a")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = 
    c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n",
    cex = 0.65)

#Ploting the Fourth graphic
plot(hpc_data$Global_reactive_power~hpc_data$DayTime, type="l",
    ylab="Global_reactive_power", xlab="datetime",xaxt="n")
  axis.POSIXct(1,at=seq(min(hpc_data$DayTime),max(hpc_data$DayTime)+86400,
    by="day"),format="%a")

# Saving the png file
dev.copy(png, file="plot4.png", height=504, width=504)
dev.off()