#Question no 6
##part (a)
# Load necessary libraries
library(ggplot2)
library(dplyr)

# Set random seed
set.seed(19)

# Create dataset
n <- 200

age <- sample(10:99, n, replace = TRUE)
sex <- sample(c("male", "female"), n, replace = TRUE)
education <- sample(c("no education", "primary", "secondary", "beyond secondary"), n, replace = TRUE)
socioeconomic_status <- sample(c("low", "middle", "high"), n, replace = TRUE)
bmi <- runif(n, 14, 38)

data <- data.frame(age, sex, education, socioeconomic_status, bmi)
#extracting first 10 rows using head function 
head(data)

#part (b)
# Scatter plot of age and BMI
scatter_plot <- ggplot(data, aes(x = age, y = bmi)) +
  geom_point() +
  labs(title = "Scatter Plot of Age and Body Mass Index",
       x = "Age",
       y = "Body Mass Index (BMI)") +
  theme_minimal()
scatter_plot
#The scatter plot suggests that age alone may not be a strong predictor of BMI in this dataset.


#part (c)
# Create BMI classes
data$bmi_class <- cut(data$bmi, breaks = c(-Inf, 18, 24, 30, Inf), labels = c("<18", "18-24", "25-30", "30+"))

# Count the number of cases in each BMI class
bmi_class_counts <- data %>%
  group_by(bmi_class) %>%
  summarize(count = n())

# Create pie chart
pie_chart <- ggplot(bmi_class_counts, aes(x = "", y = count, fill = bmi_class)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  labs(title = "Distribution of Body Mass Index Classes",
       fill = "BMI Class") +
  theme_minimal()

pie_chart
#the pie chart shows that the data is well distributed among 

#part(d)
# Histogram of age with bin size 15
histogram <- ggplot(data, aes(x = age)) +
  geom_histogram(binwidth = 15, fill = "blue", color = "black") +
  labs(title = "Histogram of Age",
       x = "Age",
       y = "Frequency") +
  theme_minimal()
histogram
#With a bin size of 15, there are approximately 6 bins covering the age range from 10 to 99 years.
#The histogram appears to be roughly symmetric, suggesting a relatively even distribution of 
#ages in the dataset.

##Question 7
##part-a
aq<-airquality
# Perform the Shapiro-Wilk test
shapiro.test(aq$Temp)
# If the p-value is less than the significance level (usually 0.05), we reject the null hypothesis
# and conclude that the data does not follow a normal distribution.

##part-b
# Load the necessary library
library(stats)

# Perform the Bartlett test
bartlett.test(aq$Temp ~ aq$Month)

# The p-value is less than the significance level (usually 0.05), we reject the null hypothesis
# and conclude that the variances are not equal.


##part-c
#Since the variances of temp are not equal by month, we can use the Welch's 
#t-test, which is a variation of the t-test that does not assume equal variances. 
#This test is used to compare the means of two or more groups

#pard-d
#since the variance is not equal so used kruskal test
kruskal_test <- kruskal.test(Temp ~ factor(Month), data = airquality)
kruskal_test


##Question 8
#part - a
#loadning necessary packages
library(car)
data<-Arrests
str(data)

# Split the data into training and test sets
set.seed(19)
ind<-sample(2, nrow(data), replace = T, prob = c(0.8, 0.2))
training <- data[ind==1,]
testing <- data[ind==2,]


# Define the dependent and independent variables
dependent_variable <- "released"
independent_variables <- c("color", "age", "sex", "employed", "citizen")

# Fit the logistic regression model
logistic_model <- glm(data$released ~ ., data = training, family = binomial)

# Fit the naive Bayes classification model
naive_bayes_model <- naiveBayes(released ~ color + age + sex + employed + citizen, data = train_data)

# Print the summary of the models
summary(logistic_model)
summary(naive_bayes_model)

#Qesstion 9(OR)
ibrary(stats)

# Question a
# Create a distance matrix from the given data in the problem
city_distances <- matrix(c(
  0, 587, 1212, 701, 1936, 604, 748, 2139, 2182, 543,
  587, 0, 920, 940, 1745, 1188, 713, 1858, 1737, 597,
  1212, 920, 0, 879, 831, 1726, 1611, 1949, 2204, 1494,
  701, 940, 879, 0, 1374, 968, 1420, 1645, 1891, 1220,
  1936, 1745, 831, 1374, 0, 2339, 2451, 347, 2734, 2300,
  604, 1188, 1726, 968, 2339, 0, 1092, 2594, 2408, 923,
  748, 713, 1611, 1420, 2451, 1092, 0, 2571, 678, 205,
  2139, 1858, 1949, 1645, 347, 2594, 2571, 0, 678, 2442,
  2182, 1737, 2204, 1891, 2734, 2408, 678, 678, 0, 2329,
  543, 597, 1494, 1220, 2300, 923, 205, 2442, 2329, 0
), nrow = 10, byrow = TRUE)
# Assigning names to row and columns
city_names <- c("Atlanta", "Chicago", "Denver", "Houston", "Los Angeles", "Miami",
                "New York", "San Francisco", "Seattle", "Washington D.C.")
rownames(city_distances) <- city_names
colnames(city_distances) <- city_names

# Convert to a dissimilarity object
city_dissimilarity <- as.dist(city_distances)

# Question b
# Fit the classical MDS model using city.dissimilarity object
mds_model <- cmdscale(city_dissimilarity, eig = TRUE, k = 2)

# Question c
# Summarizing the model
mds_coords <- mds_model$points
print(mds_coords)


# Question d
# Bi-plot of the model
plot(mds_coords, type = "n")
text(mds_coords, labels = city_names, cex = 0.7)
title("Classical MDS of US Cities")


#Qestion 10
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
