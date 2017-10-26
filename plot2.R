#This code is for Course Project 1, Week 1, Exploratory Data Analysis,
#part of the Data Science Specialisation by Johns Hopkins University
#on coursera.org

#This code reads in the Electric Power Consumption File,
#subsets the data for the relevant dates, and then creates
#and saves plot2.png

ElecPowerFile<-"household_power_consumption.txt"
#First we estimate the size of the file. 
#It's 142MB
RowCount<-count.fields(ElecPowerFile, sep = "\t")
NumRows<-sum(RowCount)
SmallData<-read.table(ElecPowerFile, header=TRUE, nrows=5, sep=";")
NumCols<-ncol(SmallData)
DataSize<-NumRows*NumCols*8
DataSizeMB<-DataSize/(2^20)

#Now we read it in and subset to the relevant data
classes<-sapply(SmallData, class)
#BigData<-read.table(ElecPowerFile, header=TRUE, colClasses = classes, skip = grep("1/2/2007", readLines(ElecPowerFile)), nrows = 2880, sep=";", na.strings = "?")
BigData<-read.table(ElecPowerFile, header=TRUE, colClasses = classes, nrows = NumRows, sep=";", na.strings = "?")
ReducedDf<-rbind(subset(BigData, Date==c("1/2/2007")),subset(BigData, Date==c("2/2/2007")))

#Create a correctly formatted datetime column
#This requires lubridate to be installed
ReducedDf$datetime<-paste(ReducedDf$Date, ReducedDf$Time, sep = ":")
ReducedDf$datetime<-dmy_hms(ReducedDf$datetime)

#Type="l" specifies a line chart
png(filename="plot2.png", width=480, height=480)
with(ReducedDf, plot(datetime, Global_active_power, type="l", xlab=" ", ylab="Global Active Power (kilowatts)"))
dev.off()
