#Part I
#Question a

# Assigning airquality dataframe to a new variable
aq <- airquality
str(aq)

# Calculate mean of the wind by month using apply function
mean_wind <- tapply(aq$Wind, aq$Month, mean, na.rm = T)



# Calculate the standard deviation of wind by month using tapply function
sd_wind <- tapply(aq$Wind, aq$Month, sd, na.rm = T)

# Creating a data frame to show the output
mean_sd_table <- data.frame(
  Mean_wind = mean_wind,
  SD_wind = sd_wind
)


# Display the table
print(mean_sd_table)

# Question b
# Test of normality
# Perform Shapiro-Wilk test for each month
result <- tapply(aq$Wind, aq$Month, shapiro.test)

# Print the results
print(result)

# Question c
# Convert Month to a factor
airquality$Month <- factor(airquality$Month)

# Perform Bartlett's test for homogeneity of variances
bartlett_result <- bartlett.test(Wind ~ Month, data = airquality)

# Print Bartlett's test result
print(bartlett_result)

# Question d
#In the above scenario, Bartlett's test indicates that the variances of the "Wind" variable are approximately equal across different months. 
#Therefore, we can use the standard one-way ANOVA.



# Question e
#Fit one way anova model
# Convert Month to a factor
airquality$Month <- factor(airquality$Month)

anova_model <- aov(Wind ~ Month, data = airquality)
summary(anova_model)

#Question f

# Perform Tukey's HSD test
tukey_result <- TukeyHSD(anova_model)

# Print the Tukey HSD test result
print(tukey_result)


# Part II
# Question a
# Load the USArrests dataset
data("USArrests")

# Create a new dataset "crime" containing all variables from USArrests
crime <- USArrests

# Print the structure of the new dataset
str(crime)

# Print the first few rows of the new dataset
head(crime)


# Question b
# Create correlation matrix plot of the crime data and interpret each scatterplot carefully
cor(crime)

#visualize correlation matrix
library(corrplot)
corrplot(cor(crime),method = "number")

# Question c
# Split the dataset into training and testing dataset
set.seed(16)
index <- sample(2, nrow(crime), replace = T, prob = c(0.7, 0.3))
train.crime = crime[index == 1, ] # Training dataset
test.crime = crime[index == 2, ] # Testing dataset

# Question d
# Fitting a multiple linear regression model; keeping murder as dependent variable and all
# others as independent variables
mlr <- lm(Murder ~ ., data=train.crime)
summary(mlr)

# Calculation of RMSE
predicted <- predict(mlr, test.crime)

# Extract the actual values from the test data
actual <- test.crime$Murder

# Calculate the residuals
residuals <- actual - predicted

# Calculate the mean squared error
mse <- mean(residuals^2)

# Calculate the RMSE
(rmse <- sqrt(mse))


anova_result <- anova(mlr)

# Print the ANOVA table
print(anova_result)



# Question e
library(car)
vif(mlr)


# Question f
# Obtain residuals
residuals <- residuals(mlr)


# Linear (L)
# Suggestive graphical analysis
# Plotting residuals vs. fitted values
plot(fitted(mlr), residuals,
     xlab = "Fitted values",
     ylab = "Residuals",
     main = "Residuals vs. Fitted Values")

# Adding a horizontal line at y = 0 for reference
abline(h = 0, col = "red")
#The above graph suggests that the linear model provides a good fit for the given data as the graph shows
# no clear pattern and the data points are scattered throughout.


# Normal Test (N)
shapiro.test(residuals)
#The p value is not significant. Therefore, we accept null hypothesis meaning it follows normal distribution.

# Equal Variance/ Homoscedasticity (E) Test

# Breusch-Pagan test for homoscedasticity
library(lmtest)
bptest(mlr)

#The p value is not significant. This implies that we fail to reject null hypothesis meaning the variance is equal across all levels of predictor variables.

# Question g

# Predict Murder rates using the fitted model
predicted_murder <- predict(mlr, newdata = test.crime)

# Print the predicted Murder rates
print(predicted_murder)


# Question h

# Predict Murder rates using the fitted model
predicted_murder <- predict(mlr, test.crime)

actual_murder <- test.crime$Murder

