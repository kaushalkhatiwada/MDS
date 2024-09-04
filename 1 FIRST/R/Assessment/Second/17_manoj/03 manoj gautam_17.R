# Install necessary packages if not already installed
install.packages("car")
install.packages("caTools")
install.packages("e1071")

# Load necessary libraries
library(car)
library(caTools)
library(e1071)

# Load the Arrest dataset
data(Arrest, package = "car")

# Set seed for reproducibility
set.seed(17)

# Split the data into training (80%) and testing (20%) sets
split <- sample.split(Arrest$released, SplitRatio = 0.8)
train_data <- subset(Arrest, split == TRUE)
test_data <- subset(Arrest, split == FALSE)

# Fit logistic regression model
log_model <- glm(released ~ color + sex + age + employed + citizen, data = train_data, family = binomial)

# Fit Naive Bayes model
nb_model <- naiveBayes(released ~ color + sex + age + employed + citizen, data = train_data)

# Predict using logistic regression model
log_pred <- predict(log_model, newdata = test_data, type = "response")
log_pred_class <- ifelse(log_pred > 0.5, 1, 0)

# Predict using Naive Bayes model
nb_pred <- predict(nb_model, newdata = test_data)

# Confusion matrix for logistic regression
log_cm <- table(test_data$released, log_pred_class)
log_accuracy <- sum(diag(log_cm)) / sum(log_cm)
print(paste("Logistic Regression Accuracy: ", log_accuracy))

# Confusion matrix for Naive Bayes
nb_cm <- table(test_data$released, nb_pred)
nb_accuracy <- sum(diag(nb_cm)) / sum(nb_cm)
print(paste("Naive Bayes Accuracy: ", nb_accuracy))

# Compare and decide which model is better
if(log_accuracy > nb_accuracy) {
  print("Logistic Regression model is better.")
} else {
  print("Naive Bayes model is better.")
}
