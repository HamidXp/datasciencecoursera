# library for usign dmy and hms functions
library(lubridate)

# the file to read
fichier    <- ".\\C4week1\\household_power_consumption.txt"

# read data
data       <- read.table(fichier,head=T,sep=";" )

# change class of columns
data$Date  <- dmy(data$Date)
data$Time  <- hms(data$Time)

# subset data from 2007-02-01 to 2007-02-02
subdata    <- data[(data$Date >= ymd("2007-02-01")) & (data$Date <= ymd("2007-02-02")), ]

# plot histogram 
png("plot1.png", width=480, height=480)
hist(as.numeric(as.character(subdata$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
dev.off()
