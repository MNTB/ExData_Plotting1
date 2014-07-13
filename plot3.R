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


#create line graph of submetering 1
plot(subPower$Date_Time, subPower$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")
#add lines for submetering 2, 3
lines(subPower$Date_Time, subPower$Sub_metering_2, col = "red")
lines(subPower$Date_Time, subPower$Sub_metering_3, col = "blue")

#add legend
legend("topright", lty = 1, col=c("black", "red","blue"), 
       legend = c("Sub_metering_1            ", "Sub_metering_2            ", 
                  "Sub_metering_3            "))

#copy to png format, a little wider to include legend, then close device
dev.copy(png, width = 480,height = 480, file = "plot3.png")
dev.off()
