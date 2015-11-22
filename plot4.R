# Repo: https://github.com/Oleg-Krivosheev/ExData_Plotting2/
library(data.table)

# if data are preprocessed, load it faster by uncommenting the line
#load("NEI.rda")
#load("SCC.rda")

NEI <- as.data.table( readRDS("summarySCC_PM25.rds") )
SCC <- as.data.table( readRDS("Source_Classification_Code.rds") )

# selecting coal combustion related data
cl   <- grepl("coal", SCC$EI.Sector, ignore.case=TRUE)
sc   <- SCC[cl,]$SCC
coal <- subset(NEI, NEI$SCC %in% sc)

q <- as.data.table( aggregate(coal$Emissions, by=list(coal$year), FUN=sum, na.rm=TRUE) )

setnames(q, c("Year", "Emissions") )

png("plot4.png", width=512, height=512)

plot(q$Year, q$Emissions/1.0e+3,
     type="o", pch = 19, col=c("red"),
     xlab="Year", ylab="PM2.5 Emissions, thou tons",
     ylim=c(300, 600),
     main="Total PM2.5 Emissions from Coal Combustion, 1999-2008")

dev.off()
