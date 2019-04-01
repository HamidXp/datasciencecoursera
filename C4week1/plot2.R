# library for usign dmy and hms functions
library(lubridate)

# the file to read
fichier    <- ".\\C4week1\\household_power_consumption.txt"

# read data
data       <- read.table(fichier,head=T,sep=";" )

# change class of columns
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- format (data$Time, format="%H:%M:%S")

# subset data from 2007-02-01 to 2007-02-02
subdata    <- data[(data$Date >= ymd("2007-02-01")) & (data$Date <= ymd("2007-02-02")), ]

# formate the date
DateTime  <- strptime(paste(subdata$Date, subdata$Time), "%Y-%m-%d %H:%M:%S")

png("plot2.png", width=480, height=480)
plot(DateTime, as.numeric(as.character(subdata$Global_active_power)), type="l", xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
