height = c(100, 200, 300, 450, 600, 800, 1000) 
distance = c(253, 337, 395, 451, 495, 534, 574)  
lmr = lm(distance ~ height + I(height^2))
lmr
newh = seq(100, 1000, 10)
fit = 200.211950 + 0.706182*newh - 0.000341*newh^2
fit

plot(height, distance)
lines(newh, fit, lty=1)
