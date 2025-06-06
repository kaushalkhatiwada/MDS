# Do the following in R studio using "Arrests" dataset of car package with R script to knit PDF output:
library(car)
data("Arrests")
## a. Divide the Arrests data into train and test datasets with 80:20 random splits.
set.seed(35)
sample <- sample(c(TRUE, FALSE),
                 replace = TRUE,
                 prob = c(0.7, 0.3))
trainData <- Arrests[sample, ]
testData <- Arrests[!sample, ]

## b. Fit a supervised logistic regression and Naive Bayes classification models on train data with "released" as dependent variable and colour, age, sex, employed and citizen as independent variable.
# Fit a supervised logistic regression
logit_model <- glm(released ~ colour + age + sex + employed + citizen,
                   data = trainData,
                   family = binomial)
summary(logit_model)
# Fit the Naive Bayes model
library(e1071)
nb_model <- naiveBayes(released ~ colour + age + sex + employed + citizen,
                       data = trainData)
nb_model

## c. Predict the released variable in the test datasets of these models and interpret the result carefully.
# Predict on test data using logistic regression
logit_preds <- predict(logit_model,
                       newdata = testData,
                       type = "response")
logit_class <- ifelse(logit_preds > 0.5,
                      1,
                      0)
# Confusion matrix for logistic regression
library(caret)
logit_cm <- confusionMatrix(factor(logit_class),
                            factor(testData$released))
logit_cm
# Predict on test data using Naive Bayes
nb_preds <- predict(nb_model,
                    newdata = testData)
# Confusion matrix for Naive Bayes
nb_cm <- confusionMatrix(nb_preds,
                         factor(testData$released))
nb_cm

## d. Compare and decide which classification model is better for this data.
# Comparing models based on accuracy and other metrics
logit_accuracy <- logit_cm$overall['Accuracy']
nb_accuracy <- nb_cm$overall['Accuracy']

# Comparing other metrics if necessary
logit_cm
nb_cm