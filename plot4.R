library(sqldf)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
                                                                                     se = FALSE)

#4 - Across the United States, how have emissions from coal combustion-related 
#sources changed from 1999–2008?


#the column . needs to be replace by _
plot4_aggdata <- sqldf("select year,EI_Sector as Sector,sum(Emissions) as TEmissions from NEI, SCC 
                     where NEI.SCC = SCC.SCC group by year,EI_Sector")


coal_subset <- sqldf("select * from plot4_aggdata where Sector like '%Coal'")


qplot(year, TEmissions, data = coal_subset, group = Sector, color = Sector, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Emissions and Total Coal Combustion for the United States")

png(filename = "plot4.png", width = 640, height = 640, units = "px", bg = "transparent")
qplot(year, TEmissions, data = coal_subset, group = Sector, color = Sector, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Emissions and Total Coal Combustion for the United States")
dev.off()

