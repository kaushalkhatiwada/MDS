
# Roll Number: 1, 5, 9, 13, 17, 21, 29, 33 
#(Generate 200 random data with one continuous dependent variable and five independent variables, random seed = your roll number. 

set.seed(13)
A<-rnorm(200)
B<-rnorm(200)
C<-rnorm(200)
D<-rnorm(200)
E<-rnorm(200)
K <- A+ 0.2*B+ 0.3*C+ 0.4*D+ 0.5*E+ rnorm(200)  # Dependent Variable
data <- data.frame(K,A, B,C, D, E)

# Split data into train and test
ind <- sample(2, nrow(data), replace = T, prob = c(0.7, 0.3))
train.data <- data[ind==1,]
test.data <- data[ind==2,]

# Bivariate
lmA <- lm(K~A,data=data)
lmB <- lm(K~B,data=data)
lmC <- lm(K~C,data=data)
lmD <- lm(K~D,data=data)
lmE <- lm(K~E,data=data)

#Multivariate
multi <- lm(K ~ .,data=data)


####################################################
######## VIF [Variance Inflation Factor] TEST ########
vif(multi)
#VIF < 10 so,no multicollinearity

######## BLUE [Best, Linear, Unbiased, Estimate] TEST #######

## 1 ## NORMALITY TEST FOR DEPENDENT VARIABLE ###
shapiro.test(data$K)  
# Normality Test p-value>0.05, so dependent variable is normal distribution assumption 1 passed

## 2 ## LINEARITY TEST BETWEEN DEPENDENT AND INDEPENDENT VARIABLE USING CORRELATION TEST###
plot(data$K,data$A)
corA <- cor.test(data$K,data$A,method = "pearson")
corB <- cor.test(data$K,data$B,method = "pearson")
corC <- cor.test(data$K,data$C,method = "pearson")
corD <- cor.test(data$K,data$D,method = "pearson")
corE <- cor.test(data$K,data$E,method = "pearson")

correlation <- data.frame(corA$estimate,corB$estimate,corC$estimate,corD$estimate,corE$estimate)
## 2 ## LINEARITY TEST BETWEEN DEPENDENT AND INDEPENDENT VARIABLE USING CORRELATION TEST###
correlation
# -1 indicates a perfectly negative linear correlation between two variables
# 0 indicates no linear correlation between two variables
# 1 indicates a perfectly positive linear correlation between two variables
# So, Coefficient of correlation are positively correlated.

## 3 ## COEFFICIENT OF DETERMINATION (R^2) ###

summary(lmA)
summary(lmB)
summary(lmC)
summary(lmD)
summary(lmE)

summary(multi)
# 0	= Model does not predict the outcome.
# Between 0 and 1	= Model partially predicts the outcome.
# 1	= Model perfectly predicts the outcome.
# So, R^2 is between 0 and 1 therefore the model perfectly predicts the outcome

## 4 ## REGRESSION ANOVA ###
summary(aov(K~.,data=data))

# DF - Degree of Freedom
# Pr(>F) - P-value


## 5 ## SIGNIFICANCE OF A REGRESSION SLOPE ###



# NOW CONDITION FOR BLUE [Best, Linear, Unbiased, Estimate] ESTIMATE IS FULFILLED !!!!
######## LINE [Linear, Independence, Normal, Equal variance] TEST #######

# Linearity
plot(multi,which=1,col=("blue"))
summary(multi$residuals) # If Mean is 0 then residuals are linear 

# Independence
acf(multi$residuals)
library(car)
 # Calculate Durbin-Watson Test of residuals, If p-value > 0.05, no auto correlation
durbinWatsonTest(multi)

# Normal
plot(multi,which=2,col=c("blue"))
# Get Shapiro-Wilk testof residuals, If p-value > 0.05, follow normal distribution
shapiro.test(multi$residuals)  

# Equal variance
plot(multi,which=3,col=c("blue"))
library(lmtest)
# Get Breush-pagan test of residuals, If p-value > 0.05, residual variable are equal (homoscedasticity)
bptest(multi)     

# NOW CONDITION FOR LINE ARE VALID, WE CAN PREDICT




# predict for the test data (30% sample)
linearmodel <- predict(multi,newdata = test.data)


r2 <- R2(linearmodel, test.data$K)
rmse <- RMSE(linearmodel, test.data$K)

#  compare it with KNN regression, ANN regression and Support Vector Regression using R-square and RMSE of test data and 
library(caret) 
### KNN - K Nearest Neighbor Regression ###
#Training data scaling
train_x = train.data[,-1]
train_x = scale(train_x)[,]                                                 #standardizes each column of the data set (subtracting the mean and dividing by the standard deviation)
train_y = train.data[,1]

#Test(validation) data scaling
test_x <- test.data[,-1]
test_x <- scale(test.data[,-1])[,]
test_y <- test.data[,1]


knnmodel = knnreg(train_x,train_y)
pred_y=predict(knnmodel,data.frame(test_x))
mse = mean((test_y-pred_y)^2)
mae = caret::MAE(test_y,pred_y)
rmse = caret::RMSE(test_y,pred_y)
cat("MSE: ", mse,
    "MAE: ", mae, 
    "RMSE: ", rmse)


#Plot
x = 1:length(test_y)
plot(x, test_y, 
     col = "red", 
     type = "l", 
     lwd=2
     )
lines(x, pred_y, 
      col = "blue", 
      lwd=2)
legend("topright", 
       legend = c("original", "predicted"), 
       fill = c("red", "blue"), 
       col = 2:3, 
       adj = c(0, 0.6))
grid()


################## ANN ##################
library(neuralnet)
SN<- seq(from=1, to =200)
data<- cbind(data,SN)
##NN Model
n <- neuralnet(K ~ SN,
               data=data ,
               hidden =1, linear.output=F)
plot(n)

n1 <- neuralnet(K ~ SN,
                data=data ,
                hidden =c(3,2),   # hidden layer 3 and 2 neurons
                linear.output=F)
plot(n1)

################## SVR ##################
library(e1071)
svreg <- svm(formula=K~.,
             data=train.data,
             type="eps-regression",
             kernel="linear")
K_predict <- predict(svreg,newdata = train.data)
mse = mean((test_y- K_predict)^2)
mae = caret::MAE(test_y,K_predict)
rmse = caret::RMSE(test_y,K_predict)
cat("MSE: ", mse,
    "MAE: ", mae, 
    "RMSE: ", rmse)


plot(data)
points(train.data$K,K_predict, col="red",pch=16)




# find the best supervised regression model for this data.

