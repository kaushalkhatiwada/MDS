# Q8) 

library(car)
library(dplyr)

data <- Arrests


### taking colour, age, sex, employed and citizen as independent variable and released as dependent variable
### Converting the target variable into numeric values and then again converting them as factor variables.

data$released <- ifelse(data$released == "Yes", 1, 0)

data$released <- as.factor(data$released)

final_data <- select(data, "released", "colour", "age", 
                     "sex", "employed", "citizen")

table(final_data$colour)

## Converting categorical variables colour into binary intergers and then as factors
final_data$colour <- ifelse(final_data$colour == "Black", 0, 1)
final_data$colour <- as.factor(final_data$colour)

### Converting categorical variables gender female as 0 and male as 1
final_data$sex <- ifelse(final_data$sex == "Female", 0, 1)
final_data$sex <- as.factor(final_data$sex)

### Converting categorical variables employed  no as 0 and yes as 1
final_data$employed <- ifelse(final_data$employed == "No", 0, 1)
final_data$employed <- as.factor(final_data$employed)

### Converting categorical variables citizen no as 0 and yes as 1
final_data$citizen <- ifelse(final_data$citizen == "No", 0, 1)
final_data$citizen <- as.factor(final_data$citizen)





library(ggplot2)

##
create_plot <- function(x, y, title) {
  ggplot(data, aes(x = !!x, y = !!y)) +
    geom_point(color = 'red') +
    labs(title = title) +
    theme_bw()
}

plot1<- create_plot(final_data$released, final_data$colour, "released vs colour")
plot2<- create_plot(final_data$released, final_data$age, "released vs age")
plot3<- create_plot(final_data$released, final_data$sex, "released vs sex")
plot4<- create_plot(final_data$released, final_data$employed, "released vs employed")
plot5<- create_plot(final_data$released, final_data$citizen, "released vs citizen")


library(gridExtra)



grid.arrange(plot1, plot2, plot3, plot4, plot5, 
             nrow = 3, ncol = 2)


### From this graph, we can see that there exist non linear relationship between the target variable and independent variable.


### Apply multivariate logistic regression

model.lr <- glm(released~., data = final_data,
                family = 'binomial'
)


summary(model.lr)

### Checking whether there exist mulitcollinearity in the features.
### TO check it, we have VIF(Variance Inflation Factor).
### IF the VIF value of the feautures in a model is greater than 2, then we can remove such feature as it suffers from multicolinearity issue.
vif(model.lr)

### Since, the vif of all of these features are less than 2, we can say that these features are not collinear to each other.

## Divide the data into train and test sets using 70:30 random splits
set.seed(22)

ind <- sample(2, size = nrow(final_data), replace = T, 
              prob = c(0.7, 0.3))




train.data <- final_data[ind == 1,]
test.data <- final_data[ind == 2, ]


## Now only applying logistic regression on the training dataset
model.lr <- glm(released~., data = train.data,
                family = 'binomial'
)


#### Making predictions on the test datasets

predictions <- predict(model.lr, test.data)


predictions <- ifelse(predictions > 0.5, 1, 0)


lr_pred_df<- data.frame(actual = test.data$released, 
                        predicted = predictions)


head(lr_pred_df, 10)


### Based on the predicted results, we can say that the model is pgiving more postive(1) predictions correct than 0 predictions correct.

### Confusion Matrix

library(caret)


confusionMatrix(as.factor(predictions), test.data$released)

### The accuracy of the logistic regression model is 0.8296 and specificity is 0.98 and sensitivity is 0.06.

## naive bayes algorithm
library(e1071)


model.nb <- naiveBayes(released~., data = train.data)



predictions <- predict(model.nb, test.data)

nb_pred_df<- data.frame(actual = test.data$released, 
                        predicted = predictions)


head(nb_pred_df, 10)

### Based on the predicted results, we can say that the model is pgiving more postive(1) predictions correct than 0 predictions correct.


confusionMatrix(as.factor(predictions), test.data$released)

### The accuracy of the naive bayes model is 0.8277 and specificity is 0.98 and sensitivity is 0.066.


