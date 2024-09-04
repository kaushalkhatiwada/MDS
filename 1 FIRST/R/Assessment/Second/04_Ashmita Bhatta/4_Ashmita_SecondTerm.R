#----------------------------Q6--------------------------------
library(ggplot2)
set.seed(4)
dataset <- c(c(10:99), c(factor(male,female)), c(factor(noeducation, primary, secondary, Beyound secondary)),
             c(factor(low, middle, high)), c(14:38), rnorm = 200)
colnames <- c("Age", "Sex", "education levels", "socio-economic status", "body mass index")


#---------------------------------Q7------------------
data("airquality")
str(airquality)
table(airquality$Temp)

d<- factor(airquality$Temp)
leveneTest(Temp~d, data = airquality)

summary(aov(Temp~d, data = airquality))

shapiro_results <- by(airquality$Temp, airquality$Month, shapiro.test)
shapiro_results
#Interpretation: The Shapiro-Wilk test assesses whether the data within each month's group 
#follows a normal distribution. A p-value greater than the chosen significance level (commonly 0.05)
#indicates that the data follows normal distribution, leading to rejection of the null hypothesis of normality.

library(lawstat)
library(car)

# Perform the one-way ANOVA
anova_model <- aov(Temp ~ Month, data = airquality)

# Print ANOVA table
summary(anova_model)

#Interpretation: The ANOVA table provides information on the significance of 
#the Month variable in explaining the variation in the Temp variable. 
#The p-value associated with the Month variable indicates whether there are 
#significant differences Temp and month data.

#------------------Q8------------------------
library(car)
data("Arrests")
str(Arrests)
head(Arrests)

ind <- sample(2, nrow(Arrests), replace = T, prob = c(0.8,0.2))

train.data <- Arrests[ind ==1, ]
test.data <- Arrests[ind == 2, ]

library(lawstat)
# Fit Naive Bayes model
naive_bayes_model <- naiveBayes(released ~ .,
                                data = train.data)

# Fit Support Vector Machine (SVM) model
svm_model <- svm(released ~ .,
                 data = train.data)





#-----------------Q9--------------------------
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

# Assign row and column names
city_names <- c("Atlanta", "Chicago", "Denver", "Houston", "Los Angeles", "Miami",
                "New York", "San Francisco", "Seattle", "Washington D.C.")
rownames(city_distances) <- city_names
colnames(city_distances) <- city_names


city.dissimilarity <- as.dist(city_distances)

# Fit the classical MDS model
mds_model <- cmdscale(city.dissimilarity, eig = TRUE, k = 2)

mds_coords <- mds_model$points
print(mds_coords)
summary(mds_model)
#Interpretation : We can interpret that the mds_model dataset has the dissimilarity of different cities.

plot(mds_coords, type = "n")
text(mds_coords, labels = city_names, cex = 0.7)
title("Classical MDS of US Cities")
#Interpretation : It shows the distance of the cities with dissimilarities.

#----------------Q10--------------------------
library(cluster)
library(ClusterR)

iris <- read.csv("iris.csv")
str(iris)
iris1 <- iris[, -1]
str(iris1)
iris2 <- iris1[, -5]

set.seed(4)
km2 <- kmeans(iris2, 2, nstart = 20)
km3 <- kmeans(iris2, 3, nstart = 20)
km3$cluster

plot(iris2, col = (km3$cluster + 1), main = "k-means clustering using k = 3",
     pch = 20, cex = 2)

kmeans3 <- kmeans(iris2, centers = 3, nstart = 20)

plot(iris2, kmeans3, main = "K-means clustering with center k=3", 
     pch = 20, cex = 2)

iris1$Species
cm <- table(iris1$Species, kmeans3$cluster)
cm
#Interpretation : The confusion matrix cm gives the matrix of the species of iris fliwer with
#the gropuing of 3 clusters in respect to how many times it was repeated in the column. 
#This means that the speecies of iris when divided into 3 clusters will give the respective confusion matrix.

