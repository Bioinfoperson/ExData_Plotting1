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
missing_data <- Power_data$Time!='?'
Power_data <- Power_data[missing_data,]

# Reformat dates from dd/mm/yyyy. Get data for 2007-02-01 and 2007-02-02
Power_data$Date <- as.Date(Power_data$Date,format="%d/%m/%Y")
Power_data <- Power_data[Power_data$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]

# Remove missing values for plot 1
Power_data_plot1 <- subset(Power_data, Global_active_power!='?')

# Plot to PNG
png("plot1.png",height=480,width=480)
hist(as.numeric(Power_data$Global_active_power), breaks=24, col="red",
     main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
