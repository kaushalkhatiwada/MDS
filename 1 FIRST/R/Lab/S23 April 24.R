# Supervised Learning with Regression Model
#A) Polynomial Regression
        #Quadratic Linear model [2]
        #Cubic Linear model  [3]
        #Double quadratic Linear model [4]
        #Fifth order polynomial fit  [5]
#B) K Nearest neighbor
#C) Support Vector Machine Regression
#D) Decision Tree Regression
#C) Neural Network (NN) Regression or Artificial Neural Networks(ANN)
#===================================================================

#KNN
library(MASS)

#Define data
boston = MASS::Boston
str(boston)

#Data partition
set.seed(123)
ind <- sample(2,nrow(boston),replace = T,prob=c(0.8,0.2))
train.data <- boston[ind==1,]
test.data <- boston[ind==2,]

#Training data scaling(must for KNN)
train_x = train.data[,-14]
train_x = scale(train_x)[,] #standardizes each column of the data set (subtracting the mean and dividing by the standard deviation)
train_y = train.data[,14]

#Test(validation) data scaling(must for KNN)
test_x <- test.data[,-14]
test_x <- scale(test.data[,-14])[,]
test_y <- test.data[,14]


## KNN regression model
knnmodel = knnreg(train_x,train_y)
str(knnmodel)

pred_y=predict(knnmodel,data.frame(test_x))
print(data.frame(test_y,pred_y))


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
     lwd=2,
     main = "Boston housing test data prediction")
lines(x, pred_y, 
      col = "blue", 
      lwd=2)
legend("topright", 
       legend = c("original- medv", "predicted-medv"), 
       fill = c("red", "blue"), 
       col = 2:3, 
       adj = c(0, 0.6))
grid()

#########################33
#Neural Network 
# ANN
# Single layer, feed-forward neural network
install.packages("neuralnet")
library(neuralnet)
plot.data<- read.csv("covnep_252days.csv")
SN<- seq(from=1, to =252)
plot.data<- cbind(plot.data,SN)
##NN Model
n <- neuralnet(totalDeaths ~ SN,
               data=plot.data ,
               hidden =1, linear.output=F)
plot(n)

n1 <- neuralnet(totalDeaths ~ SN,
               data=plot.data ,
               hidden =c(3,2),   # hidden layer 3 and 2 neurons
               linear.output=F)
plot(n1)
###########################
# Decision Tree
install.packages("rpart")
library(rpart)
library(caret)

dt = rpart(medv ~., data=boston)
set.seed(13)
train.dt <- train(medv ~.,
                  data = boston,
                  method = "rpart2")
train.dt
plot(train.dt)
