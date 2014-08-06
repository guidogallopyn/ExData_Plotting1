fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destPath <- tempfile(fileext="zip")
download.file(fileUrl,destPath, method="curl")
df <- read.table(unz(destPath,"household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
df$Date <- as.Date(df$Date,"%d/%m/%Y")
df <- df[df$Date %in% as.Date(c("2007-02-01","2007-02-02")),]
df$Time <-strptime(paste(format.Date(df$Date,"%d/%m/%Y"),df$Time),"%d/%m/%Y %H:%M:%S")

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

#plot 1
with(df,plot(Time,Global_active_power,type="l", main="", xlab="",ylab="Global Active Power (kilowatts)"))

#plot 2
with(df,plot(Time,Voltage,type="l", main="", xlab="datetime"))

#plot 3
with(df,plot(Time,Sub_metering_1, type="n", main="", xlab="",ylab="Energy sub metering"))
with(df,lines(Time,Sub_metering_1, type="l",col="black"))
with(df,lines(Time,Sub_metering_2, type="l",col="red"))
with(df,lines(Time,Sub_metering_3, type="l",col="blue"))
with(df,legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"), bty="n",cex=.9))

#plot 4
with(df,plot(Time,Global_reactive_power,type="l", main="", xlab="datetime"))


dev.off()
