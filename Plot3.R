# 
# plot3.R -- generate plot of Energy sub metering for days from 2/1/2001 to 2/2/2007
#
#            author:  Jonathan Hull
#            date:    10/11/2014
#            course:  Exploratory Data Analysis, Coursera, Oct. 6. 2014 session
#
#   data file was downloaded from the location specified in the project description and unzipped 
#           in the working directory
#

#  directory where unzipped data file is stored
dir     <- "D:/hull/data science/ExData_Plotting1/ExData_Plotting1"
infile  <- "household_power_consumption.txt"
outfile <- "plot3.png"

if (file.exists(dir)) {
  setwd(dir)
} else {
  stop(paste(dir," does not exist"))
}

if (file.exists(infile)) {
  # read top 5 rows to get classes of each category.  This will make read.table() faster
  tab5rows <- read.table(infile, header=TRUE,sep=";",na.strings="?",comment.char="",nrows=5)
} else {
  stop(paste(infile," does not exist"))
}

classes  <- sapply(tab5rows,class)

#  read the table household power consumption (HPC)
HPC <- read.table(infile, header=TRUE, sep=";", na.strings="?", comment.char="", colClasses=classes)

#  construct subset(HPC_subset) of the table between 2/1/2007 and 2/2/2007
HPC_subset  <- subset(HPC, (as.Date(Date, "%d/%m/%Y")>=as.Date("2007-02-01"))&(as.Date(Date, "%d/%m/%Y")<=as.Date("2007-02-02")))
size_subset <- nrow(HPC_subset)

#  remove the HPC table to save memory
rm(HPC)

# parameters of the plot
main_label   <- ""                                  # main label for the plot
xlabel       <- ""                                  # x axis label

x_labels     <- c("Thu","Fri","Sat")                # labels for the x axis
x_label_locs <- c(1, nrow(HPC_subset)/2, nrow(HPC_subset))  # locations for labels on x axis

#  initialize the graphics device -- png 480x480
png(outfile, width=480, height=480)


############### plot Energy sub metering ##############

ylabel <- "Energy sub metering"               # y axis label
# draw the plot with the specified parameters, suppress the x axis
plot(HPC_subset$Sub_metering_1, type='n', ylab=ylabel, xlab=xlabel, xaxt="n")
lines(c(1:size_subset),HPC_subset$Sub_metering_1,type="l", col="black")
lines(c(1:size_subset),HPC_subset$Sub_metering_2,type="l", col="red")
lines(c(1:size_subset),HPC_subset$Sub_metering_3,type="l", col="blue")
axis(1, at=x_label_locs, labels=x_labels)

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"),lty=1, bty="n")

dev.off()
