library(data.table)

NEI <- data.table()
SCC <- data.table()

system.time( load("NEI.rda") )
system.time( load("SCC.rda") )

object.size(NEI)
object.size(SCC)

class(NEI)
class(SCC)

sel  <- grepl("Coal", SCC$SCC.Level.Three)
sc   <- SCC[sel,]
coal <- subset(NEI, NEI$SCC == sc$SCC)

q <- as.data.table( aggregate(coal$Emissions, by=list(year=coal$year), FUN=sum) )

setnames(q, c("Year", "Emissions") )

png("plot4.png", width=512, height=512)

plot(q$Year, q$Emissions,
     type="o", col=c("red"),
     xlab="Year", ylab="Emissions",
     main="Emission of PM(2.5) per year from Coal Combustion")

dev.off()
