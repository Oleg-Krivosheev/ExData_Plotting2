# Repo: https://github.com/Oleg-Krivosheev/ExData_Plotting2/
library(data.table)

# if data are preprocessed, load it faster by uncommenting the line
# load("NEI.rda")

NEI <- as.data.table( readRDS("summarySCC_PM25.rds") )

# filter out Baltimore City, MD
NEI.sel <- subset(NEI, fips %in% c("24510"))

q <- as.data.table( aggregate(NEI.sel$Emissions, by=list(NEI.sel$year), FUN=sum, na.rm=TRUE) )

setnames(q, c("Year", "Emissions") )

png("plot2.png", width=512, height=512)

plot(q$Year, q$Emissions/1.0e+3,
     type = "o", pch = 19, col=c("red"),
     xlab="Year", ylab="PM2.5 Emissions, thou tons",
     ylim=c(0,4),
     main="PM2.5 emission for Baltimore City, Maryland, 1999-2008")

dev.off()
