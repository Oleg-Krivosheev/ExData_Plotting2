# Repo: https://github.com/Oleg-Krivosheev/ExData_Plotting2/
library(data.table)
library(ggplot2)

# if data are preprocessed, load it faster by uncommenting the line
load("NEI.rda")

NEI <- as.data.table( readRDS("summarySCC_PM25.rds") )

# filter out Baltimore City, MD
NEI.sel <- subset(NEI, fips %in% c("24510"))

q <- as.data.table( aggregate(NEI.sel$Emissions, by=list(NEI.sel$year, NEI.sel$type), FUN=sum, na.rm=TRUE) )

setnames(q, c("Year", "Type", "Emissions") )

# scale
q[, Emissions := Emissions/1.0e+3]

png("plot3.png", width=768, height=512)

p <- qplot(Year, Emissions, facets=.~Type, data=q,
           color=Type, geom=c("line")) +
           labs(x="Year", y="PM2.5 Emission, thou tons") +
           labs(title="PM2.5 Emissions for Baltimore City, per type, 1999-2008")
print(p)

dev.off()
