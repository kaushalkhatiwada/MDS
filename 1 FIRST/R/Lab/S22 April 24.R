

lm1 <- lm(mpg ~wt, data=mtcars) #Predicting mpg(miles per gallon) based on weight
mse <- mean(lm1$residuals^2)   #Get MSE of Simple linear Model, residuals is response minus fitted values.

#Save predicted values
data <- data.frame(pred= predict(lm1), actual=mtcars$mpg)
head(data)

mean((data$actual -data$pred)^2) # same as residuals, residuals= Actual - Predicted

new.wt <- data.frame(wt = 6)
predict(lm1, newdata = new.wt)
# 5.218297
#Interpretation: Cars with 6000 lbs weight will (only) give 5.22 miles per gallon.


#### Calculate Model Accuracy
#R-square [higher is better]
#RMSE - Root of MSE(Mean Sum of Square) [lower is better]
#MAE - Mean absolute Error [lower is better]
#MAPE - Mean absolute Percentage Error [lower is better]

library(caret)
R2 <- R2(data$pred, data$actual)
RMSE <- RMSE(data$pred, data$actual)
MAE <- MAE(data$pred, data$actual)
MAPE <- mean(abs((data$actual-data$pred)/data$actual)) * 100

########## VALIDATION/CROSS VALIDATION
#1) DATA SPLIT
kkdata<- mtcars
set.seed(1234)
ind <- sample(2,nrow(mtcars),replace = T,prob = c(0.7,0.3)) #Random sampling into two independent c=variable
train.kkdata <- kkdata[ind==1,] #Training set
test.kkdata <- kkdata[ind==2,]  #Test set



lm4 <- lm(mpg ~wt, data=train.kkdata)  #Train model with training set
library(dplyr)
predictions <- lm4 %>% predict(test.kkdata) #Predict the test set

data.frame(R2=R2(predictions, test.kkdata$mpg),    #Cross validate the prediction
           RMSE=RMSE(predictions, test.kkdata$mpg),
           MAE=MAE(predictions, test.kkdata$mpg))

summary(lm4)


#2) Leave-One-OUT Cross validation
library(caret)
train.control <- trainControl(method = "LOOCV")  #Define training control
model1<- train(mpg ~wt, data=mtcars,method="lm",trControl=train.control) #Train the model
print(model1)

predictions1 <- model1 %>% predict(test.kkdata) #Predict the test set
data.frame(R2=R2(predictions1, test.kkdata$mpg),  # Validate the prediction
           RMSE=RMSE(predictions1, test.kkdata$mpg),
           MAE=MAE(predictions1, test.kkdata$mpg))

#3) K-folds Cross Validation

set.seed(123)
train.control <- trainControl(method = "cv", number=10)  #Define training control
model2<- train(mpg ~wt, data=mtcars,method="lm",trControl=train.control) #Train the model
summary(model2)

predictions2 <- model2 %>% predict(test.kkdata) #Predict the test set
data.frame(R2=R2(predictions2, test.kkdata$mpg), # Validate the prediction
           RMSE=RMSE(predictions2, test.kkdata$mpg),
           MAE=MAE(predictions2, test.kkdata$mpg))

#4) Repeated K-fold

set.seed(123)
train.control <- trainControl(method = "repeatedcv", number=10, repeats = 3)  #Define training control
model3<- train(mpg ~wt, data=mtcars,method="lm",trControl=train.control) #Train the model
summary(model3)

predictions3 <- model3 %>% predict(test.kkdata) #Predict the test set
data.frame(R2=R2(predictions3, test.kkdata$mpg), # Validate the prediction
           RMSE=RMSE(predictions3, test.kkdata$mpg),
           MAE=MAE(predictions3, test.kkdata$mpg))

##### Interpret of all the cross validation methods
# Model Selected based in R-square or RMSE

     #RMSE for training set: 3.08648
     #RMSE for training with LOOCV : 3.201673
     #RMSE for training with k-folds CV: 2.85133
     #RMSE for training with repeated k- folds CV: 2.975392

     #RMSE for testing test: 2.279303 
     #RMSE for testing with LOOCV: 2.244232
     #RMSE for testing with k-folds CV: 2.244232
     #RMSE for testing with repeated k- folds CV: 2.244232


############## MULTIPLE LINEAR REGRESSION
# have more than one (two or more) independent variables. 
# has one continuous dependent variable so it is a supervised learning
# all assumption of simple regression and one more condition to satisfy :
   # Multicollinearity must not be present i.e. correlations between independent variables must not be “high”

mlr <- lm(mpg ~., data=mtcars)
summary(mlr)


library(car)
vif(mlr) # check the variance Inflation Factor(VIF) and DROP INDEPENDENT VARAIBLE WITH HIGHEST VALUE
# Remove "disp" variable
mlr1 <- lm(mpg ~ cyl+hp+drat+wt+qsec+vs+am+gear+carb,data=mtcars) 
summary(mlr1)
vif(mlr1)

# Remove "cyl" variable
mlr2 <- lm(mpg ~ hp+drat+wt+qsec+vs+am+gear+carb,data=mtcars) 
summary(mlr2)
vif(mlr2)
# NOW VIF are <10

######Assignment
aadata <- mtcars
str(aadata)
set.seed(13)
aaind <- sample(2,nrow(aadata),replace = T,prob = c(0.7,0.3)) #Random sampling into two independent c=variable
train.aadata <- aadata[aaind==1,] #Training set
test.aadata <- aadata[aaind==2,]

mlr3 <- lm(mpg ~ hp+drat+wt+qsec+vs+am+gear+carb,data=aadata) 
vif(mlr3)


# Cross Validation 
#1)



###############################################
################# Regularized Regression
#A) Ridge Regression
#B) Lasso Regression
#C) Elastic net Regression
