
# PROJECT (Supervised classification)

set.seed(10)
## Generating one binary/dichotomous dependent variable
dependent_var <- as.factor(sample(x = 0:1, size = 200, replace = TRUE))


## Generating two continuous independent variables
cont_var1 <- runif(n = 200,min = 10, max = 100)
cont_var2 <- runif(n = 200, min = 35, max = 76)

## Generate three categorical independent variables
cat_var1 <- as.factor(sample(x = 1: 10, size = 200, replace = TRUE))
cat_var2 <- as.factor(sample(x = 1: 3, size = 200, replace = TRUE))
cat_var3 <- as.factor(sample(x = 4: 10, size = 200, replace = TRUE))

## Creating a dataframe from those variables
data <- data.frame(cont_var1 = cont_var1, cont_var2 = cont_var2,
                   cat_var1 = cat_var1, cat_var2 = cat_var2,
                   cat_var3 = cat_var3,
                   dependent_var = dependent_var)

             # Bivariate Logistic Regression Model


#### Let's take cont_var1 and dependent_var to fit bivariate Logistic Regression Model

index <- sample(2, size = nrow(data),replace = TRUE, prob = c(0.8, 0.2))
train_cont1 <- data[index ==1,c('cont_var1', 'dependent_var')]
test_cont1 <- data[index == 2,c('cont_var1','dependent_var')]
model_cont1 <- glm(dependent_var ~ cont_var1, data = train_cont1,
                   family = 'binomial')
library(ggplot2)
library(gridExtra)

create_plot <- function(x, y, title) {
  ggplot(data, aes(x = !!x, y = !!y)) + # !! for variable evaluation within function
    geom_point(color = 'red') +
    labs(title = title) +
    theme_bw()
}

# Create individual plots (replace titles with your own)
plot1 <- create_plot(cont_var1, dependent_var, "cont_var1 vs dependent_var")
plot2 <- create_plot(cont_var2, dependent_var, "cont_var2 vs dependent_var")
plot3 <- create_plot(cat_var1, dependent_var, "cat_var1 vs dependent_var")
plot4 <- create_plot(cat_var2, dependent_var, "cat_var2 vs dependent_var")
plot5 <- create_plot(cat_var3, dependent_var, "cat_var3 vs dependent_var")
# Arrange plots in a 2x3 grid (adjust rows and columns as needed)
grid.arrange(plot1, plot2, plot3, plot4, plot5, nrow = 2, ncol = 3)


library(car)
## Loading required package: carData
predict_cont1 <- predict(model_cont1, test_cont1, type = 'response')
predict_cont1.test <- factor(ifelse(predict_cont1 > 0.5, 1, 0))
library(caret)

confusionMatrix(predict_cont1.test, test_cont1$dependent_var)
##### When we use this variable alone to predict the dependent variable, we get an accuracy of 0.5135 
##### sensitivity of 0.3333 and specificity of 0.5000 


#### Let's take cont_var2 and dependent_var to fit bivariate Logistic Regression Model
train_cont2 <- data[index ==1, c("cont_var2", "dependent_var")]
test_cont2 <- data[index ==2, c("cont_var2", "dependent_var")]

##### Train logistic regression model with cont_var2 data
model_cont2 <- glm(dependent_var ~ cont_var2, data = train_cont2, family = "binomial")

##### Make predictions from the model on the test data
predict_cont2 <- predict(model_cont2, test_cont2, type = 'response')
predict_cont2.test <- factor(ifelse(predict_cont2 > 0.5, 1, 0))

confusionMatrix(predict_cont2.test, test_cont1$dependent_var)
##### When we use this variable alone to predict the dependent variable, we get an accuracy of 0.5588 ,
##### sensitivity of 0.7778  and specificity of 0.3125   

#### Let's take cat_var1 and dependent_var to fit bivariate Logistic Regression Model
train_cat1 <- data[index ==1, c("cat_var1", "dependent_var")]
test_cat1 <- data[index ==2, c("cat_var1", "dependent_var")]

##### Train logistic regression model with cat_var1 feature
model.cat1 <- glm(dependent_var ~ cat_var1, data = train_cat1, family = "binomial")
##### Make predictions on the test datasets
predict_cat1 <- predict(model.cat1, test_cat1, type = "response")
predict_cat1.test <- factor(ifelse(predict_cat1 > 0.5, 1, 0))
confusionMatrix(predict_cat1.test, test_cat1$dependent_var)

#### Let's take cat_var2 and dependent_var to fit bivariate Logistic Regression Model
train_cat2 <- data[index ==1, c("cat_var2", "dependent_var")]
test_cat2 <- data[index ==2, c("cat_var2", "dependent_var")]

##### Fit a bivariate logistic regression model on cat_var2 feature
model.cat2 <- glm(dependent_var ~ cat_var2, data = train_cat2, family = "binomial")


##### Make predictions on the test datasets
predict_cat2 <- predict(model.cat2, test_cat2, type = "response")
predict_cat2.test <- factor(ifelse(predict_cat2 > 0.5, 1, 0))

confusionMatrix(predict_cat2.test, test_cat2$dependent_var)

##### When we use this variable alone to predict the dependent variable, we get an accuracy of 0.5588 ,
##### sensitivity of 0.8333 and specificity of 0.2500 

#### Let's take cat_var3 and dependent_var to fit bivariate Logistic Regression Model
train_cat3 <- data[index ==1, c("cat_var3", "dependent_var")]
test_cat3 <- data[index ==2, c("cat_var3", "dependent_var")]


