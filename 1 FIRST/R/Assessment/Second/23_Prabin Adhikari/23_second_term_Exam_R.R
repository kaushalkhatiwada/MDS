###################Part1

# Load the ISLR2 package
library(ISLR2)
library(psych)

# Load the NCI60 data
data("NCI60")

# Define nci labels and data
nci.labs <- NCI60$labs
nci.data <- NCI60$data

# Display the first few elements to verify
head(nci.labs)
dim(nci.data)

# Check dimensions of nci.data
dim(nci.data)

# Perform PCA on nci.data with scale = TRUE
pr.out <- prcomp(nci.data, scale. = TRUE)

# Extract the scores for the first three PCA components
scores <- pr.out$x[, 1:3]

# Convert nci.labs to factor
nci.labs_factor <- factor(nci.labs)

# Plot the first three PCA components
plot(scores[, 1], scores[, 2], col = as.numeric(nci.labs_factor), pch = 16,
     xlab = "PC1", ylab = "PC2", main = "PCA Plot with First Three Components")
points(scores[, 1], scores[, 3], col = as.numeric(nci.labs_factor), pch = 16)
points(scores[, 2], scores[, 3], col = as.numeric(nci.labs_factor), pch = 16)
legend("topright", legend = levels(nci.labs_factor), col = 1:length(levels(nci.labs_factor)), pch = 16, title = "Classes")


# Get summary of pr.out object
summary(pr.out)

# Scree plot
plot(pr.out)


# Extract proportion of variance explained (PVE)
pve <- pr.out$sdev^2 / sum(pr.out$sdev^2)

# Create custom scatterplot
plot(1:length(pve), pve, type = "b", xlab = "Principal Component", ylab = "Proportion Variance Explained (PVE)",
     main = "Scatterplot of PC vs. PVE")



# Calculate cumulative proportion of variance explained (Cumulative PVE)
cumulative_pve <- cumsum(pve)

# Create custom scatterplot
plot(1:length(cumulative_pve), cumulative_pve, type = "b", xlab = "Principal Component", ylab = "Cumulative Proportion Variance Explained",
     main = "Scatterplot of PC vs. Cumulative PVE")


# Perform PCA with varimax rotation
#pr.out_varimax <- principal(nci.data, nfactors = 5, rotate = "varimax", scores = TRUE)
#pca_rotated <- principal(nci.data, nfactors = ncol(pr.out$x), rotate = "varimax")

# Proportion of variance explained by each principal component in the original PCA
pve <- pr.out$sdev^2 / sum(pr.out$sdev^2)
pve
# Proportion of variance explained by each principal component in PCA with varimax rotation
#pve_varimax <- pr.out_varimax$values^2 / sum(pr.out_varimax$values^2)

# Print the comparison
#cbind(PCA = pve, PCA_with_Varimax = pve_varimax)

# Part II: Use the distance between 10 US cities provided below in R Studio to knit PDF output:
data("UScitiesD")

# Get dissimilarity distance as city.dissimilarity object.
city.dissimilarity <- as.dist(UScitiesD)
city.dissimilarity

# Fit a classical multidimensional model using the city.dissimilarity object.
mds <- cmdscale(city.dissimilarity,
                eig = TRUE,
                k = 2)
mds

# Get the summary of the model and interpret it carefully.
summary <- data.frame(
  coordinates = mds$points,
  eigenvalues = mds$eig,
  explained_variance = mds$eig / sum(abs(mds$eig))
)
summary

# Get the bi-plot of the model and interpret it carefully.
suppressWarnings(
  library(ggplot2)
)
mds_df <- as.data.frame(mds$points)
mds_df$City <- rownames(mds_df)
ggplot(mds_df,
       aes(x = V1,
           y = V2,
           label = City)) +
  geom_point() +
  geom_text(vjust = -0.5,
            hjust = 0.5) +
  labs(title = "MDS Biplot of US Cities",
       x = "Dimension 1",
       y = "Dimension 2") +
  theme_minimal()


