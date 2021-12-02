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


## It says Thurs, Fri and Sat because it is the Spanish for 
## Thursday, Friday and Saturday. System default value.


## PLOT

hist(datos$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")


## Save the file

dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()

