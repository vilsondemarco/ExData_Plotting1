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
plot(hpc_data$Global_active_power~hpc_data$DayTime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="",xaxt="n")

# Naming the X axis with the abbreviated weekdays, incrementing the intervals 
# with 86400 seconds, which corresponds to a day
axis.POSIXct(1,at=seq(min(hpc_data$DayTime),max(hpc_data$DayTime)+86400,
                      by="day"),format="%a")

# Saving the png file
dev.copy(png, file="plot2.png", height=504, width=504)
dev.off()