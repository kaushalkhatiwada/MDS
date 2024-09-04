

library(car)
# Data partition :
#Do random sampling to divide the cases into two independent samples
ind <- sample(2, nrow(Arrests), replace = T, prob = c(0.8, 0.2))
#Data partition
train.data <- Arrests[ind==1,]
test.data <- Arrests[ind==2,]

#Logistic
model <- glm(, data = train.data, family = binomial)

View(Arrests)
# Logistic Regression
model <- glm(released ~ colour+age+sex+employed+citizen , data = train.data, family = binomial)

# Naive Bayes
library(e1071)
model.nb <- naiveBayes(  released ~ colour+age+sex+employed+citizen ,data = train.data)

# Predictions from logistic model
predictions <- predict(model, newdata = test.data, type = "response")
#prediction to binary
# Convert predictions to binary values (0/1)
predictions_binary <- as.numeric(ifelse(predictions > 0.5, 1, 0))
#Get the confusion matrix
conf_mat <- table(factor(predictions_binary, levels = c(0, 1)), test.data$released)

conf_mat

