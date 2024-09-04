# Question no 6: Do the following in the R Studio using ggplot2 package with R script.




# Load necessary libraries
library(ggplot2)

# Set seed for reproducibility
set.seed(30)

# a. Create a dataset with the following variables: age (10-99 years), sex (male/female), educational Levels (No education/Primary/Secondary/Beyond Secondary), socio-economic status(Low, Middle, High) and body mass index(14-38), with random 200 cases of each variable. Your rollnumber must be used to set the random seed.

# Create the dataset
n <- 200
age <- sample(10:99, n, replace = TRUE)
sex <- sample(c("male", "female"), n, replace = TRUE)
education <- sample(c("No education", "Primary", "Secondary", "Beyond Secondary"), n, replace = TRUE)
socioeconomic_status <- sample(c("Low", "Middle", "High"), n, replace = TRUE)
bmi <- runif(n, min = 14, max = 38)

data <- data.frame(age, sex, education, socioeconomic_status, bmi)

# Display the first few rows of the dataset
head(data)


# b. Create scatter plot of age and body mass index variables using ggplot2 package and interpret the result carefully.

# Scatter plot of age and bmi
ggplot(data, aes(x = age, y = bmi)) +
  geom_point() +
  labs(title = "Scatter Plot of Age and BMI",
       x = "Age (years)",
       y = "Body Mass Index (BMI)") +
  theme_minimal()

# c. Create classes of body mass index variable as <18, 18-24, 25-30, 30+> and show it as pie chart using ggplot2 package and interpret it carefully.

# Create BMI classes
data$bmi_class <- cut(data$bmi, breaks = c(-Inf, 18, 24, 30, Inf), labels = c("<18", "18-24", "25-30", "30+"))

# Count the number of cases in each BMI class
bmi_class_counts <- as.data.frame(table(data$bmi_class))

# Create a pie chart
ggplot(bmi_class_counts, aes(x = "", y = Freq, fill = Var1)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Pie Chart of BMI Classes",
       fill = "BMI Class") +
  theme_void()


# d. Create histogram of age variable with bin size of 15 using the ggplot2 package and interpret it carefully.

# Histogram of age with bin size of 15
ggplot(data, aes(x = age)) +
  geom_histogram(binwidth = 15, fill = "blue", color = "black") +
  labs(title = "Histogram of Age",
       x = "Age (years)",
       y = "Frequency") +
  theme_minimal()


# Question no. 7 Do the following in R Studio using airquality data set of R with R script:

# Load necessary libraries

library(car)
library(ggplot2)

# Load the airquality dataset
data("airquality")

# a. Perform Shapiro-Wilk test for normality on Temp variable
shapiro_test <- shapiro.test(airquality$Temp)
print(shapiro_test)

# Visualize the distribution of Temp with a Q-Q plot
qqnorm(airquality$Temp)
qqline(airquality$Temp, col = "red")

# b. Perform Levene's Test to check for equal variances across months
levene_test <- leveneTest(Temp ~ factor(Month), data = airquality)
print(levene_test)

# c. Discussing the Independent Sample Test to Compare Temp by Month
# If variances are equal, use standard ANOVA; if not, use Welch's ANOVA

# d. Perform the best independent sample statistical test
# Set seed for reproducibility
set.seed(30)

# Check the result of Levene's test to decide the appropriate ANOVA test
if (levene_test$p.value < 0.05) {
  # Variances are not equal, use Welch's ANOVA
  anova_test <- oneway.test(Temp ~ factor(Month), data = airquality, var.equal = FALSE)
  test_type <- "Welch's ANOVA"
} else {
  # Variances are equal, use standard ANOVA
  anova_test <- aov(Temp ~ factor(Month), data = airquality)
  test_type <- "Standard ANOVA"
}

# Output the result of the ANOVA test
print(anova_test)
cat("Test performed:", test_type, "\n")

# Question no. 8 Do the following in R Studio using "Arrests" datasets of car package with R Script.

# a. Divide the Arrests data into train and test datasets with 80:20 random splits

# b. Fit a supervised logistic regression and naive bayes classification models on train data with "released" as dependent variable and colour, age, sex, employed and citizen as independent variable

# c. Predict the released variable in the test datasets of these models and interpret the result carefully

# d. Compare and decide the which classification model is better for this data

# Load necessary libraries
library(carData)
library(dplyr)
library(caret)
library(e1071)

# Load the Arrests dataset
data("Arrests")

# Set seed for reproducibility
set.seed(30)