# Part III:
# Part I: Use NCI60 data of ISLR2 package and page 543 of ISLR2 book to do as follows in R Studio to knit PDF output:
suppressWarnings(
  library(ISLR2)
)
data(NCI60)

# Scale the nci.data as sd.data object.
nci.data <- NCI60$data
sd.data <- scale(nci.data)

# Fit hierarchical cluster analysis on the sd.data using complete, average and single linkage methods, show the results with dendrogram and interpret them carefully.
suppressWarnings(
  library(stats)
)
# Perform hierarchical clustering using different linkage methods
hc_complete <- hclust(dist(sd.data),
                      method = "complete")
hc_average <- hclust(dist(sd.data),
                     method = "average")
hc_single <- hclust(dist(sd.data),
                    method = "single")
# Plot dendrograms for each linkage method
par(mfrow = c(1,
              3)) # Set up the plotting area to have 3 plots in one row
plot(hc_complete,
     main = "Complete Linkage Dendogram",
     xlab = "",
     sub = "",
     cex = 0.9)
plot(hc_average,
     main = "Average Linkage Dendogram",
     xlab = "",
     sub = "",
     cex = 0.9)
plot(hc_single,
     main = "Single Linkage Dendogram",
     xlab = "",
     sub = "",
     cex = 0.9)
# Reset plotting area
par(mfrow = c(1,
              1))

# Find the best number for clusters using “cutree” function with best distance value.



# Use your roll number as set.seed and perform k-means clustering on sd.data with the best number of clusters/distance value with nstart=20.
# set.seed(35)
# kmeans_result <- kmeans(sd.data,
#                         centers = optimal_clusters,
#                         nstart = 20)

# Get summary of the k-means clustering and interpret them carefully.


# Plot this k-means results using base r plot and cluster package and interpret them carefully.
# Visualize the k-means clustering result using base R plot
# Plot the first two principal components with cluster assignments
pr.out <- prcomp(sd.data)
plot(pr.out$x[, 1],
     pr.out$x[, 2],
     col = kmeans_result$cluster,
     pch = 16, 
     xlab = "PC1",
     ylab = "PC2",
     main = "K-means Clustering on NCI60 Data")
legend("topright",
       legend = unique(kmeans_result$cluster),
       col = unique(kmeans_result$cluster),
       pch = 16)
# Visualize the k-means clustering result using the cluster package
library(cluster)



###############PArt3
# Scale the nci.data matrix
sd.data <- scale(nci.data)

# Perform hierarchical clustering with complete linkage
hc_complete <- hclust(dist(sd.data), method = "complete")

# Perform hierarchical clustering with average linkage
hc_average <- hclust(dist(sd.data), method = "average")

# Perform hierarchical clustering with single linkage
hc_single <- hclust(dist(sd.data), method = "single")

# Plot dendrogram for hierarchical clustering with complete linkage
plot(hc_complete, main = "Dendrogram - Complete Linkage", xlab = "", sub = "")

# Plot dendrogram for hierarchical clustering with average linkage
plot(hc_average, main = "Dendrogram - Average Linkage", xlab = "", sub = "")

# Plot dendrogram for hierarchical clustering with single linkage
plot(hc_single, main = "Dendrogram - Single Linkage", xlab = "", sub = "")


# Calculate within-cluster sum of squares for different numbers of clusters
wss <- sapply(2:10, function(k) {
  kmeans(sd.data, centers = k)$tot.withinss
})

# Plot the within-cluster sum of squares against the number of clusters
plot(2:10, wss, type = "b", pch = 19, frame = FALSE, 
     xlab = "Number of Clusters",
     ylab = "Within-cluster Sum of Squares",
     main = "Elbow Method for Optimal Number of Clusters")

# Find the optimal number of clusters based on the elbow method
optimal_clusters <- which(diff(wss) == max(diff(wss))) + 1
cat("Optimal number of clusters:", optimal_clusters, "\n")


# Set seed using your roll number
set.seed(23)  # Replace 123456 with your actual roll number

