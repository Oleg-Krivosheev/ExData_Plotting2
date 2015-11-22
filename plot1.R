library(data.table)

NEI <- data.table()
SCC <- data.table()

system.time( load("NEI.rda") )
system.time( load("SCC.rda") )

object.size(NEI)
object.size(SCC)

class(NEI)
class(SCC)

x <- aggregate(NEI$Emissions, by=list(Category=NEI$year), FUN=sum)

class(x)

colnames(x) <- c("Year", "Emissions")

png("plot1.png", width=500, height=500)

plot(x$Year, x$Emissions,
    type="o", col=c("red"),
    xlab="Year", ylab="Emissions",
    main="Emission of PM(2.5) per year of all sources")

dev.off()
