library(dplyr)
library(plyr)
library(ggplot2)

data <- read.csv("retail.csv")

fechas <- as.Date(data$fecha_venta)
monto <- data$monto_venta

ret_1 <- data.frame(fechas,monto)

ret_or <- ret_1[order(ret_1$fechas),]
set<- rowsum(ret_or$monto, format(fechas, '%Y-%m'))
colnames(set) <- ("Sales")

plot(set)
##----------------------------
part <- 0.8
N <- nrow(set)
samsize <- floor(part*N)
N_list <- seq_len(N)
train_sec <- sample(N_list, size = samsize)
test_sec <- setdiff(N_list, train_sec)

train_set <- set[train_sec,]
test_set<- set[-train_sec,]

#----------------------------
N_train_set <- length(train_set)
pred <- seq(1:N_train_set)


mod_1 <- lm(train_set~pred)

summary(mod_1)

plot(pred, train_set, xlab = "Time", ylab = "Sales", col ="red")
abline(mod_1, col = "blue")

a <- as.data.frame(x = test_sec)

plot(predict(mod_1, x = 4))
#--------------------
mod_1$coefficients
mod_1$model
mod_1$coefficients[1]

model <- function(x){
  spred <- mod_1$coefficients[1]+mod_1$coefficients[1]*x
  return(spred)
}

model(test_sec)
test_sec

set_1 <- cbind(N_list, set)



