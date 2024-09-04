# Project 5
# Part I
install.packages("ISLR2")

# Question a
library(ISLR2)
# Here we have defined nci labels (NCI$labs) as nci.labs and nci data (NCI$data) and nci.data
nci.labs <- NCI60$labs
nci.data <- NCI60$data

# Question b
# The data object has 64 rows and 6830 columns.
dim(nci.data)

# Question c
# From the code below, we can see that the first four cancer types are CNS, CNS, CNS, and RENAL.
nci.labs[1:4]


# Question d
# This code conducts PCA on the given dataset after standardizing the variables, 
# and explores for underlying patterns and relationships within the 
# data through its principal components.
pr.out <- prcomp(nci.data, scale = TRUE)


# Question e
# The code visualizes the principal component scores obtained from a PCA analysis of the dataset. 
# The use of colors helps distinguish different classes or groups in the data.
# This aids in the interpretation of patterns or clusters in the principal component space.
Cols<- function(vec){
  cols<- rainbow(length(unique(vec)))
  return(cols[as.numeric(as.factor(vec))])
}
par(mfrow = c(1, 2))
plot(pr.out$x[, 1:2], col = Cols(nci.labs), pch = 19,
     xlab = "Z1", ylab = "Z2")
plot(pr.out$x[, c(1, 3)], col = Cols(nci.labs), pch = 19,
     xlab = "Z1", ylab = "Z3")



# Question f
# The summary of(pr.out) function in R provides a summary of the results obtained from the Principal Component Analysis (PCA). 
summary(pr.out)


# Question g
# These plots collectively provide insights into the structure of the data, the relationships between variables and observations, 
# and the overall effectiveness of the PCA in capturing the variability in the dataset.
plot(pr.out)


# Question h
# The code present in the segment below calculates and visualizes the proportion of variance explained 
# by each principal component and the cumulative proportion of variance explained. 
pve <- 100 * pr.out$sdev^2 / sum(pr.out$sdev^2)
par(mfrow = c(1, 2))
plot(pve, type = "o", ylab = "PVE",
     xlab = "Principal Component", col = "green")
plot(cumsum(pve), type = "o", ylab = "Cumulative PVE",
     xlab = "Principal Component", col = "yellow")
str(pve)

# Question i
# The R code below employs the FactoMineR package to perform Principal Component Analysis (PCA) 
# and subsequently applies the Varimax rotation method to the principal components.
library(FactoMineR)
pca.1 <- PCA(nci.data, scale = TRUE, ncp = 3, graph = FALSE)
varimax_rot <- varimax(pca.1$ind$coord[, 1:3])

# Question j
# Compare with the PCA result obtained above
plot(pr.out$x[, 1:3], col = c("red", "green", "blue")[factor(nci.labs)], pch = 19, xlab = "PC1", ylab = "PC2", main = "Original PCA")
plot(varimax_rot$loadings, col = c("red", "green", "blue")[factor(nci.labs)], pch = 19, xlab = "PC1", ylab = "PC2", main = "Varimax Rotated PCA")


