
# Using mtcars Dataset

## A
#Divide the mtcars data into train and test datasets with 80:20 random splits
set.seed(13)
index <- sample(2,nrow(mtcars),replace = T,prob = c(0.8,0.2)) #Random sampling into two independent c=variable
train.mtcars <- mtcars[index==1,] #Training set
test.mtcars <- mtcars[index==2,]  #Test set



## B
# Fit a supervised logistic regression model classification models on train data 
# with “am” as dependent variable and all other variables as independent variable

train.suplogr <- glm(am ~., data=train.mtcars,family=binomial)
summary(train.suplogr)



## C
# Check multicollinearity of this model and finalize it using appropriate VIF cut-off value for logistic regression 
vif(train.suplogr)
#Remove "Disp" because Independent variables with VIF >2 means presence of multicollinearity.
train.suplogr1 <- glm(am ~ mpg+cyl+hp+drat+wt+qsec+vs+gear+carb, data=train.mtcars,family=binomial)
vif(train.suplogr1)
#Remove "Qsec" because Independent variables with VIF >2 means presence of multicollinearity.
train.suplogr1 <- glm(am ~ mpg+cyl+hp+drat+wt+vs+gear+carb, data=train.mtcars,family=binomial)
vif(train.suplogr1)
#Remove "Cyl" because Independent variables with VIF >2 means presence of multicollinearity
train.suplogr1 <- glm(am ~ mpg+hp+drat+wt+vs+gear+carb, data=train.mtcars,family=binomial)
vif(train.suplogr1)
#Remove "Carb" because Independent variables with VIF >2 means presence of multicollinearity
train.suplogr1 <- glm(am ~ mpg+hp+drat+wt+vs+gear, data=train.mtcars,family=binomial)
vif(train.suplogr1)
#Remove "Mpg" because Independent variables with VIF >2 means presence of multicollinearity
train.suplogr1 <- glm(am ~ hp+drat+wt+vs+gear, data=train.mtcars,family=binomial)
vif(train.suplogr1)
#Remove "Hp" because Independent variables with VIF >2 means presence of multicollinearity
train.suplogr1 <- glm(am ~ drat+wt+vs+gear, data=train.mtcars,family=binomial)
vif(train.suplogr1)
#Remove "Gear" because Independent variables with VIF >2 means presence of multicollinearity
train.suplogr1 <- glm(am ~ drat+wt+vs, data=train.mtcars,family=binomial)
vif(train.suplogr1)
#Remove "Vs" because Independent variables with VIF >2 means presence of multicollinearity
train.suplogr1 <- glm(am ~ drat+wt, data=train.mtcars,family=binomial)
vif(train.suplogr1)
# VIF<2 so, "Drat" and "wt" remains

##D
# Get the confusion matrix, sensitivity, specificity of the fitted model and interpret them carefully



## E
#	Predict the transmission variable in the test data and interpret the result carefully
 



## F
#	Get the confusion matrix, sensitivity, specificity of the predicted model and interpret them carefully




## G
# Fit a supervised naïve bayes, support vector machine, decision tree, bagging, random forest, 
# tuned random forest model and boosting classification models on training data with “am” as dependent variable and all other variables as independent variables


# Evaluate models and compare performance
results <- resamples(models)
summary(results)






## H
# Which supervised classification model is the best predictive model? Why?  
  