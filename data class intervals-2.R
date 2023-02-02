library(readxl)
library(sp)
library(gstat)
library(RColorBrewer)
library(classInt)

# Dataset
setwd("C:/Users/ACER/Desktop/cupper data/1401-06-31/SamiroumGeochemistry-6352")
df <- read_xlsx("6352.xlsx",sheet = "Sheet1")

#pal <- brewer.pal(5, "Reds")
pal <- c("wheat1", "red3")

# Pretty standard deviations: The standard deviation is a statistic that tells you how tightly data
# are clustered around the mean. When the sizes are tightly clustered and the distribution curve is steep,
# the standard deviation is small
png('All cluster.png',width = 1920, height = 10001, pointsize = 20)
par(mfrow=c(10,2))
plot(classIntervals(df$Cu, n=5, style="sd"), pal=pal, main="Pretty standard deviations")
plot(df$long,df$lat,xlab = "long", ylab = "lat", col = findColours(classIntervals(df$Cu, n = 5,style="sd"),
                                                          pal), pch = 19,main="Pretty standard deviations")
legend("topleft", fill = attr(findColours(classIntervals(df$Cu, n = 5,style="sd"), pal), "palette"),
       legend = names(attr(findColours(classIntervals(df$Cu, n = 5,style="sd"), pal), "table")), bty = "n")


# Equal intervals
plot(classIntervals(df$Cu, n=5, style="equal"), pal=pal, main="Equal intervals")
plot(df$long,df$lat,xlab = "long", ylab = "lat", col = findColours(classIntervals(df$Cu, n = 5,style="equal"),
                                                         pal), pch = 19,main="Equal intervals")
legend("topleft", fill = attr(findColours(classIntervals(df$Cu, n = 5,style="equal"), pal), "palette"),
       legend = names(attr(findColours(classIntervals(df$Cu, n = 5,style="equal"), pal), "table")), bty = "n")

#Quantile
plot(classIntervals(df$Cu, n=5, style="quantile"), pal=pal, main="Quantile")
plot(df$long,df$lat,xlab = "long", ylab = "lat", col = findColours(classIntervals(df$Cu, n = 5,style="quantile"),
                                                                   pal), pch = 19,main="Quantile")
legend("topleft", fill = attr(findColours(classIntervals(df$Cu, n = 5,style="quantile"), pal), "palette"),
       legend = names(attr(findColours(classIntervals(df$Cu, n = 5,style="quantile"), pal), "table")), bty = "n")

# K-means
set.seed(1)
plot(classIntervals(df$Cu, n=5, style="kmeans"), pal=pal, main="K-means")
plot(df$long,df$lat,xlab = "long", ylab = "lat", col = findColours(classIntervals(df$Cu, n = 5,style="kmeans"),
                                                                   pal), pch = 19,main="K-means")
legend("topleft", fill = attr(findColours(classIntervals(df$Cu, n = 5,style="kmeans"), pal), "palette"),
       legend = names(attr(findColours(classIntervals(df$Cu, n = 5,style="kmeans"), pal), "table")), bty = "n")

# Fisher's method
plot(classIntervals(df$Cu, n=5, style="fisher"), pal=pal,main="Fisher's method")
plot(df$long,df$lat,xlab = "long", ylab = "lat", col = findColours(classIntervals(df$Cu, n = 5,style="fisher"),
                                                                   pal), pch = 19,main="Fisher's method")
legend("topleft", fill = attr(findColours(classIntervals(df$Cu, n = 5,style="fisher"), pal), "palette"),
       legend = names(attr(findColours(classIntervals(df$Cu, n = 5,style="fisher"), pal), "table")), bty = "n")

#Complete cluster
plot(classIntervals(df$Cu, n=5, style="hclust", method="complete"),pal=pal, main="Complete cluster")
plot(df$long,df$lat,xlab = "long", ylab = "lat", col = findColours(classIntervals(df$Cu, n = 5,style="hclust",
                                            method="complete"), pal), pch = 19,main="Complete cluster")
legend("topleft", fill = attr(findColours(classIntervals(df$Cu, n = 5,style="hclust", method="complete"), pal),
    "palette"),legend = names(attr(findColours(classIntervals(df$Cu, n = 5,style="hclust", method="complete"),
                                               pal), "table")), bty = "n")

#Single cluster
plot(classIntervals(df$Cu, n=5, style="hclust", method="single"),pal=pal, main="Single cluster")
plot(df$long,df$lat,xlab = "long", ylab = "lat", col = findColours(classIntervals(df$Cu, n = 5,style="hclust",
                                             method="single"), pal), pch = 19,main="single cluster")
legend("topleft", fill = attr(findColours(classIntervals(df$Cu, n = 5,style="hclust", method="single"), pal),
                    "palette"),legend = names(attr(findColours(classIntervals(df$Cu, n = 5,style="hclust",
                                             method="single"),pal), "table")), bty = "n")

#Bagged cluster
set.seed(1)
plot(classIntervals(df$Cu, n=5, style="bclust", verbose=FALSE),pal=pal, main="Bagged cluster")
plot(df$long,df$lat,xlab = "long", ylab = "lat", col = findColours(classIntervals(df$Cu, n = 5,style="bclust",
       verbose=FALSE),pal), pch = 19,main="Bagged cluster")
legend("topleft", fill = attr(findColours(classIntervals(df$Cu, n = 5,style="bclust", verbose=FALSE), pal),
       "palette"),legend = names(attr(findColours(classIntervals(df$Cu, n = 5,style="bclust", verbose=FALSE),
         pal), "table")), bty = "n")

#Jenks' method
plot(classIntervals(df$Cu, n=5, style="jenks"), pal=pal,main="Jenks' method")
plot(df$long,df$lat,xlab = "long", ylab = "lat", col = findColours(classIntervals(df$Cu, n = 5,style="jenks"),
                                                                   pal), pch = 19,main="Jenks' method")
legend("topleft", fill = attr(findColours(classIntervals(df$Cu, n = 5,style="jenks"), pal), "palette"),
       legend = names(attr(findColours(classIntervals(df$Cu, n = 5,style="jenks"), pal), "table")), bty = "n")

# Head Tails method
plot(classIntervals(df$Cu, style="headtails", thr = 1), pal=pal,main="Head Tails method")
plot(df$long,df$lat,xlab = "long", ylab = "lat", col = findColours(classIntervals(df$Cu, n = 5,style="headtails"),
                                                                   pal), pch = 19,main="Head Tails method")
legend("topleft", fill = attr(findColours(classIntervals(df$Cu, n = 5,style="headtails"), pal), "palette"),
       legend = names(attr(findColours(classIntervals(df$Cu, n = 5,style="headtails"), pal), "table")), bty = "n")
dev.off()
