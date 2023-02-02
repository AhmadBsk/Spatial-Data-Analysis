
#variogram

library(readxl)
library(gstat) 


setwd("C:/Users/ACER/Desktop/cupper data/1401-06-31/SamiroumGeochemistry-6352")
df <- read_xlsx("6352.xlsx",sheet = "Sheet1")

#df$long,df$lat,df$Cu

# distances between points
quantile(dist(df[,2:3])) 
#How many point pairs are there in our data
(dim(df)[1] * (dim(df)[1] - 1))/2

#Variogram cloud
vgm <- variogram(Cu ~ 1, locations = ~X_UTM + Y_UTM, data = df,cloud = T)
head(vgm, n=3)  # Take a look at the data that are returned by the variogram function
plot(vgm, main = "Variogram cloud  of Cu data", xlab = "lag in meters")

#Variogram map spatial depency
v.map = variogram(Cu~1, locations = ~X_UTM + Y_UTM, data=df, cutoff = 25000, width = 1000, map = TRUE)
plot(v.map, threshold = 5,main = "Variogram map spatial depency")

#Empirical variogram,  with the number of points that contributed to each estimate
v <- variogram(Cu~1, locations = ~X_UTM + Y_UTM, data=df)
plot(v, plot.numbers=T,pch=3,main = "Empirical variogram")

#properties of Variogram
nugget <- v$gamma[v$np==1393]
sill <- v$gamma[v$np==14762]
range <- v$dist[v$np==14762]

#Defining variogram bins
par(mfrow = c(2,3), oma = c(2,2,0,0), mar = c(3,3,0,0), mgp = c(1.5,0.5,0),xpd = NA)
for (bw in seq(20, 220, by = 40)) {
  v<-variogram(Cu~1, locations = ~X_UTM + Y_UTM, data=df, width=bw)
  plot(v$dist, v$gamma, xlab=paste("bin width", bw))
  cat(bw, " bin width has these np:", v$np) 
}
#Variogram modelling and fitting
v <- variogram(Cu~1, locations = ~X_UTM + Y_UTM, data=df, cressie=TRUE); 
plot(v, plot.numbers=T)
m1 <- vgm(sill, "Exp", range, nugget); 
plot(v, plot.numbers=T, model=m1,main = "Variogram modelling and fitting Parameters determined by eye")
m2 <- fit.variogram(v, m1); 
cat("Parameters determined automatically are: ")
m2
plot(v, plot.numbers=T, model=m2,main = "Variogram modelling and fitting Parameters determined automatically")
# Fix the nugget, fit only the sill of Exponential model
m2a <- fit.variogram(v,m1,fit.sills=c(F,T),fit.range=F); 
if (attr(m2a, "singular")) stop("singular fit")
cat("Parameters determined by eye are: ")
m2a
cat("SSE of automatic fit ", attr(m2, "SSErr"))
cat("SSE of manual fit ", attr(m2a, "SSErr"))


