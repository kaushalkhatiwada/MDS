

# Q.8 
library(car)
# set.seed(22)
data("Arrests")
arrests <- Arrests

# a. Train Test Split
# Train set = 80%
# Test set = 20%
arrests_sample <- sample(c(TRUE, FALSE), nrow(arrests),
                      replace=T, prob=c(0.8, 0.2))

train_arrests <- arrests[arrests_sample,]
train_arrests$released <- as.factor(as.numeric(train_arrests$released), levels=c(0, 1))
test_arrests <- arrests[!arrests_sample,]
test_arrests$released <- as.factor(as.numeric(test_arrests$released), levels=c(0, 1))

# Multicollinearity Test
# VIF < 2 --> No multicollinearity
# vif < 2: use that independent feature
# vif > 2: remove that independent feature
lr_model <- glm(released ~ colour+age+sex+employed+citizen,
                data=train_arrests,
                family=binomial)

vif_val <- vif(lr_model)
print(vif_val)

# vif < 2, No multicollinearity in the data, we can fit the 
# logistic regression model

# Fit Naive Bayes Model

# NAIVE BAYES MODEL
library(e1071)
nb_model <- naiveBayes(released ~ colour+age+sex+employed+citizen, 
                       data=train_arrests)


# Generate Prediction
# Logistic Regerssion Model

pred <- predict(lr_model, type="response")
pred_tm <- as.numeric(ifelse(pred>0.5, 1, 0))
lr_conf_mat <- confusionMatrix(as.factor(pred_tm), test_arrests$released)
print(lr_conf_mat)

test_pred_nb <- predict(nb_model, newdata = test_arrests)
nb_conf_mat <- confusionMatrix(as.factor(test_pred_nb), test_arrests$released)
print(nb_conf_mat)






# Q.7 
aq <- airquality

# Good of FIt Test (Large sample)
# H0: 


