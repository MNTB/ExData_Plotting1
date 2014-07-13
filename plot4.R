#First read in the data
>power<-read.table("./household_power_consumption.txt", sep = ";",
                   header = TRUE, stringsAsFactors = FALSE)

#add new variable, combining Date and Time
power$Date_Time<-paste(power[,1],power[,2], sep = " ")

#convert Date variable from character to date class
>power$Date<-as.Date(power$Date, "%d/%m/%Y")

#subset by dates
p2<-subset(power, subset = (Date == "2007-02-01"))
p3<-subset(power, subset = (Date == "2007-02-02"))

#create new smaller dataframe
subPower<-rbind(p2, p3)


#convert to variable Date_Time to Date
subPower$Date_Time<-as.POSIXlt(subPower$Date_Time, format ="%d/%m/%Y %H:%M:%S")

#create plotting variables
x<-subPower$Date_Time
GAP<-subPower$Global_active_power
V<-subPower$Voltage
GRP<-subPower$Global_reactive_power       
SM1<-subPower$Sub_metering_1
SM2<-subPower$Sub_metering_2
SM3<-subPower$Sub_metering_3

#set parameters for multiple graphs
par(mar=c(4, 4, 2, 2))
par(mfcol = c(2,2))

#create line graph of Global Active Power
plot(x, GAP, type = "l", xlab = "",
       ylab = "Global Active Power (kilowatts)")

#create line graph of submetering 1 vs. time
plot(x, SM1, type = "l", xlab = "",
     ylab = "Energy sub metering")
#add lines for submetering 2, 3
lines(subPower$Date_Time, subPower$Sub_metering_2, col = "red")
lines(subPower$Date_Time, subPower$Sub_metering_3, col = "blue")

#add legend
legend("top", bty = "n", lty = 1, col=c("black", "red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#create line graph of Voltage vs. time
plot(x, V, type = "l", xlab = "datetime",
     ylab = "Voltage")

#create line graph of Global reactive power vs. time
plot(x, GRP, type = "l", xlab = "datetime",
     ylab = "Global_reactive_power")+ axis(side = 2, at = c(0.1, 0.3, 0.5))

#copy to png format, a little wider to include legend, then close device
dev.copy(png, width = 480, height = 480, file = "plot4.png")
dev.off()
