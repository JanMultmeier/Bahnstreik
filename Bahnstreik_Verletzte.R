#Bahnstreik - Gibt es mehr oder weniger Verkehrsverletzte an Bahnstreiktagen?

#Benötigte Packages
require(RCurl)
require(dplyr)
require(ggplot2)

#1. Daten zu Verkehrsverletzten von destatis.de

file <- tempfile()
download.file("https://www.destatis.de/DE/Service/Verkehr/Verkehrsunfaelle_Daten.csv?__blob=publicationFile",destfile=file,method="curl")
data <- read.csv2(file,stringsAsFactors=FALSE)

data$PersonenschadenRest <- with(data,PersonenschadenInsgesamt - Alkoholunfaelle - MotorisiertZweirad)
data$Date <- as.Date(data$Date,format="%d-%m-%Y")
data$Jahr <- factor(format(data$Date,format="%Y"))
data$Monat <- factor(format(data$Date,format="%m"))
data$Tag <- factor(format(data$Date,format="%d"))