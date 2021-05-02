## Plot3

dir.create("./course_project_3")

setwd("./course_project_3")


require(ggplot2)

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

Baltimore.types.each.year <- aggregate(Baltimore_emissions$Emissions, list(Baltimore_emissions$type, Baltimore_emissions$year), mean)


png(filename = "plot3.png", width = 700, height = 700 , units = "px")

g <- ggplot2::ggplot(Baltimore.types.each.year, aes(y=x, x=Group.2), label = round(Baltimore.types.each.year$x,2))

g <- g + geom_point(aes(colour = factor(Group.1)), size=4)

g <- g+geom_line(aes(group=Group.1,colour=Group.1))

g <- g + ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ", "City by various source types", sep = "")))

g <- g + xlab("Years")

g <- g + ylab("Mean of PM [2.5] emission in tons")

g

dev.off()




