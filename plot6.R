library(data.table)
library(ggplot2)

NEI <- data.table()
SCC <- data.table()

system.time( load("NEI.rda") )
system.time( load("SCC.rda") )

object.size(NEI)
object.size(SCC)

class(NEI)
class(SCC)

zips   <- subset(NEI, fips %in% c("24510","06037"))
onroad <- subset(zips, type %in% c("ON-ROAD"))

class(zips)
class(onroad)

q <- as.data.table( aggregate( onroad$Emissions, by=list(year=onroad$year, fips=onroad$fips), FUN=sum) )

q[, fips := c(rep("Los Angeles", times=4), rep("Baltimore", times=4))]

setnames(q, c("Year", "City", "Emissions") )

qplot(Year, Emissions, data=q,
      facets = .~City, color=City, geom=c("line"))

ggsave(filename="plot6.png", width=10)
