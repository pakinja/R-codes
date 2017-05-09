library(plyr)
ret <- read.csv("Retail.csv")

fechas <- as.Date(ret$fecha_venta)
monto <- ret$monto_venta#/max(ret$monto_venta)

ret_1 <- data.frame(fechas,monto)
ret_or <- ret_1[order(ret_1$fechas),]
#ret_mt <- ddply(ret_or, .(fechas), summarise, monto=sum(monto))

ret_mt1 <- rowsum(ret_or$monto, format(fechas, '%Y-%m')) 
ts <- ts(ret_mt1, frequency=12, start=c(2008,01))
plot.ts(ts, main="Ventas Mens. Radio Shack 2008-2012")
fechas <- seq(as.Date("2008/1/1"), length.out = length(ts), by = "months")

print(ts)

#-------------
np <- length(ts)
ejex.mes <- seq(fechas[1],fechas[np], "months")
ejex.ano <- seq(fechas[1],fechas[np],"years")
plot(fechas, ts, xaxt="n", panel.first = grid(),type="l",
     ylab="ventas.mes", lwd = 2)
axis.Date(1, at=ejex.mes, format="%m/%y")
axis.Date(1, at=ejex.ano, labels = FALSE, tcl = 0.2)

#
boxplot(ts ~ cycle(ts))
cycle(ts)
#
ts_desc = decompose(ts)
plot(ts_desc, xlab='Año')
plot(log(ts))
#
x = log(ts)
dif_x = diff(x)
plot(dif_x)
