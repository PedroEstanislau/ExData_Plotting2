library(sqldf)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore_subset_bytype <- sqldf("select year, type,sum(Emissions) as TEmissions from NEI where fips = '24510' group by year, type")


#3 - Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

qplot(year, TEmissions, data = baltimore_subset_bytype, group = type, color = type, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in Baltimore City by Type of Pollutant")

                                                                                                   
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")
qplot(year, TEmissions, data = baltimore_subset_bytype, group = type, color = type, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in Baltimore City by Type of Pollutant")
dev.off()

