
# Using USArrests Dataset

## A	
# Create an “crime” dataset containing all the variables of USArrests
crime <- USArrests

## B
# Create correlation matrix plot of the crime data and interpret each scatterplot carefully
cor(crime)
#visualize correlation matrix
library(ggcorrplot)
ggcorrplot(cor(crime),hc.order = T,lab = T)

#Relationship between two variable 
# -1 inverse linear relationship,
# 0 no linear correlation,
# 1 linear relationship]

library(ggplot2)
plot(crime, pch=20,cex=1,col='steelblue',main="Scatter Plot")



## C	
# Split the crime dataset into training and testing data with 70% and 30% cases
set.seed(13)
index <- sample(2,nrow(crime),replace = T,prob = c(0.7,0.3)) #Random sampling into two independent variable
train.crime <- crime[index==1,] #Training set
test.crime <- crime[index==2,]  #Test set


## D 
# Fit a multiple linear regression on training data with Murder as dependent variable and 
# all other variables as independent variables and interpret the results carefully using 
# R-squared, RMSE, Regression ANOVA and Regression Coefficients (BLUE?)

#R-square [higher is better]
#RMSE - Root of MSE(Mean Sum of Square) [lower is better]
#MAE - Mean absolute Error [lower is better]
#MAPE - Mean absolute Percentage Error [lower is better]
mlr <- lm(Murder ~ .,data=train.crime)
summary(mlr)
# R-squared = 0.6648
mean(mlr$residuals^2)   #RMSE= 5.656679
mlr$coefficients        #Regression Coefficient (Intercept)
anova(mlr)              #Regression ANOVA
# "Assault" is highly significance, p-value<0.05

## E
# Check multicollinearity and finalize this model with the appropriate VIF cut-off value
vif(mlr)
# No Multicollinearity beacuse VIF <10


## F	
# Perform residual analysis of this model i.e. LINE tests using suggestive graphs and confirmatory tests and interpret the results carefully
###LINE###

###### L = Linearity of residuals
### Suggestive
plot(mlr,which = 1,col=c("blue")) # LOESS line lies in the zero line so residuals are linear
### Confirmative
summary(mlr$residuals)    #Mean = 0 so residuals are linear


###### I = Independence of residuals
### Suggestive
acf(mlr$residuals)        # Show Up and Down so no autocorrelation
### Confirmative
library(car)
durbinWatsonTest(mlr)     # p-value>0.05 no autocorrelation


###### N = Normality of residuals
### Suggestive
plot(mlr,which = 2,col=c("blue"))   # Values line not in diagonal so no normal distribution
### Confirmative
shapiro.test(mlr$residuals)   # p-value > 0.05, residuals follow normal distribution


###### E = Equal variance of residuals
### Suggestive
plot(mlr,which = 3,col=c("blue"))
### Confirmative
library(lmtest)
bptest(mlr)               # p-value > 0.05, so residual variances are equal (homoscedasticity)

## G	
# Predict the Murder in the testing dataset using the fitted model
prediction <- predict(mlr,test.crime)



## H
# Report R-square and RMSE of predicted model and interpret them carefully
data.frame(R2 = R2(prediction, test.crime$Murder),
           RMSE = RMSE(prediction, test.crime$Murder))


## I
# Report R-square and RMSE of predicted model using other cross-validation methods i.e. LOOCV, k-fold and repeated k-fold
######Leave-One-OUT Cross validation
library(caret)
train.control1 <- trainControl(method = "LOOCV")  #Define training control
model1<- train(Murder ~., data=train.crime,method="lm",trControl=train.control1) #Train the model
summary(model1)

predictions1 <- model1 %>% predict(test.crime) #Predict the test set
data.frame(R2=R2(predictions1, test.crime$Murder),  # Validate the prediction
           RMSE=RMSE(predictions1, test.crime$Murder),
           MAE=MAE(predictions1, test.crime$Murder))

######K-folds Cross Validation

train.control2 <- trainControl(method = "cv", number=10)  #Define training control
model2<- train(Murder ~., data=train.crime,method="lm",trControl=train.control2) #Train the model
summary(model2)

predictions2 <- model2 %>% predict(test.crime) #Predict the test set
data.frame(R2=R2(predictions2, test.crime$Murder), # Validate the prediction
           RMSE=RMSE(predictions2, test.crime$Murder),
           MAE=MAE(predictions2, test.crime$Murder))

######Repeated K-fold
train.control3 <- trainControl(method = "repeatedcv", number=10, repeats = 3)  #Define training control
model3<- train(Murder ~ ., data=train.crime,method="lm",trControl=train.control3) #Train the model
summary(model3)

predictions3 <- model3 %>% predict(test.crime) #Predict the test set
data.frame(R2=R2(predictions3, test.crime$Murder), # Validate the prediction
           RMSE=RMSE(predictions3, test.crime$Murder),
           MAE=MAE(predictions3, test.crime$Murder))



## J
# Which predicted model is the best model? Why?






## K
# Fit KNN and ANN-MLP regression on the training data and predict on the testing data.




## L
# Compare R-square and RMSE of KNN and ANN-MLP models with linear regression




## M
# Which regression model is best? Why? 
  
