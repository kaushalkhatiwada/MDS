# Load necessary libraries
library(datasets)  # For the iris dataset
library(psych)     # For Varimax rotation

# Load the iris dataset
data(iris)

# Part a: Perform PCA on the first four variables of the iris dataset
iris_data <- iris[, 1:4]
pca_result <- prcomp(iris_data, scale. = TRUE)

# Display PCA results
summary(pca_result)

# Part b: Compute the eigenvalues and interpret the PCA results using Kaiser's criterion
eigenvalues <- pca_result$sdev^2
eigenvalues

# Kaiser's criterion: Keep components with eigenvalues > 1
kaiser_criterion <- eigenvalues > 1
kaiser_criterion

# Interpretation of PCA results using Kaiser's criterion
num_components_kaiser <- sum(kaiser_criterion)
num_components_kaiser

# Part c: Show the scree plot and decide on the number of components to retain
screeplot(pca_result, type = "lines", main = "Scree Plot")

# Interpretation of the scree plot
# Look for the "elbow" point in the plot

# Part d: Revise the flower scale with 3 components using Varimax rotation and interpret the result
pca_result_rotated <- principal(iris_data, nfactors = 3, rotate = "varimax")
print(pca_result_rotated)


