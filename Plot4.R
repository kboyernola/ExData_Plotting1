#Check to see if the dataframe febpower exists.
#If it does not create it
if (!exists("febpower"))
{
    #Create the data frame
    #Set your working directory to where the data is
    rawpower <- read.csv("household_power_consumption.txt",head=TRUE,sep=";")
    rawpower$Date_Time <- strptime(do.call(paste,rawpower[,c(1,2)]),format="%d/%m/%Y%H:%M:%S")
    #By inspection, I know that the dates and times are in order and
    #that the first row for Feb 1st is 66638 and the last row for 
    #Feb 2nd is 69516
    febpower <- rawpower[c(66638:69516),]
    #Free up some memory
    rm("rawpower")
    #Convert columns from factor to numeric
    febpower$Global_active_power <- as.numeric(as.character(febpower$Global_active_power))
    febpower$Global_reactive_power <- as.numeric(as.character(febpower$Global_reactive_power))
    febpower$Voltage <- as.numeric(as.character(febpower$Voltage))
    febpower$Global_intensity <- as.numeric(as.character(febpower$Global_intensity))
    febpower$Sub_metering_1 <- as.numeric(as.character(febpower$Sub_metering_1))
    febpower$Sub_metering_2 <- as.numeric(as.character(febpower$Sub_metering_2))
    febpower$Sub_metering_3 <- as.numeric(as.character(febpower$Sub_metering_3))
}
# Plot 4
# Assumes that the data frame febpower is present
# Set up the four panels
par(mfrow=c(2,2))
# Open the png file - This creates a file with only the last graph.  Used def.copy().
#png("plot4.png",height=480,width=480)

# Draw the first graph
x <- febpower$Date_Time
y <- febpower$Global_active_power
plot(x,y,type="l",ylab="Global Active Power",xlab="")

# Draw the second graph
y <- febpower$Voltage
plot(x,y,type="l",ylab="Voltage",xlab="datetime")

# Draw the third graph
y1 <- febpower$Sub_metering_1
y2 <- febpower$Sub_metering_2
y3 <- febpower$Sub_metering_3
plot(x,y1,type="l",ylab="Energy sub metering",xlab="",ylim=c(0,40))
par(new=TRUE)
plot(x,y2,type="l",col="red",ylab="",xlab="",ylim=c(0,40))
par(new=TRUE)
plot(x,y3,type="l",col="blue",ylab="",xlab="",ylim=c(0,40))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),cex=.5)
#par(new=FALSE)

# Draw the fourth graph
y <- febpower$Global_reactive_power
plot(x,y,type="l",ylab="Global_reactive_power",xlab="datetime")

dev.copy(png)
dev.off()
file.rename("Rplot001.png","Plot4.png")
