library(data.table)

system.time( NEI <- as.data.table( readRDS("summarySCC_PM25.rds")) )
system.time( SCC <- as.data.table( readRDS("Source_Classification_Code.rds") ) )

save(NEI, file="NEI.rda", compress=FALSE)
save(SCC, file="SCC.rda", compress=FALSE)
