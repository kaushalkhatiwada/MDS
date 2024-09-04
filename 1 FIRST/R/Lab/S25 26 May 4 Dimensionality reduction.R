
## Dimensional Reduction
# PCS
USArrests
str(USArrests)
head(USArrests)

library(dplyr)
USArrests.1 <- USArrests[,-3] %>% 
  scale


# Fittinfg pca
pca.1 <- prcomp(USArrests.1)
summary(pca.1)

library(psych)
# Rotation PCA with variance maximization
fa.2 <- psych::principal(USArrests.1,
                         nfactors = 3, rotate = "varimax")
fa.2

# Scree plot

#Biplot
biplot()



###################

# Multi dimensional scaling
# Fiting MDS 
USArrests.1 <- scale(USArrests[,-3])

  # Distance calculation
state.disimilarity <- dist(USArrests.1)

#MDS fit
mds.1 <- cmdscale(state.disimilarity)
summary(mds.1)   # Latent variable (V1 and V2)

#MDS plot
plot(mds.1,pch=19)
abline(h=0,v=0,lty=2)
text(mds.1,pos=4,labels= rownames(USArrests.1),col="tomato")
 # to minize stress use Sammon't strees [OPTIONAL]
library(MASS)
mds.2 <- MASS::sammon(state.disimilarity, trace=FALSE)
plot(mds.2$points,pch=19)
abline(h=0,v=0,lty=2)
text(mds.2$points,pos=4,labels= rownames(USArrests.1))


#Compare PCA and MDS
arrows(
  x0 = mds.2$points[,1], y0=mds.2$points[,2],
  x1 = pca.1$x[,1],y1=pca.1$x[,3],
  col = 'red',pch=19,cex=0.5
)
############################ S26 ###################
# kmean clustering with iris

str(iris)
table(iris$Species)


data(iris)
View(iris)

iris_1 <- iris[,-5]   # Remove 5th column of species

set.seed(240)
kmeans.res <- kmeans(iris_1,center=3,nstart=20)
kmeans.res

# Fit K-mean

#Confusion matrix
cm <- table(iris$Species,
            kmeans.res$cluster)
cm

#Accuracy
(accuracy<- sum(diag(cm))/sum(cm))  #0.893

(mce <- 1-accuracy)   #0.1067

#Model evaluation and visualization
library(ClusterR)
library(cluster)


# Hierarchical cluster analysis (HCA)
# Linkage method "Single"
hirar.1 <- hclust(state.disimilarity, method = 'single')
plot(hirar.1,
     labels = rownames(USArrests.1),
     ylab = "Distance")

summary(hirar.1)
hirar.1


# Linkage method "complete"
hirar.2 <- hclust(state.disimilarity, method = 'complete')
plot(hirar.2,
     labels = rownames(USArrests.1),
     ylab = "Distance")
