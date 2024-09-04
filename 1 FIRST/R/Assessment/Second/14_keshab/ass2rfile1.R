Qno6

library(ggplot2)

# Setting the seed
set.seed(14)

# Enter random data
age <- sample(10:99, 200, replace = TRUE)
sex <- sample(c("male", "female"), 200, replace = TRUE)
education_level <- sample(c("No education", "Primary", "Secondary", "Beyond secondary"), 200, replace = TRUE)
socioeconomic_status <- sample(c("Low", "Middle", "High"), 200, replace = TRUE)
body_mass_index <- runif(200, min = 14, max = 38)

# Creating a data frame
data <- data.frame(age, sex, education_level, socioeconomic_status, body_mass_index)

# a. Scatter plot of age and body mass index
scatter_plot <- ggplot(data, aes(x = age, y = body_mass_index)) +
  geom_point() +
  labs(x = "Age", y = "Body Mass Index") +
  ggtitle("Scatter Plot of Age and Body Mass Index")

# b. Creating classes of body mass index variable
data$body_mass_index_class <- cut(data$body_mass_index, breaks = c(0, 18, 24, 30, Inf), labels = c("<18", "18-24", "25-30", "30+"))

# Pie chart of body mass index classes
pie_chart <- ggplot(data, aes(x = "", fill = body_mass_index_class)) +
  geom_bar(width = 1) +
  coord_polar("y") +
  labs(fill = "Body Mass Index Class") +
  ggtitle("Pie Chart of Body Mass Index Classes")

# c. Histogram of age variable
histogram <- ggplot(data, aes(x = age)) +
  geom_histogram(binwidth = 15, fill = "skyblue", color = "black") +
  labs(x = "Age", y = "Frequency") +
  ggtitle("Histogram of Age (Bin Size = 15)")


pdf("output_plots.pdf")
print(scatter_plot)
print(pie_chart)
print(histogram)




#solution of  qu no 9 

library(ggplot2)
library(cluster)


data(iris)

# Selecting first four variables
iris_data <- iris[, 1:4]

# Fit k-means clustering model with k=2 and k=3
k2_model <- kmeans(iris_data, centers = 2)
k3_model <- kmeans(iris_data, centers = 3)

# Plot clusters formed with k=3
ggplot(iris, aes(Petal.Length, Petal.Width, color = factor(k3_model$cluster))) +
  geom_point() +
  labs(color = "Cluster") +
  ggtitle("Clusters Formed with k=3")

# Add cluster centers for the plot of cluster formed with k=3
ggplot(iris, aes(Petal.Length, Petal.Width, color = factor(k3_model$cluster))) +
  geom_point() +
  geom_point(data = as.data.frame(k3_model$centers), aes(x = Petal.Length, y = Petal.Width), color = "black", size = 3, shape = 17) +
  labs(color = "Cluster") +
  ggtitle("Clusters Formed with k=3 with Cluster Centers")

# Compare k=3 clusters with Species variable using confusion matrix
table(iris$Species, k3_model$cluster)

#solution of q8
library(psych)

# Load iris dataset
data(iris)

# Selecting first four variables
iris_data <- iris[, 1:4]

#  (PCA)
pca_result <- principal(iris_data, nfactors = 4, rotate = "none")

#  eigenvalues
eigenvalues <- pca_result$values

#  PCA result using Kaiser's Criteria
# Retain components with eigenvalues > 1
significant_components <- sum(eigenvalues > 1)

# Show the scree plot
scree_plot <- scree(pca_result)

# Decide on the number of components to retain
# Retain components with eigenvalues > 1
num_components_retained <- sum(eigenvalues > 1)

# Revise the flower scale with 3 components using VARIMAX rotation
pca_result_varimax <- principal(iris_data, nfactors = 3, rotate = "varimax")

# Interpret the revised flower scale with VARIMAX rotation
flower_scale_varimax <- pca_result_varimax$scores

# Output results
print(paste("Eigenvalues:", eigenvalues))
print(paste("Number of significant components according to Kaiser's Criteria:", significant_components))
print(scree_plot)
print(paste("Number of components to retain:", num_components_retained))
print("Revised flower scale with VARIMAX rotation:")
print(head(flower_scale_varimax))



  
  
  
  