# Calculate R-squared
r_squared <- cor(predicted_murder, actual_murder)^2

# Calculate residuals
residuals <- actual_murder - predicted_murder

# Calculate RMSE
rmse <- sqrt(mean(residuals^2))

# Print R-squared and RMSE
print(r_squared)
print(rmse)

# Question i
# Leave One Out CV
library(caret)

# Define training control
train.control <- trainControl(method = "LOOCV")

# Train the model
model1 <- train(Murder ~ ., data = USArrests, method =
                  "lm", trControl = train.control)

# Summarize the results
print(model1)


# Prediction
library(magrittr)
predictions1 <- model1 %>%
  predict(test.crime)
data.frame(R2 = R2(predictions1,
                   test.crime$Murder),
           
           RMSE = RMSE(predictions1,
                       
                       test.crime$Murder),
           
           MAE = MAE(predictions1,
                     
                     test.crime$Murder))

#K Fold Cross Validation


# Define training control
library(caret)
set.seed(16)
train.control <- trainControl(method = "cv", number = 10)

# Train the model
model2 <- train(Murder ~ . , data = crime, method =
                  "lm", trControl = train.control)

# Summarize the results
print(model2)

# Prediction
predictions2 <- model2 %>%
  predict(test.crime)
data.frame(R2 = R2(predictions2,
                   test.crime$Murder),
           
           RMSE = RMSE(predictions2,
                       
                       test.crime$Murder),
           
           MAE = MAE(predictions2,
                     
                     test.crime$Murder))



#repeated k-fold cross validation
library(caret)
# Define training control
set.seed(16)
train.control <- trainControl(method = "repeatedcv",
                              
                              number = 10, repeats = 3)

# Train the model
model3 <- train(Murder ~., data = crime, method =
                  "lm",
                
                trControl = train.control)

# Summarize the results
print(model3)

# Prediction
predictions3 <- model3 %>% predict(test.crime)
data.frame(R2 = R2(predictions3, test.crime$Murder),
           RMSE = RMSE(predictions3, test.crime$Murder),
           MAE = MAE(predictions3,
                     test.crime$Murder))
# Question k
# KNN
library(class)
knn_model <- knn(train.crime[, -1],
                 test.crime[, -1],
                 train.crime$Murder,
                 k = 5)

# ANN-MLP (Artificial Neural Network - Multilayer Perceptron)
library(nnet)
ann_model <- nnet(Murder ~ .,
                  data = train.crime,
                  size = 5,
                  linout = TRUE)
ann_predictions <- predict(ann_model,
                           newdata = test.crime)

# Question l
# R-square and RMSE for KNN
knn_r_squared <- cor(test.crime$Murder,
                     knn_model)^2
knn_rmse <- sqrt(mean((test$Murder - knn_model)^2))

# R-square and RMSE for ANN-MLP
ann_r_squared <- cor(test.crime$Murder,
                     ann_predictions)^2
ann_rmse <- sqrt(mean((test.crime$Murder - ann_predictions)^2))




# Part III
# Question a
# Assigning the value of mtcars dataset to a new data frame called 'data'
data <- mtcars
data$am <- as.factor(data$am)
data$vs <- as.factor(data$vs)
data$cyl <- as.factor(data$cyl)
data$gear <- as.factor(data$gear)
data$carb <- as.factor(data$carb)


# Performing 80-20 split for train-test purpose
ind <- sample(2, nrow(data), 
              replace=T, prob = c(0.8, 0.2))
train <- data[ind==1,]
test <- data[ind==2,]


# Question b
# Fit logistic regression model
model_lr <- glm(am ~ ., data = data, family = binomial)

# Summary of the model
summary(model_lr)


# Question c

library(car) 
vif(model_lr)

# The analysis showed that vif is greater than 2 for some variables. Removing the variable that has the highest vif valus
model_lr <- glm(am ~ ., data = data[, -3], family = binomial)
vif(model_lr)
data

# Removing hp column
model_lr <- glm(am ~ ., data = data[, c(-3, -4 ) ], family = binomial)
vif(model_lr)

# Removing wt column
model_lr <- glm(am ~ ., data = data[, c(-3, -4, -6 ) ], family = binomial)
vif(model_lr)

