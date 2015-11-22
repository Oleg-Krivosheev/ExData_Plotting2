# Repo: https://github.com/Oleg-Krivosheev/ExData_Plotting2/
library(data.table)

# if data are preprocessed, load it faster by uncommenting the line
#load("NEI.rda")
#load("SCC.rda")

NEI <- as.data.table( readRDS("summarySCC_PM25.rds") )
SCC <- as.data.table( readRDS("Source_Classification_Code.rds") )

vhs     <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vhs.sel <- SCC[vhs,]$SCC

vhs.src  <- subset(NEI, NEI$SCC %in% vhs.sel)
city.sel <- subset(vhs.src, fips %in% c("24510"))

q <- as.data.table( aggregate( city.sel$Emissions, by=list(year=city.sel$year), FUN=sum, na.rm=TRUE) )

setnames(q, c("Year", "Emissions") )

png("plot5.png", width=512, height=512)

plot(q$Year, q$Emissions,
     type="o", pch = 19, col=c("red"),
     xlab="Year", ylab="PM2.5 Emissions from motor vehicles, 100K tons",
     ylim=c(100, 450),
     main="PM2.5 Emissions from motor vehicles, Baltimore City, 1999-2008")

dev.off()