# Split the data into training (80%) and testing (20%) sets
train_index <- createDataPartition(Arrests$released, p = 0.8, list = FALSE)
train_data <- Arrests[train_index, ]
test_data <- Arrests[-train_index, ]

# Fit a logistic regression model
logistic_model <- glm(released ~ colour + age + sex + employed + citizen, data = train_data, family = binomial)

# Fit a Naive Bayes model
nb_model <- naiveBayes(released ~ colour + age + sex + employed + citizen, data = train_data)

# Predict using the logistic regression model
test_pred_logistic <- predict(logistic_model, newdata = test_data, type = "response")
test_pred_logistic_class <- ifelse(test_pred_logistic > 0.5, "Yes", "No")

# Confusion matrix and accuracy for logistic regression
confusion_logistic <- table(test_data$released, test_pred_logistic_class)
accuracy_logistic <- sum(diag(confusion_logistic)) / sum(confusion_logistic)

# Predict using the Naive Bayes model
test_pred_nb <- predict(nb_model, newdata = test_data)

# Confusion matrix and accuracy for Naive Bayes
confusion_nb <- table(test_data$released, test_pred_nb)
accuracy_nb <- sum(diag(confusion_nb)) / sum(confusion_nb)

# Output the results
cat("Confusion Matrix for Logistic Regression:\n")
print(confusion_logistic)

cat("Confusion Matrix for Naive Bayes:\n")
print(confusion_nb)

cat("Accuracy of Logistic Regression:", accuracy_logistic, "\n")
cat("Accuracy of Naive Bayes:", accuracy_nb, "\n")

if (accuracy_logistic > accuracy_nb) {
  cat("Logistic Regression is the better model for this data.\n")
} else {
  cat("Naive Bayes is the better model for this data.\n")
}


# Question no. 9 Do as follows using given dataset of 10 US cities in R studio with R script:

# a. Get dissimilarity distance as city.dissimilarity object

# Step 1: Define the distance matrix
# Distance matrix for 10 US cities
city_distances <- matrix(c(
  0, 587, 1212, 701, 1936, 604, 748, 2139, 2182, 543,
  587, 0, 920, 940, 1745, 1188, 713, 1858, 1737, 597,
  1212, 920, 0, 879, 1949, 1726, 1631, 949, 1021, 1494,
  701, 940, 879, 0, 1374, 968, 1420, 1645, 1891, 1220,
  1936, 1745, 1949, 2394, 0, 2300, 1645, 347, 959, 2300,
  604, 1188, 1726, 968, 2339, 0, 1092, 2372, 2734, 923,
  748, 713, 1631, 1420, 1645, 1092, 0, 2571, 2408, 205,
  2139, 1858, 949, 2420, 347, 2594, 2571, 0, 678, 2442,
  2182, 1737, 1021, 1891, 959, 2734, 2408, 678, 0, 2329,
  543, 597, 1494, 1220, 2300, 923, 205, 2442, 2329, 0),
  nrow = 10, byrow = TRUE)

# City names
city_names <- c("Atlanta", "Chicago", "Denver", "Houston", "Los Angeles", "Miami", 
                "New York", "San Francisco", "Seattle", "Washington")

# Assign row and column names to the distance matrix
rownames(city_distances) <- city_names
colnames(city_distances) <- city_names

# Convert to a distance object
(city.dissimilarity <- as.dist(city_distances))

# b. Fit a classical multidimensional model using the city.dissimilarity object
city_mds <- cmdscale(city.dissimilarity, eig = TRUE, k = 2)

# c. Get the summary of the model and interpret it carefully
# Get the MDS coordinates
mds_coordinates <- city_mds$points

# Print the summary of the model
summary(city_mds)

# Interpretation: The summary includes the eigenvalues, which indicate the amount of variance captured by each dimension.
eigenvalues <- city_mds$eig
variance_explained <- eigenvalues / sum(eigenvalues) * 100
variance_explained

# d. Get the bi-plot of the model and interpret it carefully
# Plot the MDS result
plot(mds_coordinates, type = "n", xlab = "Coordinate 1", ylab = "Coordinate 2",
     main = "Classical MDS of US Cities")
text(mds_coordinates, labels = rownames(mds_coordinates), col = "blue")




# Question no 10. Use the first four variables of the iris data.

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
confusion_matrix_caret <- confusionMatrix(iris$PredictedSpecies, iris$Species)
print(confusion_matrix_caret)

# Interpretation: 
