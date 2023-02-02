
library(readxl)
library(sp)
library(sf)
library(gstat)
library(rgdal)
library(PerformanceAnalytics)
library(raster)
library(ggplot2)

# Dataset
setwd("C:/Users/ACER/Desktop/cupper data/1401-06-31/SamiroumGeochemistry-6352")
df <- read_xlsx("6352.xlsx",sheet = "Sheet1")

d <- data.frame(x=df$X_UTM,y=df$Y_UTM,a=df$Cu)
# d <- data.frame(x=df$long,y=df$lat,cu=df$Cu)

################################################################################
######################## grid  #################################################
################################################################################
ex = expand.grid(seq(min(d$x),max(d$x),l = 100),seq(min(d$y),max(d$y),l =100))
c = cbind(ex)
names(c) = c("x","y")
coordinates(c) = c("x","y")
gridded(c) = T
coordinates(d) = c("x","y")

################################################################################
########Variogram modelling and fitting#########################################
################################################################################
vgm <- variogram(a~1, data=d,cloud = T)
head(vgm, n=3)  # Take a look at the data that are returned by the variogram function
v <- variogram(a~1, data=d, cressie=TRUE)
#properties of Variogram
nugget <- v$gamma[v$np==1393]
sill <- v$gamma[v$np==14762]
range <- v$dist[v$np==14762]
m1 <- vgm(sill, "Exp", range, nugget);
m2 <- fit.variogram(v, m1); 
cat("Parameters determined automatically are: ")
m2
plot(v, plot.numbers=T, model=m2)
# setwd("C:/Users/ACER/Desktop/cupper data/1401-06-31/SamiroumGeochemistry-6352/ordinary kriging")
# save(m2,file="m2.Rda")
################################################################################
##############ordinary kriging interpolation####################################
################################################################################
ok = krige(a~1, loc = d,c, model = m2)
spplot(ok, 'var1.pred', main = "ordinary kriging predictions",xlab = "X_UTM", ylab = "Y_UTM",scales=list(draw=TRUE))
spplot(ok, 'var1.var',  main = "ordinary kriging variance",xlab = "X_UTM", ylab = "Y_UTM",scales=list(draw=TRUE))


y <- raster(k1,layer=1, values=TRUE)
##Generate GeoTifs to use in GIS
## setwd("C:/Users/ACER/Desktop/cupper data/1401-06-31/SamiroumGeochemistry-6352/ordinary kriging")
## save(ok,file="ok.Rda")
## writeGDAL(ok_sp['var1.pred'], 'figs/krige_pred.tif')
# setwd("C:/Users/ACER/Desktop/cupper data/1401-06-31/SamiroumGeochemistry-6352/idw")
# load("x.Rda")
# y@extent=x@extent

# setwd("C:/Users/ACER/Desktop/cupper data/1401-06-31/SamiroumGeochemistry-6352/ordinary kriging")
# KML(y, file='yok.kml',col=hcl.colors(11, "purples", rev = TRUE))
