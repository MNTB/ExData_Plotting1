#First read in the data
>power<-read.table("./household_power_consumption.txt", sep = ";",
                  header = TRUE, stringsAsFactors = FALSE)

#convert Date variable from character to date class
>power$Date<-as.Date(power$Date, "%d/%m/%Y")

#subset by dates
p2<-subset(power, subset = (Date == "2007-02-01"))
p3<-subset(power, subset = (Date == "2007-02-02"))

#create new smaller dataframe
subPower<-rbind(p2, p3)

#create histogram of Global Active Power
hist(as.numeric(subPower[,3]), xlab = "Global Active Power (kilowatts)", 
       main = "Global Active Power", col= "red") + axis(side = 2, at = 1000)

#copy to png format, then close device
dev.copy(png, width = 480,height = 480,file = "plot1.png")
dev.off()


