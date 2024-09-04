
# PRESENTATION
#---------------
#(Generate 200 random data with one continuous dependent variable and five independent variables, random seed = your roll number. 

set.seed(13)
A<-rnorm(200)
B<-rnorm(200)
C<-rnorm(200)
D<-rnorm(200)
E<-rnorm(200)
K <- A+ 0.2*B+ 0.3*C+ 0.4*D+ 0.5*E+ rnorm(200)  # Dependent Variable
data <- data.frame(K,A, B,C, D, E)

# Split data into train and test
ind <- sample(2, nrow(data), replace = T, prob = c(0.7, 0.3))
train.data <- data[ind==1,]
test.data <- data[ind==2,]

# Bivariate
lmA <- lm(K~A,data=data)
lmB <- lm(K~B,data=data)
lmC <- lm(K~C,data=data)
lmD <- lm(K~D,data=data)
lmE <- lm(K~E,data=data)

#Multivariate
multi <- lm(K ~ .,data=data)


####################################################
######## VIF [Variance Inflation Factor] TEST ########
vif(multi)
#VIF < 10 so,no multicollinearity

######## BLUE [Best, Linear, Unbiased, Estimate] TEST #######

## 1 ## NORMALITY TEST FOR DEPENDENT VARIABLE ###
shapiro.test(data$K)  
# Normality Test p-value>0.05, so dependent variable is normal distribution assumption 1 passed

## 2 ## LINEARITY TEST BETWEEN DEPENDENT AND INDEPENDENT VARIABLE USING CORRELATION TEST###
plot(data$K,data$A)
corA <- cor.test(data$K,data$A,method = "pearson")
corB <- cor.test(data$K,data$B,method = "pearson")
corC <- cor.test(data$K,data$C,method = "pearson")
corD <- cor.test(data$K,data$D,method = "pearson")
corE <- cor.test(data$K,data$E,method = "pearson")

correlation <- data.frame(corA$estimate,corB$estimate,corC$estimate,corD$estimate,corE$estimate)
## 2 ## LINEARITY TEST BETWEEN DEPENDENT AND INDEPENDENT VARIABLE USING CORRELATION TEST###
correlation
# -1 indicates a perfectly negative linear correlation between two variables
# 0 indicates no linear correlation between two variables
# 1 indicates a perfectly positive linear correlation between two variables
# So, Coefficient of correlation are positively correlated.

## 3 ## COEFFICIENT OF DETERMINATION (R^2) ###

summary(lmA)
summary(lmB)
summary(lmC)
summary(lmD)
summary(lmE)

summary(multi)
# 0	= Model does not predict the outcome.
# Between 0 and 1	= Model partially predicts the outcome.
# 1	= Model perfectly predicts the outcome.
# So, R^2 is between 0 and 1 therefore the model perfectly predicts the outcome

## 4 ## REGRESSION ANOVA ###
summary(aov(K~.,data=data))

# DF - Degree of Freedom
# Pr(>F) - P-value


## 5 ## SIGNIFICANCE OF A REGRESSION SLOPE ###



# NOW CONDITION FOR BLUE [Best, Linear, Unbiased, Estimate] ESTIMATE IS FULFILLED !!!!
######## LINE [Linear, Independence, Normal, Equal variance] TEST #######

# Linearity
plot(multi,which=1,col=("blue"))
summary(multi$residuals) # If Mean is 0 then residuals are linear 

# Independence
acf(multi$residuals)
library(car)
 # Calculate Durbin-Watson Test of residuals, If p-value > 0.05, no auto correlation
durbinWatsonTest(multi)

# Normal
plot(multi,which=2,col=c("blue"))
# Get Shapiro-Wilk testof residuals, If p-value > 0.05, follow normal distribution
shapiro.test(multi$residuals)  

# Equal variance
plot(multi,which=3,col=c("blue"))
library(lmtest)
# Get Breush-pagan test of residuals, If p-value > 0.05, residual variable are equal (homoscedasticity)
bptest(multi)     

# NOW CONDITION FOR LINE ARE VALID, WE CAN PREDICT




# predict for the test data (30% sample)
linearmodel <- predict(multi,newdata = test.data)


r2 <- R2(linearmodel, test.data$K)
rmse <- RMSE(linearmodel, test.data$K)

#  compare it with KNN regression, ANN regression and Support Vector Regression using R-square and RMSE of test data and 
library(caret) 
### KNN - K Nearest Neighbor Regression ###
#Training data scaling
train_x = train.data[,-1]
train_x = scale(train_x)[,]                                                 #standardizes each column of the data set (subtracting the mean and dividing by the standard deviation)
train_y = train.data[,1]

#Test(validation) data scaling
test_x <- test.data[,-1]
test_x <- scale(test.data[,-1])[,]
test_y <- test.data[,1]


knnmodel = knnreg(train_x,train_y)
pred_y=predict(knnmodel,data.frame(test_x))
mse = mean((test_y-pred_y)^2)
mae = caret::MAE(test_y,pred_y)
rmse = caret::RMSE(test_y,pred_y)
cat("MSE: ", mse,
    "MAE: ", mae, 
    "RMSE: ", rmse)


#Plot
x = 1:length(test_y)
plot(x, test_y, 
     col = "red", 
     type = "l", 
     lwd=2
     )
lines(x, pred_y, 
      col = "blue", 
      lwd=2)
legend("topright", 
       legend = c("original", "predicted"), 
       fill = c("red", "blue"), 
       col = 2:3, 
       adj = c(0, 0.6))
grid()


################## ANN ##################
library(neuralnet)
SN<- seq(from=1, to =200)
data<- cbind(data,SN)
##NN Model
n <- neuralnet(K ~ SN,
               data=data ,
               hidden =1, linear.output=F)
plot(n)

n1 <- neuralnet(K ~ SN,
                data=data ,
                hidden =c(3,2),   # hidden layer 3 and 2 neurons
                linear.output=F)
plot(n1)

################## SVR ##################
library(e1071)
svreg <- svm(formula=K~.,
             data=train.data,
             type="eps-regression",
             kernel="linear")
K_predict <- predict(svreg,newdata = train.data)
mse = mean((test_y- K_predict)^2)
mae = caret::MAE(test_y,K_predict)
rmse = caret::RMSE(test_y,K_predict)
cat("MSE: ", mse,
    "MAE: ", mae, 
    "RMSE: ", rmse)


plot(data)
points(train.data$K,K_predict, col="red",pch=16)




# find the best supervised regression model for this data.






#-----------
# Project 4
#-----------
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


