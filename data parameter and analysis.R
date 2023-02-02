#histogram,density,trend,Q-Q Plot
library(classInt)
library(readxl)

setwd("C:/Users/ACER/Desktop/cupper data/1401-06-31/SamiroumGeochemistry-6352")

df <- read_xlsx("6352.xlsx",sheet = "Sheet1")

summary(df)

#histogram,density,index plot of the sorted values.
par(mfrow=c(1,3))
#find bin
c=classIntervals(df$Cu, style="dpih")
num.bin=length(c$brks)
##
hist (df$Cu,num.bin)
plot (density (df$Cu, na.rm=TRUE))
plot (sort (df$Cu), pch=".")

#find trend  fit linear models
par(mfrow=c(1,3))
plot(df$long,df$lat,xlab = "long", ylab = "lat", pch=21, cex=log10(df$Cu-min(df$Cu)/mean(df$Cu)))
plot(df$long,df$Cu,xlab ="x",ylab =" cu")
abline(lm(df$Cu ~ df$long),col = 2)
plot(df$Cu,df$lat,ylab ="y",xlab =" cu")
abline(lm( df$Cu ~  df$lat),col = 2)

#Q-Q Plot
par(mfrow=c(1,1))
qqnorm(df$Cu,pch=19,col=4)
abline(mean(df$Cu),sd(df$Cu),col=2)


