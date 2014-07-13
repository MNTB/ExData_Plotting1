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


#create line graph of Global Active Power
plot(subPower$Date_Time, subPower$Global_active_power, type = "l", xlab = "",
       ylab = "Global Active Power (kilowatts)")

#copy to png format, then close device
dev.copy(png, width = 480,height = 480,file = "plot2.png")
dev.off()

