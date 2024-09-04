# Dividing Arrests data into train and test
library(car)
arrestsData <- Arrests

arrestsData$checks <- as.factor(arrestsData$checks)
arrestsData$sex <- as.factor(arrestsData$sex)
arrestsData$citizen <- as.factor(arrestsData$citizen)
arrestsData$employed <- as.factor(arrestsData$employed)
arrestsData$released <- as.factor(arrestsData$released)

arrestsData

set.seed(5)
ind <- sample(2, nrow(Arrests), replace = T, prob = c(0.8, 0.2))
#Data partition
arrests.traindata <- arrestsData[ind==1,]
arrests.testdata <- arrestsData[ind==2,]

# Fitting logistic Regression
logicmodel.full <- glm(released ~.,data=arrests.traindata, family = binomial)
summary(logicmodel.full)


# Fitting Bayes classification
library(e1071)
baymodel.full <- naiveBayes(released~.,data=arrests.traindata)

baymodel.full

# Prediction

logpred <- predict(logicmodel.full, newdata = arrests.testdata[,-1])
baypred <- predict(baymodel.full, newdata = arrests.testdata[,-1])

logcm <- table(arrests.testdata$released,logpred)

baycm <- table(arrests.testdata$released,baypred)

#Sensitivity, Specificity, Accuracy for logistic
(accuracy <- sum(diag(logcm))/sum(logcm))
(sensitivity <- logcm[1,1]/(logcm[1,1]+logcm[2,1]))
(FNR <- 1 - sensitivity)
(specificity <- logcm[2,2]/(logcm[1,2]+logcm[2,2]))
(FPR <- 1 - specificity)


#Sensitivity, Specificity, Accuracy for bayesian
(accuracy <- sum(diag(baycm))/sum(baycm))
(sensitivity <- baycm[1,1]/(baycm[1,1]+baycm[2,1]))
(FNR <- 1 - sensitivity)
(specificity <- baycm[2,2]/(baycm[1,2]+baycm[2,2]))
(FPR <- 1 - specificity)


# Comparing

# Bayesian fitting clearly  better as it has highter accuracy.
