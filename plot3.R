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

NEI <- subset(NEI, fips %in% c(24510))

q <- as.data.table( aggregate(NEI$Emissions, by=list(year=NEI$year, type=NEI$type), FUN=sum) )

setnames(q, c("Year", "Type", "Emissions") )

qplot(Year, Emissions, facets=.~Type, data=q,
      color=Type, geom=c("line"),
      main="Emission of PM(2.5) per type - Baltimore city, Mariland")

ggsave(filename="plot3.png", width=10)
