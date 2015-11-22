library(data.table)

NEI <- data.table()
SCC <- data.table()

system.time( load("NEI.rda") )
system.time( load("SCC.rda") )

object.size(NEI)
object.size(SCC)

class(NEI)
class(SCC)

q <- as.data.table( aggregate(NEI$Emissions, by=list(Category=NEI$year), FUN=sum) )

setnames(q, c("Year", "Emissions") )

png("plot1.png", width=512, height=512)

plot(q$Year, q$Emissions,
     type="o", col=c("red"),
     xlab="Year", ylab="Emissions",
     main="Emission of PM(2.5) per year from all sources")

dev.off()
