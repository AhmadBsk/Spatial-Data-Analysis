# data.frame,geom_point,scale_color{ggplot2}
library(readxl)
library(sp)
library(geoR)
library(ggplot2)
library(INLA)

setwd("C:/Users/ACER/Desktop/cupper data/1401-06-31/SamiroumGeochemistry-6352")
df <- read_xlsx("6352.xlsx",sheet = "Sheet1")
d <- data.frame(x=df$X_UTM,y=df$Y_UTM,cu=df$Cu)

summary(d)

x1 <- c(min(df$X_UTM),min(df$Y_UTM))
x2 <- c(min(df$X_UTM),max(df$Y_UTM))
x3 <- c(max(df$X_UTM),max(df$Y_UTM))
x4 <- c(max(df$X_UTM),min(df$Y_UTM))
x5 <- c(min(df$X_UTM),min(df$Y_UTM))
borders <- rbind(x1,x2,x3,x4,x5)
colnames(borders) <- c("x", "y")
coords <- matrix(c(df$X_UTM,df$Y_UTM), ncol = 2)
colnames(coords) <- c("x", "y")
data <- df$Cu

mydf <- structure(list(coords,data,borders),.Names = c("coords","data","borders"))

#data(parana)

ggplot(data.frame(cbind(mydf$coords,mydf$data)))+
  geom_point(aes(x, y, color =mydf$data), size = 2) +
  coord_fixed(ratio = 1) +
  scale_color_gradient(low = "blue", high = "orange") +
  geom_path(data = data.frame(mydf$border), aes(x, y)) +
  theme_bw()

