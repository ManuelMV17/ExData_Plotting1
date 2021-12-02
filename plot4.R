## Load the data

datos <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date

datos$Date <- as.Date(datos$Date, "%d/%m/%Y")

## Filter dataset from February 1, 2007 to February 2, 2007

datos <- subset(datos, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove the NA's

datos <- datos[complete.cases(datos), ]

## Combine Date with Time

tiempo <- paste(datos$Date, datos$Time)

## New vector name

tiempo <- setNames(tiempo, "FechaHora")

## Remove Date and Time

datos <- datos[, !(names(datos) %in% c("Date", "Time"))]

## Add tiempo column

datos <- cbind(tiempo, datos)

## Format tiempo column

datos$tiempo <- as.POSIXct(tiempo)

## PLOT 4

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

with(datos, {
    plot(Global_active_power ~ tiempo, type = "l",
         ylab = "Global Active Power (kilowatts)", xlab = "")
    plot(Voltage ~ tiempo, type = "l",
         ylab = "Voltage (volt)", xlab = "datetime")
    plot(Sub_metering_1 ~ tiempo, type = "l",
         ylab = "Energy Submetering", xlab = "")
    lines(Sub_metering_2 ~ tiempo, col = "Red")
    lines(Sub_metering_3 ~ tiempo, col = "Blue")
    legend("topright", col = c("Black", "red", "blue"), lty = 1, lwd = 2, 
           bty = "n", 
           legend =  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power ~ tiempo, type ="l",
         ylab = "Global Reactive Power (kilowatts)", xlab = "datetime")
    })

dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()
