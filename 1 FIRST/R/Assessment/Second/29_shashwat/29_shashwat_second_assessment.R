## Question 10
## loading the iris data
data(iris);

## import iris as a data frame
iris_df <- as.data.frame(iris);

## check the head of the data frame
head(iris_df);
str(iris_df);

## select only the first 4 variables
iris_data <- iris_df[, 1:4];
head(iris_data);
str(iris_data);

## set the seed 
set.seed(29);

## perform k means for k = 2
kmeans_2 <- ?kmeans(iris_data, centers = 2, nstart = 20);
print(kmeans_2);

## perform k means for k = 3
kmeans_3 <- kmeans(iris_data, centers = 3, nstart = 20);
print(kmeans_3)

## plot cluster formed with k = 3 in a single graph
clusters <- kmeans_3$cluster;
plot(clusters);


## Question 9
## creating a data frame using given data
distance.data <-  matrix(c(
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
), nrow = 10, byrow = TRUE);
print(distance.data);


## getting dissimilarity distance as city.dissimilarity object
city.dissimilarity <- as.dist(distance.data);
city.dissimilarity

## fit a classical multidimensional mdoel
multidimensional.model <- cmdscale(city.dissimilarity, eig = TRUE, k = 2)
multidimensional.model;

## summary of the model
summary(multidimensional.model);

## Biplot of the model 
mds_coords <- multidimensional.model$points
print(mds_coords)

# Bi-plot of the model
plot(mds_coords)
title("Multidimensional model of 10 US Cities")


## question 8

## loading the car package
library(car);

## get the arrests data
data("Arrests")
arrest_data <- Arrests
head(arrest_data);

## dividing the data into 80-20 random split
set.seed(29);
index <- sample(2, nrow(arrest_data), replace = T, prob = c(0.8, 0.2));
train.arrest = arrest_data[index == 1, ];
test.arrest = arrest_data[index == 2, ];
head(train.arrest);
head(test.arrest);

## Fitting a supervised logistic regression model
logistic_model <- glm(released ~ colour + age + sex + employed + citizen, 
             family = binomial, data = train.arrest);
summary(model);


## importing required packages
library(e1071);

## Fitting a naive bayes classifier 
naive_model <- naiveBayes(released ~ colour + age + sex + employed + citizen, data = train.arrest);
summary(naive_model);

## logistic model prediction
logistic_predictions_prob <- predict(logistic_model, test.arrest, type = "response")
logistic_predictions <- ifelse(logistic_predictions_prob > 0.5, 1, 0)

# Predict using Naive Bayes model
naive_predictions <- predict(naive_model, test.arrest, type = "class")

confusion_matrix_logistic <- table(Predicted = logistic_predictions, Actual = test.arrest$released)
print(confusion_matrix_logistic)

# Accuracy for logistic regression
accuracy_logistic <- mean(logistic_predictions == test.arrest$released)
 accuracy_logistic

# Confusion matrix for Naive Bayes
confusion_matrix_naive <- table(Predicted = naive_predictions, Actual = test.arrest$released)
print(confusion_matrix_naive)

# Accuracy for Naive Bayes
accuracy_naive <- mean(naive_predictions == test.arrest$released)
accuracy_naive

## qno 7
## loading air quality data
data("airquality");
aq <- airquality;
head(aq);

## checking if temp variable follows normal distribution
## the p value for this was found to be 0.009319 which is les than 0.05 hence it does not follow a normal distribution
shapiro.test(aq$Temp);

## 
install.packages("htmltools");
library(htmltools);

