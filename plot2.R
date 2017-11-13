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

# Remove missing values for plot 2
missing_data <- Power_data$Global_active_power!='?'
Power_data_plot2 <- Power_data[missing_data,]

# Create calender date and time object.
datetime <- as.POSIXlt(paste(Power_data_plot2$Date, Power_data_plot2$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

# Plot in PNG
png("plot2.png",height=480,width=480)
plot(datetime, Power_data_plot2$Global_active_power, type='l', xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
