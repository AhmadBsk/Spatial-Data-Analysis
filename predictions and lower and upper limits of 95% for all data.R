library(readxl)
library(sp)
library(geoR)
library(ggplot2)
library(INLA)

setwd("C:/Users/ACER/Desktop/cupper data/1401-06-31/SamiroumGeochemistry-6352")
df <- read_xlsx("6352.xlsx",sheet = "Sheet1")
db <- data.frame(x=df$X_UTM,y=df$Y_UTM,cu=df$Cu)


##make data base
x1 <- c(min(db$x),min(db$y))
x2 <- c(min(db$x),max(db$y))
x3 <- c(max(db$x),max(db$y))
x4 <- c(max(db$x),min(db$y))
x5 <- c(min(db$x),min(db$y))
borders <- rbind(x1,x2,x3,x4,x5)
colnames(borders) <- c("x", "y")
coords <- matrix(c(db$x,db$y), ncol = 2)
colnames(coords) <- c("x", "y")
data <- db$cu

mydf <- structure(list(coords,data,borders),.Names = c("coords","data","borders"))


##show data with border
ggplot(data.frame(cbind(mydf$coords,mydf$data)))+
  geom_point(aes(x, y, color =mydf$data), size = 2) +
  coord_fixed(ratio = 1) +
  scale_color_gradient(low = "blue", high = "orange") +
  geom_path(data = data.frame(mydf$border), aes(x, y)) +
  theme_bw()

coo <- mydf$coords
summary(dist(coo))
#max.edge is the largest allowed triangle length; the lower the number the higher the resolution
#offset = c(inside the boundary triangle, outside the boundary triangle)
max.edge = diff(range(mydf$coords))/500
bound.outer = diff(range(mydf$coords))/500
mesh <- inla.mesh.2d(loc=mydf$coords, max.edge = max.edge, offset=c(max.edge, bound.outer))
plot(mesh)
points(coo, col = "red")

# mesh2 <- inla.mesh.2d(loc = mydf$coords, max.edge=c(1000, 1000), offset = c(500,500),cutoff = 300)
# plot(mesh2)
# points(coo, col = "red")

## spde <- inla.spde2.pcmatern(mesh = mesh, alpha = 2, constr = TRUE)
spde <- inla.spde2.matern(mesh = mesh, alpha = 2, constr = TRUE)
indexs <- inla.spde.make.index("s", spde$n.spde)

A <- inla.spde.make.A(mesh = mesh, loc = coo)
# dimension of the projection matrix
dim(A)
# number of observations
nrow(coo)
# number of vertices of the triangulation
mesh$n
#see the elemens of each row sum to 1
rowSums(A)

#we construct a grid called coop
bb <- bbox(borders)
x <- seq(bb[1, "min"] - 1, bb[1, "max"] + 1, length.out = 100)
y <- seq(bb[2, "min"] - 1, bb[2, "max"] + 1, length.out = 100)
coop <- as.matrix(expand.grid(x, y))

ind <- point.in.polygon(coop[, 1], coop[, 2],borders[, 1], borders[, 2])
coop <- coop[which(ind == 1), ]
plot(coop, asp = 1)

Ap <- inla.spde.make.A(mesh = mesh, loc = coop)
dim(Ap)   

# stack for estimation stk.e
stk.e <- inla.stack(
  tag = "est",
  data = list(y = db$cu),
  A = list(1, A),
  effects = list(data.frame(b0 = rep(1, nrow(coo))), s = indexs)
)

# stack for prediction stk.p
stk.p <- inla.stack(
  tag = "pred",
  data = list(y = NA),
  A = list(1, Ap),
  effects = list(data.frame(b0 = rep(1, nrow(coop))), s = indexs)
)

# stk.full has stk.e and stk.p
stk.full <- inla.stack(stk.e, stk.p)

formula <- y ~ 0 + b0 + f(s, model = spde)
res <- inla(formula,
            data = inla.stack.data(stk.full),
            control.predictor = list(
              compute = TRUE,
              A = inla.stack.A(stk.full)
            )
)

index <- inla.stack.index(stk.full, tag = "pred")$data

pred_mean <- res$summary.fitted.values[index, "mean"]
pred_ll <- res$summary.fitted.values[index, "0.025quant"]
pred_ul <- res$summary.fitted.values[index, "0.975quant"]

dpm <- rbind(
  data.frame(
    east = coop[, 1], north = coop[, 2],
    value = pred_mean, variable = "pred_mean"
  ),
  data.frame(
    east = coop[, 1], north = coop[, 2],
    value = pred_ll, variable = "pred_ll"
  ),
  data.frame(
    east = coop[, 1], north = coop[, 2],
    value = pred_ul, variable = "pred_ul"
  )
)
dpm$variable <- as.factor(dpm$variable)

ggplot(dpm) + geom_tile(aes(east, north, fill = value)) +
  facet_wrap(~variable, nrow = 1) +
  coord_fixed(ratio = 1) +
  scale_fill_gradient(
    name = "Rainfall",
    low = "blue", high = "orange"
  ) +
  theme_bw()
## setwd("C:/Users/ACER/Desktop/cupper data/1401-06-31/SamiroumGeochemistry-6352/inla")
# save(pred_mean,file="pred_mean.Rda")
# save(pred_ll,file="pred_ll.Rda")
# save(pred_ul,file="pred_ul.Rda")

# data <- data.frame(east = coop[, 1], north = coop[, 2],value = pred_mean)
# 
# ggplot(data) + geom_tile(aes(east, north, fill = value)) +
#   scale_fill_gradient(
#     name = "Rainfall",
#     low = "blue", high = "orange"
#   ) +
#   theme_bw()