# env = Win XP

setwd("./W01")

if (!file.exists("data"))
{
  dir.create("data")
}  

# NC20140806 : change method to "internal", use "curl" would get error : download had nonzero exit status
# ref : http://stackoverflow.com/questions/17300582/download-file-in-r-has-non-zero-exit-status
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile="data/2006housingIdaho.csv",method="internal")
list.files("data")


housingData = read.csv("data/2006housingIdaho.csv", sep = ",", header = TRUE)
head(housingData$VAL)

#length of VAL > 100,0000
len_million = length(which(housingData$VAL=="24"))
len_million

fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl,destfile="data/NGAP1.xlsx",method="internal") # cannont open file in this cmd, keep trying
list.files("data")


#Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre7') # for 64-bit version
 
# install.packages("rJava")
# install.packages("xlsxjars")
# .jinit(parameters="-Xmx512m")
# library(xlsxjars)
library(xlsx)
NGAP = read.xlsx("data/NGAP_MAN.xlsx", sheetIndex = 1, header = TRUE)
#NGAP = read.xlsx("data/NGAP_MAN.xlsx", sheetIndex = 1)

head(NGAP)

#TBD : update R version 

# check java env
# ref : https://stat.ethz.ch/pipermail/r-help/2012-August/321049.html
library(rJava)
.jinit()