# Removing qsec
model_lr <- glm(am ~ ., data = data[, c(-3, -4, -6, -7 ) ], family = binomial)
vif(model_lr)

# Removing mpg
model_lr <- glm(am ~ ., data = data[, c(-1, -3, -4, -6, -7 ) ], family = binomial)
vif(model_lr)

# Removing cyl
model_lr <- glm(am ~ ., data = data[, c(-1, -2, -3, -4, -6, -7 ) ], family = binomial)
vif(model_lr)

# Removing vs
model_lr <- glm(am ~ ., data = data[, c(-1, -2, -3, -4, -6, -7, -8 ) ], family = binomial)
vif(model_lr)
# Hence this is the optimum model

# Question d
predict<-predict(model_lr,newdata=train,type="response")
predict # Prediction is continuous but we need it in 0 and 1
predict

predict_lr<-as.numeric((ifelse(predict>0.5,1,0)))
cm_lr<-table(train$am,predict_lr)
cm_lr # Confusion matrix

# Looking at the confusion matrix
TN <- cm_lr[1, 1]
FP <- cm_lr[1, 2]
FN <- cm_lr[2, 1]
TP <- cm_lr[2, 2]
(sensitivity <- TP / (TP + FN))
(specificity <- TN/ (TN + FP))

# Question e
predict<-predict(model_lr,newdata=test,type="response")
predict # Prediction is continuous but we need it in 0 and 1

predict_lr<-as.numeric((ifelse(predict>0.5,1,0)))
predict_lr

# Here we have predicted the transmission variable for test data

# Question f
# Confusion matrix


# Create the confusion matrix
conf_matrix <- table(test$am, predict_lr)
print(conf_matrix)

# Calculate sensitivity and specificity
TN <- conf_matrix[1, 1]
FP <- conf_matrix[1, 2]
FN <- conf_matrix[2, 1]
TP <- conf_matrix[2, 2]

sensitivity <- TP / (TP + FN)
specificity <- TN / (TN + FP)

print(paste("Sensitivity:", sensitivity))
print(paste("Specificity:", specificity))



# Question g

# Naive Bayes
install.packages("e1071")

library(e1071)
set.seed(16)


model_nb<-naiveBayes(am~.,data=train)

predict_nb<-predict(model_nb,newdata=test)
head(predict_nb)
cm_nb<-table(test$am,predict_nb)
cm_nb

(accuracy_nb<-sum(diag(cm_nb)/sum(cm_nb)))

# SVM
model_svm=svm(formula=am~.,data=train,type='C-classification',kernal='linear')
predict_svm<-predict(model_svm,newdata=test)
head(predict_svm)
cm_svm<-table(test$am,predict_svm)
cm_svm

(accuracy_svm<-sum(diag(cm_svm)/sum(cm_svm)))

# Decision tree
# Party package

library(party)

# fit the decision tree
model_dc<-ctree(am~.,data=train)
predict_dc<-predict(model_dc,newdata=test)
head(predict_dc)
cm_dc<-table(test$am,predict_dc)
cm_dc

(accuracy_dc<-sum(diag(cm_dc)/sum(cm_dc)))


# Bagging

library(ipred)
model_bagging<-bagging(am~.,data=train,coob=T)
predict_bagging<-predict(model_bagging,newdata=test)
head(predict_bagging)
cm_bagging<-table(test$am,predict_bagging)
cm_bagging

(accuracy_bagging<-sum(diag(cm_bagging)/sum(cm_bagging)))

# Random forest

library(randomForest)
# fitting random forest model
model_rf<-randomForest(am~.,data=train)
predict_rf<-predict(model_rf,newdata=test)
head(predict_rf)
cm_rf<-table(test$am,predict_rf)
cm_rf

(accuracy_rf<-sum(diag(cm_rf)/sum(cm_rf)))

# Boosting
library(gbm)
boosting_model <- gbm(am ~ .,
                      data = train,
                      distribution = "bernoulli",
                      n.trees = 500,
                      interaction.depth = 3,
                      shrinkage = 0.01)

# Question h
# The best model would be the one that has the highest accuracy. Going through the accuracy scores of the 
# various models that we have created above, we can choose the best model.





