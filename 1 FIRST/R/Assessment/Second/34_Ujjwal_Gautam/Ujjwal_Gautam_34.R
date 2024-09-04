
# QN 9
install.packages("twitteR")
library(twitteR)
library(stats)

## Question a
city_distances <- matrix(c(
  0, 587, 1212, 701, 1936, 604, 748, 2139, 2182, 543,
  587, 0, 920, 940, 1745, 1188, 713, 1858, 1737, 597,
  1212, 920, 0, 879, 831, 1726, 1611, 1949, 2204, 1494,
  701, 940, 879, 0, 1374, 968, 1420, 1645, 1891, 1220,
  1936, 1745, 831, 1374, 0, 2339, 2451, 347, 2734, 2300,
  604, 1188, 1726, 968, 2339, 0, 1092, 2594, 2408, 923,
  748, 713, 1611, 1420, 2451, 1092, 0, 2571, 678, 205,
  2139, 1858, 1949, 1645, 347, 2594, 2571, 0, 678, 2442,
  2182, 1737, 2204, 1891, 2734, 2408, 678, 678, 0, 2329,
  543, 597, 1494, 1220, 2300, 923, 205, 2442, 2329, 0
), nrow = 10, byrow = TRUE)
# Creating  a distance matrix from the given data in the problem

city_names <- c("Atlanta", "Chicago", "Denver", "Houston", "Los Angeles", "Miami", "New York", "San Francisco", "Seattle", "Washington D.C.")
rownames(city_distances) <- city_names
colnames(city_distances) <- city_names

# Assigning names to row and columns as per question

city_dissimilarity <- as.dist(city_distances)
head(city_dissimilarity)
# Convert to a dissimilarity object to find distance

## Question b
mds_model <- cmdscale(city_dissimilarity, eig = TRUE, k = 2)
# Fitting  the  MDS model using city.dissimilarity object


## Question c
mds_coords <- mds_model$points
print(mds_coords)
# the above points gives the coordinate for each city in two dimension
# the points are in such a way that it preserves the distance between cities



## Question d
plot(mds_coords, type = "n")
text(mds_coords, labels = city_names, cex = 0.7)
title("Classical MDS of US Cities")
# Bi-plot of the model
# the plot shows the cities with given coordinate
# the coordinates are replaced with cities name




# QN 10



install.packages("ClusterR")
install.packages("cluster")
library(ClusterR)
library(cluster)
head(iris)
table(iris$Species)
iris_1<-iris[,-5]
sum(is.na(iris_1))
set.seed(34)
# observing the data set

## a

kmeans.c2<-kmeans(iris_1,centers = 2,nstart = 20)
kmeans.c2
# k mean clustering with two clusters
# it forms two clusters of sizes 53, 97

kmeans.c3<-kmeans(iris_1,centers = 3,nstart = 20)
kmeans.c3
# k mean clustering with three clusters
# it forms two clusters of sizes 50, 62, 38


## b
plot(iris_1[c("Sepal.Length", 
              "Sepal.Width")],
     col = kmeans.c3$cluster,
     main = "K-means with 3 
clusters")

# the plot for three clusters is formed
# each cluster is colored differently ie. black, red and green
# in plot some of the green and red are seen mixed which means points are not well clustered
# for better visualization sepal length and sepal width are considered for plotting


## c

kmeans.c3$centers
kmeans.c3$centers[, 
                   c("Sepal.Length", "Sepal.Width")]
plot(iris_1[c("Sepal.Length", 
              "Sepal.Width")],
     col = kmeans.c3$cluster,
     main = "K-means with 3 
clusters")

points(kmeans.c3$centers[, 
                          c("Sepal.Length", "Sepal.Width")],col = 1:3, pch= 8, cex= 3)

# the center of clusters with respect to sepal length and sepal width is found 
# the center is plotted with plot () function
# the center gives mean of each cluster

## d

cm<-table(iris$Species,kmeans.c3$cluster)
cm

(accuracy<-
    sum(diag(cm))/sum(cm))

# three clusters were compared using confusion matrix
# the cm gives that 50 of setosa , 48 of versicolor and 36 of virginica were clustered correctly
# 14 of virginica and 2 of versicolr are predicted incorrectly
# using confusion matrix accuracy was found to be 89.33 %




# QN 8

library(car)
head(Arrests)
str(Arrests)
dim(Arrests)
data<-Arrests
data<-data[,-3]
data<-data[,-7]
head(data)

# removing 3rd and 4 th column from data

## a
ind <- sample(2, nrow(data), 
              replace=T, prob = c(0.8, 0.2))
train <- data[ind==1,]
test <- data[ind==2,]

# splitting data for train and test in ratio 80 nad 20

## b
library(e1071)
set.seed(34)
model_lr<-glm(released~.,data=train,family = binomial)

# fitting logistic binomial regression using glm() function

model.nb<-naiveBayes(released~.,data=train)
# fitting naive bayes using naiveBayes() function


## c

predict<-predict(model_lr,newdata=test,type="response")
summary(predict)
head(predict)
# prediting test data on model
# predict is continuous but we need in 0 and 1



predict_lr<-as.numeric((ifelse(predict>0.5,1,0)))
summary(predict_lr)
head(predict_lr)
# prediction to binary variable


pred_naive<-predict(model.nb,newdata=test)
head(pred_naive)
# predicting 20% of test data using naive bayes model

## d
cm_lr<-table(test$released,predict_lr)
cm_lr

(accuracy_lr<-sum(diag(cm_lr)/sum(cm_lr)))

# finding confusion matrix of predicted values using logistic regression
# finding accuracy of prediction
# accuracy was found to be 17.08%

cm_nv<-table(test$released,pred_naive)
cm_nv

(accuracy_nv<-sum(diag(cm_nv)/sum(cm_nv)))

# finding confusion matrix of predicted values using naive bayes
# finding accuracy of prediction
# accuracy was found to be 82.72%

# In conclusion naive classification model is better for this model as it gives higher accuracy of 82.72%.
