library(ggplot2)
library(factoextra)
data(iris)

data <- data.frame(Sepal.Length = iris$Sepal.Length, Sepal.Width = iris$Sepal.Width, Petal.Length = iris$Petal.Length, Petal.WIdth = iris$Petal.Width)

row_names <- row.names(data)

# Step 2: Standardize the data
data_standardized <- scale(data)

# Step 3: Assign row names back to the standardized data
rownames(data_standardized) <- row_names

# Perform PCA: generating composite score
pca_model <- prcomp(data_standardized, center = TRUE, scale. = TRUE)

# Calculate and plot cumulative variance explained by each PC
fviz_eig(pca_model, addlabels = TRUE) +
  ggtitle("Cumulative Variance Explained by Each PC")

# Check the summary to see how much variance each PC explains
summary(pca_model)

# Calculate total variance explained by each principal component
var_explained = pca_model$sdev^2 / sum(pca_model$sdev^2)


