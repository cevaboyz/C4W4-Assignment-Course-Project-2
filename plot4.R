## Plot 4 

dir.create("./course_project_4")

setwd("./course_project_4")


install.packages("lubridate")

library(lubridate)
library(dplyr)

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileurl, destfile = "NEIrecords.zip", method = "curl")

unzip("NEIrecords.zip")



NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

years <- lubridate::as_date(as.character(NEI$year), format = "%Y")

years <- year(years)



coal_SCC <- SCC[grep("*coal*|*Coal*",SCC$Short.Name),]$SCC

coal_data <- NEI[NEI$SCC %in% coal_SCC,]

coal_aggregated  <- aggregate(coal_data, list(coal_data$year), mean)



png(filename = "plot4.png", width = 700, height = 700 , units = "px")

g <- ggplot(coal_aggregated, aes(x=Group.1, y=Emissions, group =1)) + geom_point(aes(colour = factor(Group.1)), size = 4)+geom_line()

g <- g + geom_text(aes(label=round(coal_aggregated$Emissions,2),hjust=0, vjust=0))

g <- g + xlab("Years")

g <- g + ylab("Mean of emissions from coal combustion-related sources in the US")

g

dev.off()
