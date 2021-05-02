## Plot 6
dir.create("./course_project_6")

setwd("./course_project_6")


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


Los_Angeles_emissions <- subset(NEI, NEI$fips == "06037")

compton_rides <- SCC[grep("*vehicle*|*Vehicle*",SCC$Short.Name),]$SCC

la_rides <- Los_Angeles_emissions[Los_Angeles_emissions$SCC %in% compton_rides,]

clusterfuck_swaggeroni_la <- aggregate(la_rides$Emissions, list(la_rides$year), mean)



wombo_combo_emissions <- rbind(clusterfuck_swaggeroni_baltimore, clusterfuck_swaggeroni_la)

wombo_combo_emissions2 <- cbind(clusterfuck_swaggeroni_baltimore, clusterfuck_swaggeroni_la)


BAnine <- clusterfuck_swaggeroni_baltimore[1,2]
BAohtwo <-clusterfuck_swaggeroni_baltimore[2,2]
BAohfive <-clusterfuck_swaggeroni_baltimore[3,2]
BAoheight <-clusterfuck_swaggeroni_baltimore[4,2]

LAnine <- clusterfuck_swaggeroni_la[1,2]
LAohtwo <- clusterfuck_swaggeroni_la[2,2]
Laohfive <- clusterfuck_swaggeroni_la[3,2]
LAoheight <- clusterfuck_swaggeroni_la[4,2]


BingoCity <- c(BAnine, BAohtwo, BAohfive, BAoheight, LAnine, LAohtwo, Laohfive, LAoheight)

Years <- c(1999, 2002, 2005,2008, 1999, 2002, 2005,2008)

colors1 <- c("yellow", "yellow","yellow", "yellow", "red","red","red","red")


png(filename = "plot6.png", width = 700, height = 700 , units = "px")

plot6 <- barplot(height = BingoCity, names = Years, xlab = "Years", ylim=c(0,110),ylab= expression('Mean of total PM'[2.5]*' emission'), main=expression("Mean of motor vehicles emission evolution in Baltimore and Los Angeles"),col=colors1)

text(x = plot6 , y = round(BingoCity,2), label = round(BingoCity,2), pos = 3, cex = 0.8, col = "black")

legend("topleft", inset = c(0.1, 0.1), legend = c("Baltimore", "Los Angeles"), col = c("yellow", "red"), horiz =F, bty = "n", pch = 19)

dev.off()


