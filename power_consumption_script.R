library(sqldf)
library(lubridate)

query <- "SELECT * FROM file WHERE Date IN ('1/2/2007', '2/2/2007') "
energy <- read.csv.sql('./household_power_consumption.txt', sql = query, sep = ";")

energy$datetime <- dmy_hms(paste(energy$Date, energy$Time))


## 1
png('./plot1.png', width=480, height=480)
hist(energy$Global_active_power, col = 'red', 
     xlab = "Global Active Power (kilowatts)",
     main = 'Global Active Power')
dev.off()


## 2
png('./plot2.png', width=480, height=480)
plot(energy$datetime, energy$Global_active_power, type='l',
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()


## 3
png('./plot3.png', width=480, height=480)
plot(energy$datetime, energy$Sub_metering_1, xlab="", ylab='Energy sub metering', type='n')
lines(energy$datetime, energy$Sub_metering_1, type='l', col='black')
lines(energy$datetime, energy$Sub_metering_2, type='l', col='red')
lines(energy$datetime, energy$Sub_metering_3, type='l', col='blue')
legend('topright', legend = paste0('Sub_metering_', 1:3), 
       col = c('black', 'red', 'blue'), lty=1, cex=0.8)
dev.off()


## 4
png('./plot4.png', width=480, height=480)
par(mfrow = c(2, 2))
# 4-1
plot(energy$datetime, energy$Global_active_power, type='l',
     xlab = "", ylab = "Global Active Power (kilowatts)")
# 4-2
plot(energy$datetime, energy$Voltage, type='l', xlab='datetime', ylab='Voltage', )
# 4-3
plot(energy$datetime, energy$Sub_metering_1, xlab="", ylab='Energy sub metering', type='n')
lines(energy$datetime, energy$Sub_metering_1, type='l', col='black')
lines(energy$datetime, energy$Sub_metering_2, type='l', col='red')
lines(energy$datetime, energy$Sub_metering_3, type='l', col='blue')
legend('topright', legend = paste0('Sub_metering_', 1:3), 
       col = c('black', 'red', 'blue'), lty=1, bty='n')
# 4-4
plot(energy$datetime, energy$Global_reactive_power, type='l',
     xlab='datetime', ylab='Global_reactive_power')

dev.off()