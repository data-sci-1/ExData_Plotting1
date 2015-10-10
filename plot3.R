# load dplyr lib
library(dplyr)

# read and clean data
data <- read.table("household_power_consumption.txt", sep =";", stringsAsFactors = FALSE, na.strings = c("?",""), header = TRUE)
data <- mutate(data, Date = as.Date(data$Date, "%d/%m/%Y"))
data <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")
data$Time <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

# set up png device
png(file = "plot3.png", width = 480, height=480, units="px", type="windows") 
par(cex.axis=.75, cex.lab=.75)

# plots
with(data, {
  plot(Time, Sub_metering_1, typ="n", ylab="Energy sub metering", xlab="")
  points(Time, Sub_metering_1, col="black", typ="l")
  points(Time, Sub_metering_2, col="red", typ="l")
  points(Time, Sub_metering_3, col="blue", typ="l")
  legend("topright", pch=NULL, lty=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

# close png device
dev.off()
