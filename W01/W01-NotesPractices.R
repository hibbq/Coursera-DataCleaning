## Get/Set working directory
setwd("./W01")

## Checking for and creating directories

if (!file.exists("data"))
{
  dir.create("data")
}

## Download file from the web

fileUrl = "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "data/cameras.csv", method = "curl")
list.files("data")

##NC20140716-when using https, curl SSL certificate issue happens. TBD

dateDownloaded = date()
dateDownloaded