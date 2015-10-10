# load dplyr lib
library(dplyr)

# read and clean data
data <- read.table("household_power_consumption.txt", sep =";", stringsAsFactors = FALSE, na.strings = c("?",""), header = TRUE)
data <- mutate(data, Date = as.Date(data$Date, "%d/%m/%Y"))
data <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")
data$Time <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

# set up png device
png(file = "plot4.png", width = 480, height=480, units="px", type="windows") 
par(cex.axis=.8, cex.lab=.9)
par(mfcol=c(2,2))

# plots
with(data, {
# same as plot2, except no "(kilowatts)"
  plot(Time, Global_active_power, typ="l", ylab="Global Active Power", xlab="")
# same as plot3, except no box around the legend, and legend scaled down a bit
  plot(Time, Sub_metering_1, typ="n", ylab="Energy sub metering", xlab="")
  points(Time, Sub_metering_1, col="black", typ="l")
  points(Time, Sub_metering_2, col="red", typ="l")
  points(Time, Sub_metering_3, col="blue", typ="l")
  legend("topright", pch=NULL, lty=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex=.9)
# third plot
  plot(Time, Voltage, typ="l", ylab="Voltage", xlab="datetime")
# fourth plot
plot(Time, Global_reactive_power, typ="l", ylab="Global_reactive_power", xlab="datetime")
})

# close png device
dev.off()
