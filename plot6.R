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

zips   <- subset(NEI, fips == "24510" | fips == "06037")
onroad <- subset(zips, type=="ON-ROAD")

q <- aggregate( onroad$Emissions, by=list(year=onroad$year, fips=onroad$fips), FUN=sum)

q["fips"] <- c(rep("Los Angeles", times=4), rep("Baltimore", times=4))

colnames(q)<-c("Year", "City", "Emissions")

qplot(Year, Emissions, data=q,
      facets = .~City, color=City, geom=c("line"))

ggsave(filename="plot6.png", width=10)
