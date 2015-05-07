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

#2. Daten zu den Streiktagen (Selbst zusammengetrage)

Streiktage <- read.csv2(file="/Users/Jan/Documents/GitHub/Bahnstreik/Streiktage.csv",col.names="Datum",stringsAsFactors=FALSE)
Streiktage$Datum <- as.Date(Streiktage$Datum, format="%d.%m.%y")

data$Streiktag <- character(length=nrow(data))

for (i in seq_along(data$Date)) {
  if (data$Date[i] %in% Streiktage$Datum) {
    data$Streiktag[i] <- "Streik"
  } else {data$Streiktag[i] <- "kein Streik"}
}