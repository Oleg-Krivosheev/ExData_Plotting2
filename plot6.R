# Repo: https://github.com/Oleg-Krivosheev/ExData_Plotting2/
library(data.table)
library(ggplot2)

# if data are preprocessed, load it faster by uncommenting the line
#load("NEI.rda")
#load("SCC.rda")

NEI <- as.data.table( readRDS("summarySCC_PM25.rds") )
SCC <- as.data.table( readRDS("Source_Classification_Code.rds") )

vhs     <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vhs.sel <- SCC[vhs,]$SCC

# selection by source and fips
vhs.src  <- subset(NEI, NEI$SCC %in% vhs.sel)
city.sel <- subset(vhs.src, fips %in% c("24510","06037"))

# aggregate data
q <- as.data.table( aggregate( city.sel$Emissions,
                               by=list(city.sel$year, city.sel$fips), FUN=sum, na.rm=TRUE) )

setnames(q, c("Year", "City", "Emissions") )

q[, City := c(rep("Los Angeles", times=4), rep("Baltimore", times=4))]

# rescale
q[, Emissions := Emissions/1.0e+3]

png("plot6.png", width=768, height=512)

p <- qplot(Year, Emissions, data=q,
           facets = .~City, color=City, geom=c("line")) +
           labs(x="Year", y="PM2.5 Emission, mln tons") +
           labs(title="PM2.5 Emissions for Los Angles and Baltimore City, 1999-2008")
print(p)

dev.off()
