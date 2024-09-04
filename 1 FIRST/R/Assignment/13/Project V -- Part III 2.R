# Part III

# Question a
# Scaling the nci.data as sd.data object
library(ISLR2)
nci.labs <- NCI60$labs
nci.data <- NCI60$data
sd.data <- scale(nci.data)

# Question b
# Here we are fitting hierarchical clustering on the given dataset using 
# various methods and showing the corresponding dendogram
par(mfrow = c(1,3))
data.dist <- dist(sd.data)
plot(hclust(data.dist), xlab = "", sub = "", ylab = "",
     labels = nci.labs, main = "Complete Linkage")
plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = nci.labs, main = "Average Linkage")
plot(hclust(data.dist,method = "single"), xlab = "", sub = "", ylab = "",
     labels = nci.labs, main = "Single Linkage")
hc.out <- hclust(dist(sd.data))


# Question c
# Cutting the tree at best distance value
hc.clusters <- cutree(hc.out, 4)
table(hc.clusters, nci.labs)
par(mfrow = c(1, 1))
plot(hc.out, labels = nci.labs)
abline(h = 139, col = "red")

# Question d
# Let sets seed to 16 and fit k means using nstart = 20

set.seed(16)
km.out <- kmeans(sd.data, 4, nstart = 20)

# Question e
km.clusters <- km.out$cluster
summary(km.clusters)


# Question f
plot(km.clusters)
