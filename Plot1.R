dir.create("./course_project_2")

setwd("./course_project_2")


install.packages("lubridate")

library(lubridate)


fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileurl, destfile = "NEIrecords.zip", method = "curl")

unzip("NEIrecords.zip")



NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

years <- lubridate::as_date(as.character(NEI$year), format = "%Y")

years <- year(years)


triplenine <- subset(NEI, year == 1999)

twoohohtwo <- subset(NEI, year == 2002)

twoohohfive <- subset(NEI, year == 2005)

twoohoheight <- subset(NEI, year == 2008)


triplenine_emissions <- sum(triplenine$Emissions)

twoohohtwo_emissions <- sum(twoohohtwo$Emissions)

twoohohfive_emissions <- sum(twoohohfive$Emissions)

twoohoheight_emissions <- sum(twoohoheight$Emissions)



