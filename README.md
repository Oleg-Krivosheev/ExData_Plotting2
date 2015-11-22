# ExData_Plotting2
Exploratory Data Analysis, Project #2

## Data preparation

Tables were loaded once as RDS and then saved as RDA/XDR. Cut reading back time from 60+ seconds to ~10 seconds.
Another option would be to save as SQLite database and load using *sqldf* package.

## After loading

Data were processed using aggregate() and plotted either using case plotting system or ggplot2.