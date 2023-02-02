
#IDW 
library(readxl)
library(gstat) 
library(sp) 
library(sf) 
# library(mapview)

setwd("C:/Users/ACER/Desktop/cupper data/1401-06-31/SamiroumGeochemistry-6352")

df <- read_xlsx("6352.xlsx",sheet = "Sheet1")
spat.df <- df
coordinates(spat.df) <- c('long','lat') 

# extracting the coords
df_coord <- df[,4:5]
#Converting to sf object  
df.sf.point <- st_as_sf(x = df_coord, coords = c("lat", "long"),crs = "+proj=longlat +datum=WGS84")

# construct a grid of locations to predict at 
lat.range = range(df$lat)
long.range = range(df$long)
grid <- expand.grid(long=seq(from=long.range[1], to=long.range[2], by=0.001),lat=seq(from=lat.range[1], to=lat.range[2], by=0.001))
 plot(grid, las = 1)

spat.grid <- grid 

# convert grid to a SpatialPoints object 
coordinates(spat.grid) <- c('long','lat') 

# and tell sp that this is a grid 
gridded(spat.grid) <- T 

sampinterp.idw <- idw(formula = df$Cu ~ 1, locations = spat.df, newdata = spat.grid) 

sampinterp.idw@data$var1.pred 
# or, if predicting on a grid, can use bubble or spplot to plot the gridded values 
spplot(sampinterp.idw, 'var1.pred',xlab = "long", ylab = "lat",scales=list(draw=TRUE))

#
#  #power 1
  sampinterp1.idw1 <- gstat::idw(formula = df$Cu ~ 1, locations = spat.df, newdata = spat.grid, idp = 1)
  spplot(sampinterp1.idw1, 'var1.pred',xlab = "long", ylab = "lat",scales=list(draw=TRUE))
#
#  # power 2-- default same as sampinterp.idw,
  sampinterp1.idw2 <- gstat::idw(formula = df$Cu ~ 1, locations = spat.df, newdata = spat.grid, idp = 2)
  spplot(sampinterp1.idw2, 'var1.pred',xlab = "long", ylab = "lat",scales=list(draw=TRUE))

# # power 5,
 sampinterp1.idw5 <- gstat::idw(formula = df$Cu ~ 1, locations = spat.df, newdata = spat.grid, idp = 5)
 spplot(sampinterp1.idw5, 'var1.pred',xlab = "long", ylab = "lat",scales=list(draw=TRUE))

# # power 10,
 sampinterp1.idw10 <- gstat::idw(formula = df$Cu ~ 1, locations = spat.df, newdata = spat.grid, idp = 10)
 spplot(sampinterp1.idw10, 'var1.pred',xlab = "long", ylab = "lat",scales=list(draw=TRUE))
 

