library(car)
data("Arrests")
crime <- Arrests[, -8]
str(crime)

# Question a
# Split the dataset into training and testing dataset
set.seed(16)
index <- sample(2, nrow(crime), replace = T, prob = c(0.8, 0.2))
train.crime = crime[index == 1, ] # Training dataset
test.crime = crime[index == 2, ] # Testing dataset

# Question b
# Logistic Regression
model_lr <- glm(released ~ ., data = train.crime, family = binomial)

# Naive Bayes
library(e1071)
set.seed(16)
model_nb<-naiveBayes(released ~., data= train.crime)

# Question c
# For LR
predicted_lr <- predict(model_lr, test.crime)
predict_lr<-as.numeric((ifelse(predicted_lr>0.5,1,0)))
conf_matrix <- table(test.crime$released, predict_lr)
print(conf_matrix)

# Calculate sensitivity and specificity
TN <- conf_matrix[1, 1]
FP <- conf_matrix[1, 2]
FN <- conf_matrix[2, 1]
TP <- conf_matrix[2, 2]

(sensitivity <- TP / (TP + FN))
(specificity <- TN / (TN + FP))
(accuracy_lr<-sum(diag(conf_matrix)/sum(conf_matrix)))

#For Naive Bayes

predict_nb<-predict(model_nb,newdata=test.crime)
cm_nb<-table(test.crime$released,predict_nb)
cm_nb
(accuracy_nb<-sum(diag(cm_nb)/sum(cm_nb)))


# Question d
# Here both the classification model show similar result of accuracy.
# Therefore, any one of the method can be employed for
#classification.





