# second assessment Q no 9 (PCA using kaiser's and using VARIMAX rotation)
-------------UU---------------------------------------------------------
# a
flower_scale<- iris[,-5]
head(flower_scale)
pr.out <- prcomp(flower_scale, scale = TRUE)

#b
pr.out

std_devs <- pr.out$sdev
std_devs
eigenvalues <- std_devs^2
eigenvalues
# SD of PC1...PC4 are 1.7083611 0.9560494 0.3830886 0.1439265
# eigenvalues of PC1...PC4 are are 2.91849782 0.91403047 0.14675688 0.02071484 which is square of SD
# according to kaisers rule we consider principal components with eigenvalues greater than 1 ie. PC1

# c
# Load necessary library
library(ggplot2)

# Create a data frame for plotting
plot(eigenvalues,type='o',xlab="Principal components")
abline(h=1,col="red")
abline(v=1,col="green")
# since the eigen value of PC1 is only grater than 1 as required by kaisers rule ...the PC1 is the component that describes the 
# which describes  maximum variance among all other components.

# d
library(FactoMineR)
pca.1 <- PCA(flower_scale, scale = TRUE, ncp = 3, graph = FALSE)
varimax_rot <- varimax(pca.1$ind$coord[,1:3])
varimax_rot
pr.out1 <- prcomp(varimax_rot$loadings, scale = TRUE)
pr.out1
std_devs1 <- pr.out1$sdev
std_devs1
eigenvalues1 <- std_devs1^2
eigenvalues1


# even after varimax rotation only one component has eigen value greater than 1 so we consider only one component
# as kaisers rule.
# thus varimax rotation does the bring any new conclusion even after re scaling.


# biplot of PCA model
biplot(pr.out)
pr.out

title("Bi plot of PCA")

# Each point on the biplot represents an observation (data point) in the new coordinate system preserving orgonal data
# with x axis as PC1 and y axis as PC2.

# The arrows (vectors) represent the original variables. 
# The direction and length of the arrows indicate how each variable contributes 
# to the principal components.

# A longer arrow means that the variable has a stronger contribution to the principal component.
# All the arrows has almost similar length so their contribution seems to be equal.

# The angle between the arrows and the axes indicates the correlation between 
# the variable and the principal component.A smaller angle means a higher correlation.
# Petal.Length and Petal.Width has higher angle with PC2 so it has low correlation but has higher coorelation with PC1.
# 


#######  2078 10 or
#--------------------
# Load the data
data <- USArrests
# Check the first few rows of the data
head(data)
names(data)
data<-as.matrix(data)
str(data)
dim(data)

# a
# Compute the distance matrix
state_dissimilarity <- dist(data)
state_dissimilarity

# b
mds_model <- cmdscale(state_dissimilarity, eig = TRUE, k = 2)
mds_model
# Fit the classical MDS model using city.dissimilarity object
# the original data  of the state for arrest are preserved in the new dimension 


# c
mds_coords <- mds_model$points
print(mds_coords)
summary(mds_coords)
# Summarizing the model
# these cordinate points preserve the original properties of the cities location

# d
plot(mds_coords, type = "n")
text(mds_coords, labels = row.names(data), cex = 0.7)
title("Classical MDS of USArrests")
# Bi-plot of the model
# the bi-plot shows the city map in two dimension where the oroginal distance disimilaty of cities is preserved.


# e

# PCA coordinates
pr.out <- prcomp(data, scale = TRUE)
pr.out
pca_coords <- pr.out$x[, 1:2]
pca_coords
# MDS coordinates
mds_coords <- mds_model$points

# Plot PCA vs MDS
par(mfrow = c(1, 2))
plot(pca_coords, main = "PCA", xlab = "PC1", ylab = "PC2", pch = 19, col = "blue")
text(pca_coords, labels = rownames(data), cex = 0.7, pos = 4)
plot(mds_coords, main = "MDS", xlab = "Dim 1", ylab = "Dim 2", pch = 19, col = "red")
text(mds_coords, labels = rownames(data), cex = 0.7, pos = 4)

# Correlation between PCA and MDS coordinates
cor(pca_coords, mds_coords)

# PCA1  has high degree of positive correlation with MDS1 and low degree of positive correlation with MDS2
# PCA2  has low degree of positive correlation with MDS1 and high degree of negative correlation with MDS2
# These findings imply that both PCA and MDS reveal similar structures in the data, with PC1 and MDS1 representing 
# a common dimension, and PC2 and MDS2 representing another common dimension but with reversed directionality.




