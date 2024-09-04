# Q.10)
data <- USArrests

head(data)

## a) Applying K-Means Algorithm with k = 2 and ploting it in a single graph and interpret it carefully.

## Before applying K-means clustering algorithm, we need to scale the values at a common scale since Kmeans depends on distance (euclidean distance metrics)
library(dplyr)
scaled_data <- data %>% scale()

head(scaled_data)


## Applying Kmeans Clustering
scaled_kmeans_clust <- kmeans(scaled_data, centers = 2, nstart = 20)

scaled_kmeans_clust$cluster

## We have used centers = 2 so we have 2 clusters. These two clusters explain 86.75% of the point variability.


plot(scaled_data, col = (scaled_kmeans_clust$cluster + 1),
     main = "K-Means Clustering with K=2",
     xlab = "",
     ylab = "",
     pch = 20, cex = 2)

### From this graph we can clearly see that the two groups separated by our clustering algorithm. 
### One of the group is in green color whereas the other group is in red color. 
### There are 2 red points which fall nearer to the green cluster.

# b) Add cluster centers for the plot of clusters formed with k = 2 and interpret it carefully.


## Visualizing clusters

y_kmeans <- scaled_kmeans_clust$cluster

cluster_centroids <- scaled_kmeans_clust$centers

library(cluster)
clusplot(x = scaled_data,
         y_kmeans,
         main = "Clustering using k= 2",
         color = TRUE,
         labels = 0,
         xlab = '',
         ylab = '')

# Add cluster centroids
points(cluster_centroids, col = c('red', 'blue'), pch = 8, cex = 2)

## We can clearly see two different clusters with their centroid located with red star and blue star for each of the cluster.



## c) Applying K-Means Algorithm with k = 3 and ploting it in a single graph and interpret it carefully.


## Applying Kmeans Clustering with k = 3
scaled_kmeans_clust <- kmeans(scaled_data, centers = 3, nstart = 20)

scaled_kmeans_clust$cluster

## We have used centers = 2 so we have 2 clusters. These two clusters explain 86.75% of the point variability.


plot(scaled_data, col = (scaled_kmeans_clust$cluster + 1),
     main = "K-Means Clustering with K=3",
     xlab = "",
     ylab = "",
     pch = 20, cex = 2)

### From this graph we can clearly see that the three groups separated by our clustering algorithm. 
### One of the group is in green color whereas the other group is in red color and the last group is in blue color. 
### Some of the data points of green and red color are overlapped.
### The right side of cluster for k=2 and k=3 are same but the left side of cluster is broken down into another cluster.


# d) Add cluster centers for the plot of clusters formed with k = 3 and interpret it carefully.


## Visualizing clusters

y_kmeans <- scaled_kmeans_clust$cluster

cluster_centroids <- scaled_kmeans_clust$centers

library(cluster)
clusplot(x = scaled_data[,c("Assault", "UrbanPop")],
         y_kmeans,
         main = "Clustering using k= 3 with their centroids",
         color = TRUE,
         labels = 0,
         xlab = '',
         ylab = '')

# Add cluster centroids
points(cluster_centroids, col = c('red', 'blue', 'green'), pch = 8, cex = 2)

## We can clearly see two different clusters with their centroid located with red star and blue star and green star for each of the cluster.
