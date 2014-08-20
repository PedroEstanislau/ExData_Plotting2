library(sqldf)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#5 - How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# reorganizing plot data:


#the column . needs to be replace by _
plot5_aggdata <- sqldf("select year,sum(Emissions) as TEmissions from NEI, SCC 
                     where fips = '24510' and SCC.Data_Category='Onroad' and NEI.SCC = SCC.SCC group by year")



qplot(year, TEmissions, data = plot5_aggdata, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Motor vehicle sources changed from 1999–2008 in Baltimore City")

png(filename = "plot5.png", width = 640, height = 640, units = "px", bg = "transparent")
qplot(year, TEmissions, data = plot5_aggdata, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Motor vehicle sources changed from 1999–2008 in Baltimore City")
dev.off()


                                                                                                  se = FALSE)


d.tmp1 <- NEI[NEI$SCC %in% SCC[grep("Mobile", SCC$EI.Sector), 1], ]
d.tmp3 <- d.tmp1[which(d.tmp1$fips == "24510"), ]
d.tmp2 <- SCC[, c(1, 4)]
d5 <- merge(d.tmp3, d.tmp2, by.x = "SCC", by.y = "SCC")[, c(4, 6, 7)]
# removing outliers and sources out of our interest:
d5[d5$Emissions > 15, ] <- NA
d5 <- d5[which(d5$EI.Sector != "Mobile - Commercial Marine Vessels"), ]
d5 <- d5[which(d5$EI.Sector != "Mobile - Aircraft"), ]
# plotting:
require("lattice")
## Loading required package: lattice
xyplot(Emissions ~ year | EI.Sector, d5, layout = c(4, 2), ylab = "Emissions", 
       xlab = "years", panel = function(x, y) {
               panel.xyplot(x, y)
               panel.lmline(x, y, lty = 1, col = "red")
               par.strip.text = list(cex = 0.8)
       }, as.table = T)

#6 - Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
# reorganizing plot data:
data <- rbind(d.baltim <- NEI[which(NEI$fips == "24510"), ], d.lac <- NEI[which(NEI$fips == 
                                                                                        "06037"), ])
data$fips[which(data$fips == "24510")] <- "Baltimore City"
data$fips[which(data$fips == "06037")] <- "Los Angeles County"
names(data)[1] <- "Cities"
# plotting:
require("ggplot2")
g6 <- ggplot(data, aes(x = year, y = Emissions, fill = Cities))
g6 + geom_bar(stat = "identity", position = position_dodge())
