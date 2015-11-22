library(data.table)
library(sqldf)

db <- dbConnect(SQLite(), dbname="NEISCC.sqlite")

system.time( NEI <- as.data.table( readRDS("summarySCC_PM25.rds")) )
system.time( SCC <- as.data.table( readRDS("Source_Classification_Code.rds") ) )

dbWriteTable(conn = db, name = "NEI", value = NEI, row.names = FALSE)
dbWriteTable(conn = db, name = "SCC", value = SCC, row.names = FALSE)

dbListTables(db)

dbDisconnect(db)
