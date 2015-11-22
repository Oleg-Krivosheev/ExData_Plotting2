library(data.table)

NEI <- data.table()
SCC <- data.table()

system.time( load("NEI.rda") )
system.time( load("SCC.rda") )

object.size(NEI)
object.size(SCC)

class(NEI)
class(SCC)

city   <- subset(NEI, fips %in% c(24510))
onroad <- subset(city, type %in% c("ON-ROAD"))

q <- as.data.table( aggregate( onroad$Emissions, by=list(year=onroad$year), FUN=sum) )

setnames(q, c("Year", "Emissions") )

png("plot5.png", width=512, height=512)

plot(q$Year, q$Emissions,
     type="o", col=c("red"),
     xlab="Year", ylab="Emissions from on-road vehicles",
     main="Emission of PM(2.5) per year from vehicles, City of Baltimore")

dev.off()
