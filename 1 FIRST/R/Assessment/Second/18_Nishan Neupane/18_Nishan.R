#QNo.8

# Load required libraries
library(stats)
library(ggplot2)
library(ggfortify)

# a)
city_names <- c("Atlanta", "Chicago", "Denver", "Houston", "Los Angeles", "Miami", 
                "New York", "San Francisco", "Seattle", "Washington D.C")

city.dissimilarity <- matrix(c(
  0, 587, 1212, 701, 1936, 604, 748, 2139, 2182, 543,
  587, 0, 920, 940, 1745, 1188, 713, 1858, 1737, 597,
  1212, 920, 0, 879, 831, 1726, 1631, 949, 1021, 1494,
  701, 940, 879, 0, 1374, 968, 1420, 1645, 1891, 1220,
  1936, 1745, 831, 1374, 0, 2339, 2451, 347, 959, 2300,
  604, 1188, 1726, 968, 2339, 0, 1092, 2594, 2734, 923,
  748, 713, 1631, 1420, 2451, 1092, 0, 2571, 2408, 205,
  2139, 1858, 949, 1645, 347, 2594, 2571, 0, 678, 2442,
  2182, 1737, 1021, 1891, 959, 2734, 2408, 678, 0, 2329,
  543, 597, 1494, 1220, 2300, 923, 205, 2442, 2329, 0
), nrow = 10, byrow = TRUE)

rownames(distance_matrix) <- city_names
colnames(distance_matrix) <- city_names

city_dissimilarity <- as.dist(distance_matrix)

# b) Fit a classical MDS model
mds_fit <- cmdscale(city.dissimilarity, eig = TRUE, k = 2)
mds_fit



# Summary of the model
mds_coords <- mds_fit$points
print(mds_coords)
# d) Create the bi-plot of the MDS model
# Bi-plot of the model
plot(mds_fit, type = "n")
text(mds_fit, labels = city_names, cex = 0.7)
title("Classical MDS of US Cities")

#Bi-plot of the model
plot(mds_coords, type = "n")
text(mds_coords, labels = city_names, cex = 0.7)






# Question No 6

library(ggplot2)
set.seed(18)

# a
age <- sample(10:99, 200, replace = TRUE)
sex <- sample(c("Male", "Female"), 200, replace = TRUE)
education <- sample(c("No education", "Primary", "Secondary", "Beyond secondary"), 200, replace = TRUE)
socioeconomic_status <- sample(c("Low", "Middle", "High"), 200, replace = TRUE)
bmi <- sample(14:38, 200, replace = TRUE)
#data is injected as per the question

# b

ggplot(data = data.frame(age, bmi), aes(x = age, y = bmi)) +
  geom_point() +
  labs(x = "Age", y = "BMI", title = "Relationship between Age and BMI")

# No trend is seen fro the data that means the data is spred all over the graph

# c
bmi_class <- cut(bmi, breaks = c(0, 18, 24, 30, Inf), labels = c("<18", "18-24", "25-30", "30+"))

#For pie chart
ggplot(data.frame(bmi_class), aes(x = "", fill = bmi_class)) +
  geom_bar(width = 1) +
  coord_polar("y", start = 0) +
  labs(title = "Distribution of BMI Classes") +
  theme_void() +
  theme(legend.position = "right")
#from the pie chart we can see the maximum part of the data is covered by group 25-30 and 30+ 
#and minimum part of the data is from <18 

# d

ggplot(data.frame(age), aes(x = age)) +
  geom_histogram(binwidth = 15, fill = "steelblue", color = "white") +
  labs(x = "Age", y = "Count", title = "Distribution of Age") +
  theme_classic()
#From above plot we can see thet all the data has simmilar frequency except highest one


# Question No 7
# Airquality dataset


data <- airquality

# a
# to perform goodness of fit test we have to do following
# check scatterplot
plot(data$Temp)

# qqplot(data$Temp)
qqnorm(data$Temp)
qqline(data$Temp)


ks.test(airquality$Temp, "pnorm")

# even though visually data suggests that it follows normal distribution but
# using ks.test we conclude that data doesnot follows it.
# used ks.test because sample size > 100

# b

library(carData)

library(car)
leveneTest(Temp ~ as.factor(Month), data = airquality)

# since p value is less than 0.05 we have to use another test


#8
library(car)
library(e1071)
# a
data <- Arrests
ind <- sample(2, nrow(data), 
              replace = T, prob = c(0.8, 0.2))
train <- data[ind==1,]
test <- data[ind==2,]
#data is divided in 80-20 portion

# b

# For the logistic regression model
logistic_model <- glm(released ~ ., data = train, family = "binomial")

# For the Naive Bayes model
nb_model <- naiveBayes(released ~ ., data = train)

# c
# to get  predictions.
logistic_pred <- predict(logistic_model, newdata = test, type = "response")
nb_pred <- predict(nb_model, newdata = test)


logistic_pred_class <- ifelse(logistic_pred > 0.5, 1, 0)
logistic_conf_matrix <- table(Predicted = logistic_pred_class, Actual = test$released)
logistic_conf_matrix
logistic_accuracy <- sum(diag(logistic_conf_matrix)) / sum(logistic_conf_matrix)
print(paste("Logistic Regression Accuracy:", logistic_accuracy))

# True Negatives (TN): 9
# in this case actual result is no and our model predect no
# False Negatives (FN): 3
# in this case actual result is yes and our model predect no
# False Positives (FP): 176
# in this case actual result is yes and our model predect no.
# True Positives (TP): 837
# in this case actual result is yes and our model predect yes
#it has 83% accuracy

nb_conf_matrix <- table(Predicted = nb_pred, Actual = test$release)
nb_conf_matrix
nb_accuracy <- sum(diag(nb_conf_matrix)) / sum(nb_conf_matrix)
print(paste("Naive Bayes Accuracy:", nb_accuracy))

# True Negatives (TN): 27
# in this case actual result is no and our model predect no
# False Negatives (FN): 32
# in this case actual result is yes and our model predect no
# False Positives (FP): 158
# in this case actual result is yes and our model predect no.
# True Positives (TP): 808
# in this case actual result is yes and our model predect yes
# accuracy of the naive bayes is 81%
# d
# from their accuracy we can say that logistic regression is best because it gives 83% accuracy



