# Repo: https://github.com/Oleg-Krivosheev/ExData_Plotting2/
library(data.table)

# if data are preprocessed, load it faster by uncommenting the line
# load("NEI.rda")

NEI <- as.data.table( readRDS("summarySCC_PM25.rds") )

q <- as.data.table( aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum, na.rm=TRUE) )

setnames(q, c("Year", "Emissions") )

png("plot1.png", width=512, height=512)

plot(q$Year, q$Emissions/1.0e+6,
     type = "o", pch = 19, col=c("red"),
     xlab="Year", ylab="PM2.5 Emissions, mln tons",
     ylim=c(0,8),
     main="Total PM2.5 emission from all sources, 1999-2008")

dev.off()