##### Train the bivariate logistic regression model against cat_var3 feature
model.cat3 <- glm(dependent_var ~ cat_var3, data = train_cat3, family = 'binomial')

##### Let's make predictions on the test data
predict_cat3 <- predict(model.cat3, test_cat3, type = 'response')

predict_cat3.test <- factor(ifelse(predict_cat3 > 0.5, 1, 0))

confusionMatrix(predict_cat3.test, test_cat3$dependent_var)

##### When we use this variable alone to predict the dependent variable, we get an accuracy of 0.4118         ,
##### sensitivity of 0.4444   and specificity of 0.3750      




#                  Multivariate Logistic Regression

train_full <- data[index==1,]
test_full <- data[index==2,]


# Fitting the model on the training datasets
model.full <- glm(dependent_var ~ ., data = train_full, family = "binomial")

##### Before applying logistic regression, we need to check whether there are any multicollinear issues
vif(model.full)

##### Since vif is less than 2 for all independent features, there is no multicollinearity in the data

##### Make predictions on the test set
predict.full <- predict(model.full, test_full, type = "response")
predict.full <- factor(ifelse(predict.full > 0.5, 1, 0))

confusionMatrix(predict.full, test_full$dependent_var)

##### When we use all the features to predict the dependent variable using multivariate logistic
##### regression algorithm, we get an accuracy of 0.4706 , sensitivity of 0.6667 abd specificity of 0.2500

#                        Naive Bayes Algorithm
#### Assumptions
##### • The Naive Bayes algorithm is called “Naive” because it makes the assumption that the occurrence

library(e1071)

##### Fitting naiveBayes model on the training data
model.nb <- naiveBayes(dependent_var ~ ., data = train_full)


Call:naiveBayes.default(x = X, y = Y, laplace = laplace)

predict.nb <- predict(model.nb, test_full)


confusionMatrix(predict.nb, test_full$dependent_var)

##### When we use all the features to predict the dependent variable using Naive Baye's
##### algorithm, we get an accuracy of 0.5294 , sensitivity of 0.7222  and specificity of 0.3125



#####            Fitting Liner SVM algorithm on the training datasets
model.svm <- svm(formula = dependent_var ~ .,
                 data = train_full,
                 type = 'C-classification',
                 kernel = 'linear')

##### Check the model
model.svm

#### Making predictions on the test set
predict.svm <- predict(model.svm, test_full)

##### Confusion Matrix
confusionMatrix(predict.svm, test_full$dependent_var)

##### When we use all the features to predict the dependent variable using Support Vector Machine
##### algorithm using linear kernel, we get an accuracy of 0.5, sensitivity of 0.8333 and specificity 0.1250

####                       Decision Trees
##### For fitting decision trees, we need to install party package
# install.packages('party')
library(party)

##### Fit the decision trees in the training datasets
model.dt <- ctree(dependent_var~., data = train_full)

##### check the model
model.dt

##### Predict the category for each case in the test data
predict.dt <- predict(model.dt, test_full)

#### Confusion Matrix
confusionMatrix(predict.dt, test_full$dependent_var)

#                           Random Forest
## We need to install randomForest package for implementing this algorithm
# install.packages('randomForest')

library(randomForest)
#### Fitting random forest model on the training datasets
model.rf <- randomForest(dependent_var ~ ., data = train_full)


#### Printing the random forest model
print(model.rf)

##### Making predictions on the test set using random forest algorithm
predict.rf <- predict(model.rf, test_full)

##### Checking top 5 predictions done by the random forest
head(predict.rf)

##### Confusion Matrix
confusionMatrix(predict.rf, test_full$dependent_var)


#                                Bagging
## We need to install the package named 'ipred' to apply bagging algorithm in R.
#install.packages('ipred')
library(ipred)

##### Fitting the training data in bagging model
model.bagging <- bagging(dependent_var ~ ., data = train_full)
print(model.bagging)
##### Making predictions on the testing dataset using bagging model
predict.bagging <- predict(model.bagging, test_full)
##### Confusion Matrix
confusionMatrix(predict.bagging, test_full$dependent_var)





#                              Random Forest
## We need to install randomForest package for implementing this algorithm
# install.packages('randomForest')
library(randomForest)
#### Fitting random forest model on the training datasets
model.rf <- randomForest(dependent_var ~ ., data = train_full)
#### Printing the random forest model
print(model.rf)

##### Making predictions on the test set using random forest algorithm
predict.rf <- predict(model.rf, test_full)

##### Checking top 5 predictions done by the random forest
head(predict.rf)

#####                Confusion Matrix
confusionMatrix(predict.rf, test_full$dependent_var)



## Tuned Random Forest
##### For tuning the graph, we need to plot the graph to see at what number of trees the random forest h
##### From this graph, we can see that the graph look kind of stationary throughout but we can see the l
##### in between 200 and 300 so taking number of trees = 250 for further tuning the model.

plot(model.rf)
library(gbm)
# Boosting Algorithm
#### Fitting gradient boosting model on the training datasets
model.gbm <- train(dependent_var~., data = train_full,
                   method = "gbm", verbose = F)

print(model.gbm)
##### Making predictions on the test dataset
predict.gbm <- predict(model.gbm, test_full)
summary(model.gbm)
##### Confusion matrix and Statistics
confusionMatrix(predict.gbm, test_full$dependent_var)