#### Project 5 (PCA)
#-------------------
# Part I
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





###### PRESENTATION
#--------Utsab-------------
# PCA Principal Component Analysis
# Principal component analysis (PCA) is a dimensionality
# reduction technique used in machine learning to transform
# high-dimensional data into a lower-dimensional
# representation while preserving the most important
# information.

# Advantages of PCA
# 1. Dimensionality Reduction
# 2. Feature Selection
# 3. Data Visualization
# 4. Multicollinearity
# 5. Noise Reduction
# 6. Data Compression
# 7. Outlier Detection

# Steps:
# 1. Data Normalization
# 2. Covariance Matrix Calculation
# 3. Eigenvectors and Eigenvalues Computation
# 4. Selection of Principal Components
# 5. Data Transformation in New Dimensional Space

# Generate 100 random data with ten continuous independent
# variables, random seed = your roll number.
# Then fit PCA, PCA with Varimax rotation, MDS, MDS with Shannon's
# stress minimization with Bi-plots and interpret them
# carefully.
# Compare final PCA with final MDS model graphically.
# Finally, find the best unsupervised dimension reduction model for this data.

# Set seed for reproducibility
set.seed(35)

# Define the number of samples and variables
num_samples <- 100
num_variables <- 10

# Generate random data matrix
random_data <- matrix(runif(num_samples*num_variables),
                      ncol=num_variables)

# Set row names
rownames(random_data) <- paste0("Row", 1:100)

# Set column names
colnames(random_data) <- paste0("Column", 1:10)

# Display the first few rows of the random data
head(random_data)
str(random_data)
dim(random_data)
# Define min-max normalization function
min_max_normalize <- function(data) {
  normalized_data <- apply(data, 2, function(x) {
    (x - min(x)) / (max(x) - min(x))
  })
  return(normalized_data)
}

# Normalize the random data
normalized_data <- min_max_normalize(random_data)
normalized_data

# Compute the correlation matrix
library(ggcorrplot)
corr_matrix <- cor(normalized_data)
head(corr_matrix)
ggcorrplot(corr_matrix)
# The correlation matrix displays the pairwise correlations 
# between variables. Positive values indicate positive correlation, 
# negative values indicate negative correlation, and values closer 
# to 0 indicate weaker correlations.

# Perform Principal Component Analysis (PCA)
pca <- prcomp(random_data,
              scale = TRUE)
# The prcomp() function performs PCA on the raw data matrix
# directly. It automatically centers and scales the data before
# performing PCA. Each principal component explains a certain
# percentage of the total variance in the dataset.

# Display PCA results
pca
# Here, PC1 increases when Column2, Column5, Column6, Column8 and Column9 are
# increased and it is positively correlated whereas PC1 increases when Column1,
# Column3, Column4, Column7 and Column10 decreased because these values are
# negatively correlated.

# Extract the names of the principal components
names(pca)

# Summary of PCA analysis
summary(pca)
# The summary provides information about the variance explained 
# by each principal component, allowing you to assess the relative 
# importance of each component in capturing the variability of the data.

# Compute the proportion of variance explained by each principal component
pca.var <- pca$sdev^2
pca.var
propve <- pca.var / sum(pca.var)
propve

# Plot variance explained for each principal component
plot(propve,
     xlab = "Principal Component",
     ylab = "Proportion of Variance Explained",
     ylim = c(0, 1), type = "b",
     main = "Scree Plot")

# Plot the cumulative proportion of variance explained
plot(cumsum(propve),
     xlab = "Principal Component",
     ylab = "Cumulative Proportion of Variance Explained",
     ylim = c(0, 1), type = "b")

# Determine the number of principal components needed to explain 90% variance
which(cumsum(propve) >= 0.9)[1]

# Load the psych library for factor analysis
library(psych)

# Perform Factor Analysis with None rotation
pca_none <- principal(random_data,
                      nfactors=num_variables, 
                      rotate="none")

# Display Factor Analysis results
pca_none

# Perform Factor Analysis with Varimax rotation
pca_varimax <- principal(random_data,
                         nfactors=num_variables, 
                         rotate="varimax")
# Principal component analysis with Varimax rotation aims to
# maximize the variance of the squared loadings, making the
# interpretation of the components easier.

# Display Factor Analysis results
pca_varimax

