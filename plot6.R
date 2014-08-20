library(sqldf)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#the column . needs to be replace by _
plot6_aggdata_baltimore <- sqldf("select year,sum(Emissions) as TEmissions from NEI, SCC 
                     where fips ='24510' and SCC.Data_Category='Onroad' and NEI.SCC = SCC.SCC group by year")

plot6_aggdata_LA <- sqldf("select year,sum(Emissions) as TEmissions from NEI, SCC 
                     where fips ='06037' and SCC.Data_Category='Onroad' and NEI.SCC = SCC.SCC group by year")


plot6_aggdata_baltimore$Local <- "Baltimore"
plot6_aggdata_LA$Local <- "Los Angeles"

plot6_aggdata<-rbind(plot6_aggdata_baltimore, plot6_aggdata_LA)

qplot(year, TEmissions, data = plot6_aggdata, group = Local, color = Local,
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "motor vehicle sources in Baltimore City vs. Los Angeles County")

png(filename = "plot6.png", width = 640, height = 640, units = "px", bg = "transparent")
qplot(year, TEmissions, data = plot6_aggdata, group = Local, color = Local,
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "motor vehicle sources in Baltimore City vs. Los Angeles County")
dev.off()
