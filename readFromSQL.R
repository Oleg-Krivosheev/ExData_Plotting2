library(data.table)
library(sqldf)

NEI <- data.table()
SCC <- data.table()

db <- dbConnect(SQLite(), dbname="NEISCC.sqlite")

system.time( NEI <- dbReadTable(db, "NEI") )
system.time( SCC <- dbReadTable(db, "SCC") )

dbDisconnect(db)

object.size(NEI)
object.size(SCC)

class(NEI)
class(SCC)
