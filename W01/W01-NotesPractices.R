###############################
## 01_04_downLoadingFiles.pdf
###############################

# Get/Set working directory
setwd("./W01")

# Checking for and creating directories

if (!file.exists("data"))
{
  dir.create("data")
}

# Download file from the web

fileUrl = "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "data/cameras.csv", method = "curl")
list.files("data")

# NC20140716-when using https, curl SSL certificate issue happens. TBD

dateDownloaded = date()
dateDownloaded

###############################
## 01_05_readingLocalFiles.pdf
###############################

# Load flat files

cameraData = read.csv("data/cameras.csv", sep = ",", header = TRUE)
cameraDataCSV = read.csv("data/cameras.csv")


###############################
## 01_06_readingExcelFiles.pdf
###############################

if (!file.exists("data"))
{
  dir.create("data")
}

fileUrl = "http://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "data/cameras.xlsx", method = "curl")
list.files("data")

dateDownloaded = date()


# read package

# NC20140717 : rJava issue, add setenv works
# ref : https://class.coursera.org/getdata-005/forum/thread?thread_id=35
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre7') # for 64-bit version

library(xlsx)
cameraDataXLSX = read.xlsx("data/cameras.xlsx", sheetIndex = 1, header = TRUE)
head(cameraDataXLSX)

# Reading specific rows/columns

colIndex = 2:3
rowIndex = 1:4
cameraDataXLSXSubset = read.xlsx("data/cameras.xlsx", sheetIndex = 1, 
                                 colIndex = colIndex, rowIndex = rowIndex)

###############################
## 01_07_readingXML.pdf
###############################

library(XML)
fileUrl = "http://www.w3schools.com/xml/simple.xml"
doc = xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode = xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

# directly access parts of the XML content
rootNode[[1]]
rootNode[[1]][[1]]

# programatically extract parts of the file
xmlSApply(rootNode, xmlValue)
xpathSApply(rootNode, "//price", xmlValue)

# Extract content by attributes
#fileUrl = "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens" no data, change to 2013 instead
fileUrl = "http://espn.go.com/nfl/team/schedule/_/name/bal/year/2013"
           
doc = htmlTreeParse(fileUrl, useInternal = TRUE)
scores = xpathSApply(doc, "//li[@class='score']", xmlValue)
teams = xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores

###############################
## 01_08_readingJSON.pdf
###############################

# Reading data from JSON

library(jsonlite)
jsonData = fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)

# nested objects in JSON
names(jsonData$owner)

jsonData$owner$login

# writing data grames to JSON
myjson = toJSON(iris, pretty = TRUE)
cat(myjson)

# convert back to JSON
iris2 = fromJSON(myjson)
head(iris2)


###############################
## 01_09_dataTable.pdf
###############################

# create data tables
library(data.table)
DF = data.frame(x=rnorm(9), y=rep((c("a", "b", "c")), each=3), z=rnorm(9))
head(DF, 3)

DT = data.table(x=rnorm(9), y=rep((c("a", "b", "c")), each=3), z=rnorm(9))
head(DT, 3)

DT[2,]
DT[DT$y=="a",]
DT[c(2,3)]

# R doesn't subset columns on dataframe, datatable, use another way instead 
# ref : https://class.coursera.org/getdata-005/forum/thread?thread_id=64
DT[,c(2, 3), with = FALSE]


# expression
k = {print(10); 5}
print(k)

DT[,list(mean(x), sum(z))]
DT[,table(y)]

# use w:= to add column, := to change column value
DT[,w:=z^2]
DT

# DT and DT2 both change their y = 2
DT2 = DT
DT[, y:= 2]

head(DT, n=3)
head(DT2, n=3)

# plyr like 
DT[, m:= { tmp = (x+z); log2(tmp+5)}]; DT

DT[, a:=x>0]; DT

DT[, b:= mean(x+w), by = a]; DT # "by" means GROUP BY

# special variables
# .N usage is faster than DT$x
# SELECT x, COUNT(*) FROM data.table GROUP BY x
# ?? 1E5 TBD
set.seed(123);
DT = data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x]

# keys
DT = data.table(x=rep(c("a", "b", "c"), each=100), y=rnorm(300))
setkey(DT,x)
DT['c'] # fetch x=a, using key is fast!


# joins
DT1 = data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 = data.table(x=c('a', 'b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)

# fast reading
big_df = data.frame(x=rnorm(1E6), y=rnorm(1E6))
file = tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)

system.time(fread(file))
system.time(read.table(file,header=TRUE, sep="\t"))

