# Use NCI60 data of ISLR2 package and page 540 of ISLR2 book to do as follows in R Studio to knit PDF output:
library(ISLR2)

# a.	
# Define nci labels (NCI$labs) as nci.labs and nci data (NCI$data) and nic.data
nci.labs <- NCI60$labs
nci.data <- NCI60$data

# b.	
# Check dimension of nci.data object and interpret it carefully
dim(nci.data)   # 64 rows 6830 columns

# c.	
# Check first four cancer types using nci.labs object
head(nci.labs,4)

# d.	
# Fit principal component analysis (PCA) on nci.data with scale = TRUE argument as pr.out object
pr.out <- prcomp(nci.data,scale=T)

# e.	
# Create a plot showing first three PCA components with three different colors
plot(pr.out$x[, 1:3], col = c("red", "green", "blue")[factor(nci.labs)], pch = 19, xlab = "PC1", ylab = "PC2")

# f.
# Get summary of pr.out object and interpret it carefully
summary(pr.out)

# g.	
# Plot pro.out object and interpret it carefully
plot(pr.out)

# h.	
# Create custom scatterplots with principal components in x-axis and proportion variance explained (PVE) in y-axis for the first plot and cumulative PVE in the y-axis for the second plot and interpret them carefully
par(mfrow = c(1, 2))
var_expalined <- pr.out$sdev^2 / sum(pr.out$sdev^2)
plot(var_expalined, 
     xlab = "Principal Components", 
     ylab = "PVE",
     col="red")
plot(cumsum(var_expalined), 
     xlab = "Principal Components", 
     ylab = "Cumulative PVE",
     col="blue")


# i.	
# Perform PCA with varimax rotation and compare it with the PCA result obtained above
library(FactoMineR)
pca.1 <- PCA(nci.data, scale = TRUE, ncp = 3, graph = FALSE)
varimax_rot <- varimax(pca.1$ind$coord[, 1:3])

# Compare with the PCA result obtained above
plot(pr.out$x[, 1:3], col = c("red", "green", "blue")[factor(nci.labs)], pch = 19, xlab = "PC1", ylab = "PC2", main = "Original PCA")
plot(varimax_rot$loadings, col = c("red", "green", "blue")[factor(nci.labs)], pch = 19, xlab = "PC1", ylab = "PC2", main = "Varimax Rotated PCA")


# j.	
# Write summary of the results and conclusion based on your findings

