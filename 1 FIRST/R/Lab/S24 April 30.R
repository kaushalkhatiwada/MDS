getwd()
setwd("C:/Users/kaush/OneDrive - Tribhuvan University/MDS/FIRST/R/Resources")

library(readr)
titanic <- read_csv("titanic.csv")


View(titanic)
str(titanic)

# Removed name column
data<- titanic[,-3]
View(data)

#Change Survived as factor variable
table(data$Survived)
data$Survived <- as.factor(data$Survived)

#Change Pclass as factor variable
table(data$Pclass)
data$Pclass <- as.factor(data$Pclass)

#Change Sex as factor variable
data$Sex <- as.factor(data$Sex)

View(data)

#Logistic regression with generalized linear model function
# Family = binomial mean dependent variable is binary: 0 and 1 
model.full <- glm(Survived ~., data=data, family=binomial)
summary(model.full)

# McFadden's pseudo R-square
(mfprs <- 1-(model.full$deviance/model.full$null.deviance)) #34% variance in dependent variable is capture by independet vatiable

# To get odds ratio of predictors
exp(coef(model.full))

# Multicollinearity of full model
library(car)
vif(model.full)

#Confusion Matrix (TP FP, TN FN)
predict <- predict(model.full, type="response")
summary(predict)
  #prediction to binary variable
predicted.fm <- as.numeric(ifelse(predict>0.5,1,0))
(cm <- table(predicted.fm,data$Survived))

#Find accuracy, error , sensitivity/fnr and specificity/fpr

(accuracy <- sum(diag(cm))/sum(cm))
(error <- 1- accuracy)

(sensitivity <- cm[1,1]/(cm[1,1]+cm[2,1]))
(FNR <- 1-sensitivity)  #False Negative

(specificity <- cm[2,2]/(cm[2,1]+cm[2,2]))   # Not survived in both actual and observation 
(FPR <- 1-specificity)  #False Positive

#Instead Use caret package
library(caret)
predicted <- factor(ifelse(predict>0.5,1,0))
reference <- factor(data$Survived)
confusionMatrix(predicted,reference)


# ROC Curve with True positive and False positive
install.packages("ROCR")
library(ROCR)

ROCRpred <- prediction(predict,data$Survived)
ROCRpref <- performance(ROCRpred,'tpr','fpr')
plot(ROCRpref, colorize =T,text.adj=c(-0.2,1.7))


#ROC curve to find Area Under Curve (AUC)
install.packages("pROC")
library(pROC)

predicted <- as.numeric(predicted)
roc1 <- roc(reference,predicted)    #Area under the curve: 0.7834 : Model accuracy
print(roc1)
plot(roc1)

##############################
# Naiye Bayes
install.packages("e1071")
library(e1071)


ind <- sample(2,nrow(data),replace=T,prob=c(0.7,0.3))
train <- data[ind==1,]
test <- data[ind==2,]
set.seed(13)

#Fitting model
model.nb <- naiveBayes(Survived ~., data=train)
#Checking model
model.nb


# Naive Bayes classifier for discrete predictors


# Predicting on test data
y_pred <- predict(model.nb,newdata = test)


#Confision matrix
cm <- table(test$Survived,y_pred)
cm

library(caret)
confusionMatrix(cm)

##################################
# SVM using kernel linear
model.svm = svm(formula = Survived ~.,
                data=train,
                type ='C-classification',
                kernel='linear')

#check the model
model.svm   #Support Vector: 283

#predicting on test data
y_pred.svm <- predict(model.svm, newdata = test)
#confusion matrix
cm.svm <- table(y_pred.svm,test$Survived)
cm.svm

#Using caret
confusionMatrix(cm.svm)

#######################################
#Decicion tree
getwd()
library(readr)
ctg <- read_csv("Cardiotocographic.csv")
str(ctg)
View(ctg)

#NSP as dependent variable
#Change NSP as factor variable (3 variable)
ctg$NSPF <- factor(ctg$NSP)
str(ctg$NSPF)

set.seed(1234)
ind <- sample(2,nrow(ctg),replace=T,prob=c(0.8,0.2))
train <- ctg[ind==1,]
test <- ctg[ind==2,]

#Fit decision tree
install.packages("party")
library(party)
tree <- ctree(NSPF~LB+AC+FM,data=train)

.
.
.
.
.

# limitation of decision tree is high variance betwwen test and train data
# SO use ensemble learning like bagging

# Bagging
install.packages("ipred")
library(ipred)

MBTree <- bagging(NSPF~LB+AC+FM,data=train,coob=T)
print(MBTree)

#prediction
MBPredict1 <- predict(MBTree, test)
MBPredict1

#Confusion matrix and accuracy
library(caret)
confusionMatrix(MBPredict1,test$NSPF)

##############################
#Random Forest
install.packages("randomForest")
library(randomForest)

set.seed(222)

#fitting random forest model
rfm <- randomForest(NSPF~LB+AC+FM, data=train)
print(rfm)
plot(rfm)

#Using tuneRF to tune th random forest
rfm1 <- randomForest(NSPF~LB+AC+FM, data=train,
                     ntree =300,
                     mtry=4,
                     importance =T,
                      proximity=T)
print(rfm1)
plot(rfm1)

# Boosting