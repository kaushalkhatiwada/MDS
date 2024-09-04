

## 2nd assessment 2081 Qno 10.
################### NISHAN REGMI ######### 
# Load necessary libraries
library(datasets)
library(ggplot2)
library(cluster)
library(dendextend)

# Load the iris dataset
data("iris")
iris_data <- iris[, 1:4]

# Compute the distance matrix
dist_matrix <- dist(iris_data)

# Hierarchical clustering using single linkage
hc_single <- hclust(dist_matrix, method = "single")
plot(hc_single, main = "Hierarchical Clustering with Single Linkage", xlab = "", sub = "", cex = 0.9)

# Hierarchical clustering using complete linkage
hc_complete <- hclust(dist_matrix, method = "complete")
plot(hc_complete, main = "Hierarchical Clustering with Complete Linkage", xlab = "", sub = "", cex = 0.9)

# Hierarchical clustering using average linkage
hc_average <- hclust(dist_matrix, method = "average")
plot(hc_average, main = "Hierarchical Clustering with Average Linkage", xlab = "", sub = "", cex = 0.9)

# Calculate cophenetic correlation coefficients
coph_single <- cor(dist_matrix, cophenetic(hc_single))
coph_complete <- cor(dist_matrix, cophenetic(hc_complete))
coph_average <- cor(dist_matrix, cophenetic(hc_average))

# Print cophenetic correlation coefficients
cat("Cophenetic Correlation Coefficient for Single Linkage:", coph_single, "\n")
cat("Cophenetic Correlation Coefficient for Complete Linkage:", coph_complete, "\n")
cat("Cophenetic Correlation Coefficient for Average Linkage:", coph_average, "\n")

# Determine the best model
best_model <- which.max(c(coph_single, coph_complete, coph_average))
if (best_model == 1) {
  cat("Best model: Single Linkage\n")
  best_hc <- hc_single
} else if (best_model == 2) {
  cat("Best model: Complete Linkage\n")
  best_hc <- hc_complete
} else {
  cat("Best model: Average Linkage\n")
  best_hc <- hc_average
}

# Plot the best dendrogram
plot(best_hc, main = "Best Hierarchical Clustering Dendrogram", xlab = "", sub = "", cex = 0.9)

# Determine the number of clusters
rect.hclust(best_hc, k = 3, border = "red")
clusters <- cutree(best_hc, k = 3)
table(clusters)



########################################################

# question number 10 (Hierarchical clustering)
#-------UU-----------

head(iris)
ir_label <- iris$Species
ir_data <- iris[,-5]
head(ir_data)

#a
# sd.data <- scale(ir_data)
data.dist <- dist(ir_data)
plot(hclust(data.dist,method = "single"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Single Linkage")

#b
plot(hclust(data.dist,method = "complete"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Complete Linkage")

#c
plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

#d
# Best hierarchical model

plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

abline(h = 1.85, col = "red")


hc.out1 <- hclust(dist(ir_data),method = "single")
hc.out2 <- hclust(dist(ir_data),method = "complete")
hc.out3 <- hclust(dist(ir_data),method = "average")

hc.clusters1 <- cutree(hc.out1,3)
hc.clusters2 <- cutree(hc.out2,3)
hc.clusters3 <- cutree(hc.out3,3)


table(hc.clusters1, ir_label)
# virginica is incorrectly clustered as versicolor

table(hc.clusters2, ir_label)
# virginica is incorrectly clustered as versicolor

table(hc.clusters3, ir_label)
# only few of the virginica is incorrectly clustered as versicolor which is better than other methods.

plot(hc.out3, labels = ir_label,main = "Average Linkage (Best HCA model)")
abline(h = 1.85, col = "green")

# since the number of correctly represented data in dendrogram is formes in average method we prefer average method.



### PROJECT 5
#-------------
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





