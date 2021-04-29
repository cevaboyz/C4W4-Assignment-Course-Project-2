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



total_emissions <- c(triplenine_emissions,twoohohtwo_emissions,twoohohfive_emissions,twoohoheight_emissions)

year_names <- c("1999", "2002", "2005", "2008")


colors <- c("firebrick1", "darkorange1", "gold1", "greenyellow")


png(filename = "plot1.png", width = 16, height = 12 , units = "cm", res = 600 )

plot1 <- barplot(height = total_emissions/1000, names = year_names, xlab = "Years", ylab= expression('total PM'[2.5]*' emission in kilotons'),ylim=c(0,8000), main=expression('Total PM'[2.5]*' emissions at various years in kilotons'),col=colors)

text(x = plot1 , y = round(total_emissions/1000,2), label = round(total_emissions/1000,2), pos = 3, cex = 0.8, col = "black")

dev.off()

#ending




