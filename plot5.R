## Plot 5

dir.create("./course_project_5")

setwd("./course_project_5")


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

pimp_my_ride <- SCC[grep("*vehicle*|*Vehicle*",SCC$Short.Name),]$SCC

swaggeroni_brum_brum <- Baltimore_emissions[Baltimore_emissions$SCC %in% pimp_my_ride,]

clusterfuck_swaggeroni_baltimore <- aggregate(swaggeroni_brum_brum$Emissions, list(swaggeroni_brum_brum$year), mean)


png(filename = "plot5.png", width = 700, height = 700 , units = "px")

g <- ggplot(clusterfuck_swaggeroni_baltimore, aes(x=Group.1, y=x, group =1)) + geom_point(aes(colour = factor(Group.1)), size = 4)+geom_line()

g <- g + geom_text(aes(label=round(clusterfuck_swaggeroni_baltimore$x,2),hjust=0.5, vjust=1.5))

g <- g + xlab("Years")

g <- g + ylab("Mean of emissions from vehicles sources in Baltimore")

g

dev.off()