# 
# plot1.R -- generate histogram of Global Active Power from 2/1/2001 to 2/2/2007
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
outfile <- "plot1.png"

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

#  initialize the graphics device -- png 480x480
png(outfile, width=480, height=480)

# parameters of the histogram
colors     = c("red")                            # color for the bars
main_label = "Global Active Power"               # main label for the histogram
xlabel     = "Global Active Power (killowatts)"  # x axis label
ylabel     = "Frequency"                         # y axis label

# draw the histogram with the specified parameters
hist(HPC_subset$Global_active_power, col=colors, main=main_label, xlab=xlabel, ylab=ylabel)

dev.off()
