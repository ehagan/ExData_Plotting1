# This should be in a separate file like "loadData.R" which you could
# then do source("loadData.R") on. But, I'm going to leave it as boilerplate
# in each function for grading, working directory simplification and so on.
loadData <- function() {
    if (! file.exists("household_power_consumption.txt")) {
        if (! file.exists("exdata-data-household_power_consumption.zip")) {
            download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                          "exdata-data-household_power_consumption.zip")
        }
        unzip("exdata-data-household_power_consumption.zip")
        if (! file.exists("household_power_consumption.txt")) {
            stop("Cannot locate or acquire household_power_consumption.txt")
        }
    }
    
    
    # Read enough data to get what we want without reading the whole 2MM line file
    data <- read.table("household_power_consumption.txt",sep=";",na.strings="?",header=T,nrows=75000)
    data$DateTime = as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
    
    startTm = strptime("2007-02-01 00:00:00","%F %T")
    endTm   = strptime("2007-02-03 00:00:00","%F %T")
    
    subData = subset(data, ((DateTime >= startTm) & (DateTime < endTm)))
    subData
}

d <- loadData()
png("plot3.png",width=480,height=480)
with(d, plot(DateTime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", col="black", main=""))
with(d, lines(DateTime, Sub_metering_2, xlab="", ylab="Energy sub metering", type="l", col="red", main=""))
with(d, lines(DateTime, Sub_metering_3, xlab="", ylab="Energy sub metering", type="l", col="blue", main=""))
with(d, legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=c(1,1,1), col=c("black","red","blue")))
dev.off()