# Perform Multidimensional Scaling (MDS)
MDS <- MASS::isoMDS(dist(random_data))
MDS
# Multidimensional scaling (MDS) is a technique used to
# visualize the pairwise dissimilarities or distances between
# objects in a dataset. It aims to find a low-dimensional
# representation of the data while preserving the original
# pairwise distances as much as possible.

# Compute the distance matrix
distance_matrix <- dist(random_data)

# Perform MDS with Shannon's stress minimization and 2 dimensions
mds_shannon <- MASS::isoMDS(distance_matrix,
                            k = 2,
                            maxit = 100)

# Display MDS results
mds_shannon

# Plot the eigenvalues of PCA
library(factoextra)
fviz_eig(pca,
         addlabels = TRUE)
# The plot shows the eigenvalues in a decreasing order,
# indicating the importance of each principal component.
# The first four components contain the most information,
# explaining almost 89% of the total variance.

# Load necessary libraries for visualization
library(ggplot2)
library(reshape2)

# Create data frames for PCA and MDS results
pca_df <- as.data.frame(pca$x[,1:2])
mds_df <- data.frame(x=MDS$points[,1],
                     y=MDS$points[,2])

# Graph of the variables
fviz_pca_var(pca,
             col.var = "black")

fviz_cos2(pca,
          choice = "var",
          axes = 1:4)
# The graph illustrates the contribution of each variable
# to the principal components. Variables with higher
# cos2 values contribute more to the corresponding principal
# components.

# Create PCA plot
pca_plot <- ggplot(pca_df,
                   aes(x=PC1,
                       y=PC2)) +
  geom_point() +
  labs(title="PCA")

# Create MDS plot
mds_plot <- ggplot(mds_df,
                   aes(x=x,
                       y=y)) +
  geom_point() +
  labs(title="MDS")

# Display both plots side by side
library(gridExtra)
grid.arrange(pca_plot,
             mds_plot,
             nrow=1)

# Print explained variance ratios of PCA
print("Explained Variance Ratios of PCA:")
print(summary(pca)$importance[2,])

# Print explained variance ratios of Factor Analysis
print("Explained Variance Ratios of Factor Analysis:")
print(pca_varimax$values)





# Load necessary packages
#--------Bimal-------------
library(factoextra)
library(ggplot2)

# Generate random data
set.seed(7)
n_samples <- 100
n_features <- 10
data <- data.frame(matrix(runif(n_samples * n_features), nrow = n_samples, ncol = n_features))
names(data) <- paste0("Var", 1:n_features)

# Standardize the data
data_standardized <- scale(data)

# Perform PCA: generating composite score
pca_model <- prcomp(data_standardized, center = TRUE, scale. = TRUE)

# Calculate and plot cumulative variance explained by each PC
fviz_eig(pca_model, addlabels = TRUE) +
  ggtitle("Cumulative Variance Explained by Each PC")

# Check the summary to see how much variance each PC explains
summary(pca_model)

# Calculate total variance explained by each principal component
var_explained = pca_model$sdev^2 / sum(pca_model$sdev^2)

# creating scree plot
qplot(c(1:10), var_explained) + 
  geom_line() +
  xlab("Principal Component") +
  ylab("Variance Explained") +
  ggtitle("Scree Plot") +
  ylim(0, 1)

# first seven variable have the cumulative proportion of 81%, so first seven variables would be sufficient to represent the data set

# Rotated PCA with variance maximization
fa.2 <-psych::principal(data_standardized, nfactors = 10, rotate = "varimax")
summary(fa.2)

# Bi-plots
biplot(fa.2, labels = rownames(data_standardized))

# Classical Multi-dimensional scaling (MDS) using Kruskall’s stress, Distance calculation

state.disimilarity <- dist(data_standardized)
mds.1 <- cmdscale(state.disimilarity)
summary(mds.1)

plot(mds.1, pch=19)
abline(h=0, lty=2)
text(mds.1, pos = 4, labels = rownames(data_standardized), col = 'steelblue')

mds.2 <- MASS::sammon(state.disimilarity, trace = FALSE)
summary(mds.2)

plot(mds.2$points, pch = 19)
abline(h=0, v=0, lty=2)

text(mds.2$points, pos = 4, labels = rownames(data_standardized), col = 'steelblue')

# Compare with PCA (first two PCs):

arrows(x0 = mds.2$points[,1], y0 = mds.2$points[,2],
       x1 = pca_model$x[,1], y1 = pca_model$x[,2],
       col = 'red', pch = 19, cex = 0.5)


