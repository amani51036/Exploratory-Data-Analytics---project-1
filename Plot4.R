##PLOT 2

#Reading Data
power_data <- read.table("household_power_consumption.txt",skip=1,sep=";")

#Adding Descriptive Names 
names(power_data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#Taking subset by spescifing date range
ss_power<- subset(power_data,power_data$Date=="1/2/2007" | power_data$Date =="2/2/2007")


ss_power$Date <- as.Date(ss_power$Date, format="%d/%m/%Y")
ss_power$Time <- strptime(ss_power$Time, format="%H:%M:%S")
ss_power[1:1440,"Time"] <- format(ss_power[1:1440,"Time"],"2007-02-01 %H:%M:%S")
ss_power[1441:2880,"Time"] <- format(ss_power[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# plot

par(mfrow=c(2,2))


with(ss_power,{
  plot(ss_power$Time,as.numeric(as.character(ss_power$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(ss_power$Time,as.numeric(as.character(ss_power$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(ss_power$Time,ss_power$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
   with(ss_power,lines(Time,as.numeric(as.character(Sub_metering_1))))
   with(ss_power,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
   with(ss_power,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
   legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(ss_power$Time,as.numeric(as.character(ss_power$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})