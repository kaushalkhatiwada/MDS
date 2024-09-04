#Question number 8

# Load the required library
library(car)

# Load the "arrest" dataset from the car package
data(arrest)

# a) Divide the Arrests data into train and test datasets with 80:20 random split
set.seed(31)
train_index <- sample(1:nrow(arrest), 0.8 * nrow(arrest))
train_data <- arrest[train_index, ]
test_data <- arrest[-train_index, ]

# b) Fit logistic regression and naive Bayes classification models on train data
# Supervised Logistic Regression
logistic_model <- glm(released ~ colour + age + sex + employed + citizen, data = train_data,
                      family = binomial)

# Naive Bayes Classification
naive_bayes_model <- naiveBayes(released ~ colour + age + sex + employed + citizen, 
                                data = train_data)

# c) Predict the released variable in the test datasets
# Predict using Logistic Regression
logistic_pred <- predict(logistic_model, newdata = test_data, type = "response")
logistic_pred_class <- ifelse(logistic_pred > 0.5, 1, 0)

# Predict using Naive Bayes
naive_bayes_pred <- predict(naive_bayes_model, newdata = test_data, type = "class")

# d) Compare the performance of the classification models
# Calculate accuracy for Logistic Regression
logistic_accuracy <- mean(logistic_pred_class == test_data$released)

# Calculate accuracy for Naive Bayes
naive_bayes_accuracy <- mean(naive_bayes_pred == test_data$released)

# Compare the accuracies
model_comparison <- data.frame(Model = c("Logistic Regression", "Naive Bayes"),
                               Accuracy = c(logistic_accuracy, naive_bayes_accuracy))
model_comparison

