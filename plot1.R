# load dplyr lib
library(dplyr)

# read and clean data
data <- read.table("household_power_consumption.txt", sep =";", stringsAsFactors = FALSE, na.strings = c("?",""), header = TRUE)
data <- mutate(data, Date = as.Date(data$Date, "%d/%m/%Y"))
data <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")
data$Time <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

# set up png device
png(file = "plot1.png", width = 480, height=480, units="px", type="windows") 
par(cex.axis=.75, cex.lab=.75, cex.main=.9)

# plots
with(data, {
  hist(Global_active_power, col = "red", xlab= "Global Active Power (kilowatts)", main="Global Active Power")
})

# close png device
dev.off()




