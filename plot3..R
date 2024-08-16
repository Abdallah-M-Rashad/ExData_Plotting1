if (!require(tidyr)) {
        install.packages("tidyr")
}
if (!require(lubridate)) {
        install.packages("lubridate")
}

# downlowding data and unzip it
if(!dir.exists("U_C4M1P")){
        url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url, destfile = "C4M1P")
        unzip("C4M1P",exdir = "U_C4M1P")
}


# preparing data
U_C4M1P = read.csv("U_C4M1P/household_power_consumption.txt",sep=";")
U_C4M1P2 <- U_C4M1P[U_C4M1P$Date == "1/2/2007" |
                            U_C4M1P$Date =="2/2/2007",]
time_date <- paste(U_C4M1P2$Date,U_C4M1P2$Time)
time_date <- strptime(time_date,"%e/%m/%Y %H:%M:%S")
U_C4M1P2$time_date <- time_date
end_date <- strptime("3/2/2007 00:00:00","%e/%m/%Y %H:%M:%S")


# visualization

plot(y = as.numeric(U_C4M1P2$Sub_metering_1),
     x= time_date,
     ylab = "Energy sub metering",xlab  ="", type = "n" ,xaxt = "n")
axis(1, at = seq(min(time_date), end_date, by = "days"),
     labels = format(seq(min(time_date), end_date, by = "days"), "%a"))
points(y = as.numeric(U_C4M1P2$Sub_metering_1),
       x= time_date,type = "l",col = "black")
points(y = as.numeric(U_C4M1P2$Sub_metering_2),
       x= time_date,type = "l",col = "blue")
points(y = as.numeric(U_C4M1P2$Sub_metering_3),
       x= time_date,type = "l",col = "red")
legend("topright", col = c("black", "blue", "red"),pch = c("_","_","_"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,file = "plot3.png")
dev.off()