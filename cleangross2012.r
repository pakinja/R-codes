library(dplyr)
library(data.table)

data <- read.csv("gros2012.csv", skip = 4, nrows = 190)
data <- subset(data, select = -c( X.2, X.5))d
colnames(data) <-  c("Shortname","id","Largename", "GDP")

colgdp <- as.numeric(gsub(",","", data$GDP))
data$GDP <- colgdp

mean(data$GDP)
