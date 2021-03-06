### Your task is to reconstruct the following plots below, all of which were constructed using the base plotting system.
library(data.table)

### Download and unzip individual household electric power consumption Data Set
file <- "electricconsumption.zip"
if (!file.exists(file)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",file)
}
unzip(file,overwrite=FALSE)

# Get household power consumption table.
Power_data <- as.data.frame(fread("household_power_consumption.txt"))

# Remove missing values
missing_data <- Power_data$Date!='?'
missing_data <- missing_data|Power_data$Time!='?'
Power_data <- Power_data[missing_data,]

# Reformat dates from dd/mm/yyyy. Get data for 2007-02-01 and 2007-02-02
Power_data$Date <- as.Date(Power_data$Date,format="%d/%m/%Y")
Power_data <- Power_data[Power_data$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]

# Remove missing values for plot 3
missing_data <- Power_data$Global_active_power!='?'
missing_data <- missing_data|Power_data$Sub_metering_1!='?'
missing_data <- missing_data|Power_data$Sub_metering_2!='?'
missing_data <- missing_data|Power_data$Sub_metering_3!='?'
missing_data <- missing_data|Power_data$Voltage!='?'
missing_data <- missing_data|Power_data$Global_reactive_power!='?'
Power_data_plot4 <- Power_data[missing_data,]

# Create calender date and time object.
datetime <- as.POSIXlt(paste(Power_data_plot4$Date, Power_data_plot4$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

# Plot to PNG
png("plot4.png",height=480,width=480)
par(mfcol=c(2,2))
#Plot1
plot(datetime, Power_data_plot4$Global_active_power, type='l', xlab="", ylab="Global Active Power (kilowatts)")
#Plot2
plot(datetime, Power_data_plot4$Sub_metering_1, xlab="", ylab="Energy sub metering", col="black",type="l")
points(datetime, Power_data_plot4$Sub_metering_2,col="red",type="l")
points(datetime, Power_data_plot4$Sub_metering_3,col="blue",type="l")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black","red","blue"),lty=1)
#Plot3
plot(datetime, Power_data_plot4$Voltage, type='l', xlab="datetime", ylab="Voltage")
#Plot4
plot(datetime, Power_data_plot4$Global_reactive_power, type='l', xlab="datetime", ylab="Global_reactive_power")
dev.off()
