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


Baltimore_emissions <- subset(NEI, NEI$fips == "24510")

triplenine_baltimore <- subset(Baltimore_emissions, year == 1999)

twoohohtwo_baltimore <- subset(Baltimore_emissions, year == 2002)

twoohohfive_baltimore <- subset(Baltimore_emissions, year == 2005)

twoohoheight_baltimore <- subset(Baltimore_emissions, year == 2008)


triplenine_emissions <- sum(triplenine_baltimore$Emissions)

twoohohtwo_emissions <- sum(twoohohtwo_baltimore$Emissions)

twoohohfive_emissions <- sum(twoohohfive_baltimore$Emissions)

twoohoheight_emissions <- sum(twoohoheight_baltimore$Emissions)


total_emissions <- c(triplenine_emissions,twoohohtwo_emissions,twoohohfive_emissions,twoohoheight_emissions)

year_names <- c("1999", "2002", "2005", "2008")

colors <- c("firebrick1", "gold1", "darkorange1", "greenyellow")



png(filename = "plot2.png", width = 700, height = 700 , units = "px")

plot2<-barplot(height=total_emissions/1000, names.arg=year_names, ylim=c(0,4), xlab="Years", ylab=expression('total PM'[2.5]*' emission in kilotons'), main=expression('Total PM'[2.5]*' emissions in Baltimore City-MD in kilotons'), col=colors)

text(x = plot2 , y = round(total_emissions/1000,2), label = round(total_emissions/1000,2), pos = 3, cex = 0.8, col = "black")

dev.off()

#ending plot2




