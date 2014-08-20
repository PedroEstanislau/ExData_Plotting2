library(sqldf)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#1- Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
T_Emissions_by_Year <- aggregate(NEI$Emissions ~ NEI$year, NEI, sum)
plot(T_Emissions_by_Year,type='l', xlab="Year",
     ylab="PM2.5 Emission",main= "Total emissions decreased in the US from 1999 to 2008")

png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(T_Emissions_by_Year,type='l', xlab="Year",
     ylab="PM2.5 Emission",main= "Total emissions decreased in the US from 1999 to 2008")
dev.off()