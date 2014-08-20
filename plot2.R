library(sqldf)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#2 - Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

baltimore_subset <- sqldf("select * from NEI where fips = '24510'")
T_Balitmore_Emissions_by_Year <- aggregate(Emissions ~ year, baltimore_subset, sum)
plot(T_Balitmore_Emissions_by_Year, 
      type="l", main="PM2.5 decreased in the Baltimore City, Maryland (fips == \"24510\")")

png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(T_Balitmore_Emissions_by_Year, 
     type="l", main="PM2.5 decreased in the Baltimore City, Maryland (fips == \"24510\")")
dev.off()
