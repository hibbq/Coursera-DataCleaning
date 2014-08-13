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
download.file(fileUrl,destfile="data/NGAP.xlsx",method="internal")
list.files("data")

library(xlsx)
NGAP = read.xlsx("data/NGAP.xlsx", sheetIndex = 1, header = TRUE)
head(NGAP)

#TBD : update R version 

