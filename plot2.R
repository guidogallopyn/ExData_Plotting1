
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destPath <- tempfile(fileext="zip")
download.file(fileUrl,destPath, method="curl")
df <- read.table(unz(destPath,"household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
df$Date <- as.Date(df$Date,"%d/%m/%Y")
df <- df[df$Date %in% as.Date(c("2007-02-01","2007-02-02")),]
df$Time <-strptime(paste(format.Date(df$Date,"%d/%m/%Y"),df$Time),"%d/%m/%Y %H:%M:%S")

png(filename = "plot2.png", width = 480, height = 480)
with(df,plot(Time,Global_active_power,type="l", main="", xlab="",ylab="Global Active Power (kilowatts)"))
dev.off()