# Perform k-means clustering with the optimal number of clusters and nstart=20
kmeans_result <- kmeans(sd.data, centers = optimal_clusters, nstart = 20)

# Print the cluster centers
print(kmeans_result$centers)

# Print the cluster membership for each observation
#print(kmeans_result$cluster)


# Print summary of k-means clustering
#print(kmeans_result)


# Plot the data points with cluster membership colored
plot(sd.data, col = kmeans_result$cluster, pch = 20, main = "K-Means Clustering", xlab = "Principal Component 1", ylab = "Principal Component 2")

# Add cluster centers to the plot
points(kmeans_result$centers, col = 1:optimal_clusters, pch = 8, cex = 2)

# Install and load the cluster package
#if (!requireNamespace("cluster", quietly = TRUE)) {
#install.packages("cluster")
#}
library(cluster)

# Convert the k-means result to a "clustering" object
#km_cluster <- cl_kmeans(sd.data, centers = kmeans_result$centers)

# Plot the clustering result
#clusplot(sd.data, km_cluster$cluster, color = TRUE, shade = TRUE,
#        labels = 2, lines = 0)













########################Part4




library(arules)
library(arulesViz)
library(datasets)

# Load Groceries data
data("Groceries")

# Check the structure of the Groceries data
str(Groceries)
summary(Groceries)


# Plot item frequency for the top 20 items
itemFrequencyPlot(Groceries, topN = 20, type = "absolute", main = "Top 20 Frequent Items")

# Set parameters for the apriori algorithm
params <- list(supp = 0.001, conf = 0.8)

# Generate association rules
rules <- apriori(Groceries, parameter = params)

# Inspect the first 10 rules
inspect(rules[1:10])

# Summary of the rules
summary(rules)

# Sort rules by confidence
sorted_rules <- sort(rules, by = "confidence", decreasing = TRUE)

# Inspect the top 5 rules and round results to 2 decimal places
top_five_rules <- sorted_rules[1:5]
inspect(head(top_five_rules, n = 5))

# To round the results, we can create a custom inspect function
inspect_rules_rounded <- function(rules, digits = 2) {
  rules_df <- as(rules, "data.frame")
  rules_df[, c("support", "confidence", "lift")] <- round(rules_df[, c("support", "confidence", "lift")], digits)
  return(rules_df)
}

# Inspect and print the top 5 rules with rounded values
inspect_rules_rounded(sorted_rules[1:5])

# Inspect and print the top 5 rules with rounded values
inspect_rules_rounded(top_five_rules)



# Filter rules with 'whole milk' in rhs
milk_rules <- subset(rules, rhs %in% "whole milk")

# Sort rules by confidence in decreasing order
sorted_milk_rules <- sort(milk_rules, by = "confidence", decreasing = TRUE)

# Inspect the top 5 rules and round results to 2 decimal places
inspect(sorted_milk_rules[1:5])

# Function to inspect rules with rounded values
inspect_rules_rounded <- function(rules, digits = 2) {
  rules_df <- as(rules, "data.frame")
  rules_df[, c("support", "confidence", "lift")] <- round(rules_df[, c("support", "confidence", "lift")], digits)
  return(rules_df)
}

# Inspect and print the top 5 rules with rounded values
inspect_rules_rounded(sorted_milk_rules[1:5])



# Filter rules with 'whole milk' in rhs
milk_rules <- subset(rules, rhs %in% "whole milk")

# Sort rules by confidence in decreasing order
sorted_milk_rules <- sort(milk_rules, by = "confidence", decreasing = TRUE)

# Inspect the top 5 rules
inspect(sorted_milk_rules[1:5])

# Function to inspect rules with rounded values
inspect_rules_rounded <- function(rules, digits = 2) {
  rules_df <- as(rules, "data.frame")
  rules_df[, c("support", "confidence", "lift")] <- round(rules_df[, c("support", "confidence", "lift")], digits)
  return(rules_df)
}

# Inspect and print the top 5 rules with rounded values
inspect_rules_rounded(sorted_milk_rules[1:5])





