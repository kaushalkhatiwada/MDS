

# 2nd assessment 2081 Qno 10 OR. 

###################### SHYAM ######
#Use the first four variables of the "iris" data.

# Load necessary libraries
library(cluster)

# Load and prepare the data
data(iris)
iris_data <- iris[, -5] # Use the first four variables

# a. Fit a k-means cluster model in the data with k=2 and k=3
set.seed(30)
kmeans_2 <- kmeans(iris_data, centers = 2, nstart = 20)
kmeans_3 <- kmeans(iris_data, centers = 3, nstart = 20)

# Display k-means results for k=3
print(kmeans_3)

# b. Plot the clusters formed with k=3 in a single graph and interpret them carefully
plot(iris_data[c("Sepal.Length", "Sepal.Width")], col = kmeans_3$cluster, 
     main = "K-means with 3 clusters", xlab = "Sepal Length", ylab = "Sepal Width")


# Interpretation: Upon looking in the plot, there is three clusters where cluster 1(green) can be totally distinguished for the remaining. The cluster 2(red) and cluster 3(black) are somewhat overlapped.


# c. Add cluster centers for the plot of clusters formed with k=3 above and interpret it carefully
points(kmeans_3$centers[, c("Sepal.Length", "Sepal.Width")], col = 1:3, pch = 8, cex = 3)

# d. Compare the k=3 cluster variable with Species variable of iris data using confusion matrix and interpret the result carefully
# Add the clustering results to the original data
iris$Cluster <- as.factor(kmeans_3$cluster)

# Map clusters to species
species_levels <- levels(iris$Species)
cluster_to_species <- sapply(1:3, function(i) {
  most_common_species <- names(which.max(table(iris$Species[iris$Cluster == i])))
  return(most_common_species)
})
cluster_to_species

# Convert clusters to species labels
iris$PredictedSpecies <- factor(cluster_to_species[iris$Cluster], levels = species_levels)

# Confusion matrix to compare clusters with actual species
cm <- table(iris$Species, iris$PredictedSpecies)
print(cm)

# Visualizing clusters using clusplot from the cluster package
y_kmeans <- kmeans_3$cluster
clusplot(iris_data[, c("Sepal.Length", "Sepal.Width")],
         y_kmeans,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste("Cluster iris"),
         xlab = 'Sepal Length',
         ylab = 'Sepal Width')

# Detailed output of confusion matrix using caret
library(caret)
confusion_matrix_caret <- confusionMatrix(iris$PredictedSpecies, iris$Species)
print(confusion_matrix_caret)

# Interpretation:  Three cluster has been formed with one separate and two overlapped





######################### UJJWAL ##########################################
# 2080 board Qno 10 OR

library(ClusterR)
library(cluster)
data(iris)
table(iris$Species)
iris_1<-iris[,-5]
sum(is.na(iris_1))
set.seed(34)
# observing the data set

## a

kmeans.c2<-kmeans(iris_1,centers = 2,nstart = 20)
kmeans.c2
# k mean clustering with two clusters
# it forms two clusters of sizes 53, 97

kmeans.c3<-kmeans(iris_1,centers = 3,nstart = 20)
kmeans.c3
# k mean clustering with three clusters
# it forms two clusters of sizes 50, 62, 38


## b
plot(iris_1[c("Sepal.Length", 
              "Sepal.Width")],
     col = kmeans.c3$cluster,
     main = "K-means with 3 
clusters")

plot(iris_1$Sepal.Length,iris_1$Sepal.Width,col=kmeans.c3$cluster)

# the plot for three clusters is formed
# each cluster is colored differently ie. black, red and green
# in plot some of the green and red are seen mixed which means points are not well clustered
# for better visualization sepal length and sepal width are considered for plotting


## c

kmeans.c3$centers
kmeans.c3$centers[, 
                  c("Sepal.Length", "Sepal.Width")]
plot(iris_1[c("Sepal.Length", 
              "Sepal.Width")],
     col = kmeans.c3$cluster,
     main = "K-means with 3 
clusters")

points(kmeans.c3$centers[, 
                         c("Sepal.Length", "Sepal.Width")],col = 1:3, pch= 8, cex= 5)

# the center of clusters with respect to sepal length and sepal width is found 
# the center is plotted with plot () function
# the center gives mean of each cluster

## d
(iris$Species[50])
(kmeans.c3$cluster[50])
cm<-table(iris$Species,kmeans.c3$cluster)
cm

(accuracy<-
    sum(diag(cm))/sum(cm))

# three clusters were compared using confusion matrix
# the cm gives that 50 of setosa , 48 of versicolor and 36 of virginica were clustered correctly
# 14 of virginica and 2 of versicolr are predicted incorrectly
# using confusion matrix accuracy was found to be 89.33 %


##################### PRABHAT ### 2nd RE ################
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


