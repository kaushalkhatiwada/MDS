# Use NCI60 data of ISLR2 package and page 543 of ISLR2 book to do as follows in R Studio to knit PDF output:
  
# a.	
# Scale the nci.data as sd.data object
sd.data <- scale(nci.data)


# b.	
# Fit hierarchical cluster analysis on the sd.data using complete, average and single linkage methods, show the results with dendrogram and interpret them carefully
par(mfrow = c(1,3))
data.dist <- dist(sd.data)
plot(hclust(data.dist), xlab = "", sub = "", ylab = "",
     labels = nci.labs, main = "Complete Linkage")
plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = nci.labs, main = "Average Linkage")
plot(hclust(data.dist,method = "single"), xlab = "", sub = "", ylab = "",
     labels = nci.labs, main = "Single Linkage")


# c.	
# Find the best number for clusters using “cutree” function with best distance value
clusters <- hclust(dist(sd.data))
trees <- cutree(clusters, 3)
table(trees, nci.labs)


# d.	
# Use your roll number as set.seed and perform k-means clustering on sd.data with the best number of clusters/distance value with nstart=20
set.seed(13)
km <- kmeans(sd.data, center=3, nstart = 20)
km.clusters <- km$cluster


# e.	
# Get summary of the k-means clustering and interpret them carefully
summary(km.clusters)


# f.	
# Plot this k-means results using base r plot and cluster package and interpret them carefully
par(mfrow = c(1,1))
plot(nci.data,col=km.clusters)
points(km$centers)
library(cluster)

clusplot(nci.data,
         km.clusters,
         shade = TRUE,
         lines=0,
         color=TRUE)
