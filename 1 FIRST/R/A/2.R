
# Our Second assessment
# question number 6 (Graph and plot)
#-------KK-----------

library(ggplot2)
set.seed(13)

# A) Generate data
age <- sample(10:99, 200, replace = TRUE)
sex <- sample(c("Male", "Female"), 200, replace = TRUE)
education <- sample(c("No education", "Primary", "Secondary", "Beyond secondary"), 200, replace = TRUE)
socioeconomic_status <- sample(c("Low", "Middle", "High"), 200, replace = TRUE)
bmi <- sample(14:38, 200, replace = TRUE)

# B) scatter plot of age and body mass index
ggplot(data = data.frame(age, bmi), aes(x = age, y = bmi)) +
  geom_point() +
  labs(x = "Age", y = "BMI", title = "Relationship between Age and BMI")
## Interpret: No trend is seen from the data that means the data is well spread

# C) Pie chart 
bmi_class <- cut(bmi, breaks = c(0, 18, 24, 30, Inf), labels = c("<18", "18-24", "25-30", "30+"))
ggplot(data.frame(bmi_class), aes(x = "", fill = bmi_class)) +
  geom_bar(width = 1) +
  coord_polar("y", start = 0) +
  labs(title = "Distribution of BMI Classes") +
  theme_void() +
  theme(legend.position = "right")
## From the pie chart we can see the maximum part of the data is covered by group 25-30 and 30+ 
#and minimum part of the data is from <18 

# D) histogram of age
ggplot(data.frame(age), aes(x = age)) +
  geom_histogram(binwidth = 15, fill = "steelblue", color = "white") +
  labs(x = "Age", y = "Count", title = "Distribution of Age") +
  theme_classic()
#From above plot we can see that all the data has similar frequency except highest one


# question number 7 (Goodness-of-fit test)
#------KK--(No good)----------
library(dplyr)
data <- airquality
data$Month <- as.factor(data$Month)

# A) Goodness-of-fit test on temp to check normal distribution 
# Check sample size per month
per_month_count <- data %>% group_by(Month) %>% summarize(count = n())
per_month_count
# Perform Shapiro-Wilk test for normality within each month
result <- tapply(data$Temp, data$Month, shapiro.test)
print(result)
## The data follows a normal distribution within each month as p value is greater than 0.05.

## B)	Perform goodness-of-fit test on Temp variable by Month variable to check if 
#the variances of mpg are equal or not on am variable categories
airquality$Month <- factor(airquality$Month)
bartlett_result <- bartlett.test(Temp ~ Month, data = airquality)
print(bartlett_result)

## c) 	Discuss which independent sample test must be used to compare “Temp” variable by “Month” 
#variable categories based on the results obtained above.
#ANS:-
#Bartlett’s test in the above case suggests that the “Temp” variable’s variances
#are roughly equal between months. Consequently, the conventional 
#one-way ANOVA is appropriate.

 ## D) perform the best independent sample statistical test for this data now and interpret the result carefully.
data("airquality")
anova_model <- aov(Temp ~ Month, data = airquality)
summary(anova_model)
airquality$Month <- factor(airquality$Month)
anova_model <- aov(Temp ~ Month, data = airquality)
tukey_result <- TukeyHSD(anova_model)
print(tukey_result)
# here we can see relationship between temp and month of (6-5),(7-5),(8-5),(9-5) are less significant
#as compared to month of (9-6),(8-7).

# question number 7 (Goodness-of-fit test)
#--------SHYAM----------
library(car)
library(ggplot2)

# Load the airquality dataset
data("airquality")

# a. Perform Shapiro-Wilk test for normality on Temp variable
shapiro_test <- shapiro.test(airquality$Temp)
print(shapiro_test)

# Visualize the distribution of Temp with a Q-Q plot
qqnorm(airquality$Temp)
qqline(airquality$Temp, col = "red")

# b. Perform Levene's Test to check for equal variances across months
levene_test <- leveneTest(Temp ~ factor(Month), data = airquality)
print(levene_test)

# c. Discussing the Independent Sample Test to Compare Temp by Month
# If variances are equal, use standard ANOVA; if not, use Welch's ANOVA

# d. Perform the best independent sample statistical test
# Set seed for reproducibility
set.seed(13)

# Check the result of Levene's test to decide the appropriate ANOVA test
if (levene_test$p.value < 0.05) {
  # Variances are not equal, use Welch's ANOVA
  anova_test <- oneway.test(Temp ~ factor(Month), data = airquality, var.equal = FALSE)
  test_type <- "Welch's ANOVA"
} else {
  # Variances are equal, use standard ANOVA
  anova_test <- aov(Temp ~ factor(Month), data = airquality)
  test_type <- "Standard ANOVA"
}

# Output the result of the ANOVA test
print(anova_test)
cat("Test performed:", test_type, "\n")


# # question number 7 (Goodness of fit test and independent sample test)
----------------UU---------------------------
  
data<-airquality
head(data)

# a) Goodness-of-fit test for normal distributution
##### suggestive plot for normal distribution
qqnorm(data$Temp)
qqline(data$Temp)
# from the q-q plot we can see many data points are in qqline so the data set seem to be normally distributed.
hist(data$Temp)
# histogram shows that the data seem to be normally distributed although not perfect.
str(data)
##### conformative test
# ks_test_result <- ks.test(data$BMI, "pnorm", mean = mean(data$BMI), sd = sd(data$BMI))
# ks test if n>100
ks_test_result <- ks.test(data$Temp, "pnorm",mean = mean(data$Temp), sd = sd(data$Temp))
ks_test_result
# if p value is greater than 0.05 it follows normal distribution.

# b) Goodness-of-fit test for variance 
# for equality of variance
library(car)
library(ggplot2)
head(data)
str(data)

#Suggestive plot
ggplot(data=data,mapping=aes(y=factor(Month),x=Temp))+
  geom_boxplot()
boxplot(Temp ~ Month, data = data, main = "Temp by Month")
# since the length of whiskers of the boxplot are not same the variance of Temp  with Month donot seem to be equal.

# Conformitary test
data$Month=as.factor(data$Month)
data$Temp=as.numeric(data$Temp)
(leveneTest(Temp ~Month, data = data))
str(data)
# since the value of Pr is less than 0.05 the variance of Temp across month is not equal.

# c) Which independent sample statistical test is used?
# if Pr(>F) is less than 0.05 for more than two groups we use welch_anova
# if Pr(>F) is greater than 0.05 for more than two groups we use standard one way anova

# d) Perform best independent statistical test 
(welch_anova <- oneway.test(data$Temp~factor(data$Month), var.equal = FALSE))
# since p value is less than 0.05 means of Temp across month are not equal.

# if Pr(>F) is greater than 0.05 for more than two groups we use standard one way anova
welch_anova <- oneway.test(aq$Temp~factor(aq$Month), var.equal = TRUE)
welch_anova

(anova_model <- aov(Temp ~ Month, data = data))

# Apply TukeyHSD to the ANOVA model
tukey_result <- TukeyHSD(anova_model)
print(tukey_result)
# the pairs in  which p value is less than 0.05 ie. 6-5 has difference in mean temperature.
# the pairs in  which p value is less than 0.05 ie. 8-7 has no difference in mean temperature.




# question number 8 (supervised logistic regression and naive bayes classification)
#------KK--(No comparision done)----------
library(car)
arrest <- Arrests

# A) 80:20 split

arrest$year <- as.factor(arrest$year)
arrest$age <- as.factor(arrest$age)
arrest$checks <- as.factor(arrest$checks)
set.seed(13)
ind <- sample(2,nrow(arrest), replace = T, prob = c(0.8,0.2))
arrest.train <- arrest[ind==1,]
arrest.test <- arrest[ind==2,]

# B) fit logistic regression and naive bayes classification 
model.lr <- glm(released ~ colour+age+sex+employed+citizen  , data = arrest.train, family = binomial)

library(e1071)
model.nb <- naiveBayes(released ~ colour+age+sex+employed+citizen, data = arrest.train)

# C) predict on test data
predict<-predict(model.lr,newdata =arrest.test,type="response")
predict.lr<-as.factor((ifelse(predict>0.5,1,0)))

# D) compare and decide which is better


# question number 8 (supervised logistic regression and naive bayes classification)
#------SHYAM------------
# a. Divide the Arrests data into train and test datasets with 80:20 random splits
# b. Fit a supervised logistic regression and naive bayes classification models on train data with "released" as dependent variable and colour, age, sex, employed and citizen as independent variable
# c. Predict the released variable in the test datasets of these models and interpret the result carefully
# d. Compare and decide the which classification model is better for this data

# Load necessary libraries
library(carData)
library(dplyr)
library(caret)
library(e1071)

# Load the Arrests data set
data("Arrests")

# Set seed for reproducibility
set.seed(13)

# A) Split the data into training (80%) and testing (20%) sets
train_index <- createDataPartition(Arrests$released, p = 0.8, list = FALSE)
train_data <- Arrests[train_index, ]
test_data <- Arrests[-train_index, ]

#B)
# Fit a logistic regression model
logistic_model <- glm(released ~ colour + age + sex + employed + citizen, data = train_data, family = binomial)
# Fit a Naive Bayes model
nb_model <- naiveBayes(released ~ colour + age + sex + employed + citizen, data = train_data)

#C)
# Predict using the logistic regression model
test_pred_logistic <- predict(logistic_model, newdata = test_data, type = "response")
test_pred_logistic_class <- ifelse(test_pred_logistic > 0.5, "Yes", "No")

#D) Compare and decide which classification is best
# Confusion matrix and accuracy for logistic regression
confusion_logistic <- table(test_data$released, test_pred_logistic_class)
accuracy_logistic <- sum(diag(confusion_logistic)) / sum(confusion_logistic)

# Predict using the Naive Bayes model
test_pred_nb <- predict(nb_model, newdata = test_data)

# Confusion matrix and accuracy for Naive Bayes
confusion_nb <- table(test_data$released, test_pred_nb)
accuracy_nb <- sum(diag(confusion_nb)) / sum(confusion_nb)

# Output the results
cat("Confusion Matrix for Logistic Regression:\n")
print(confusion_logistic)

cat("Confusion Matrix for Naive Bayes:\n")
print(confusion_nb)

cat("Accuracy of Logistic Regression:", accuracy_logistic, "\n")
cat("Accuracy of Naive Bayes:", accuracy_nb, "\n")

if (accuracy_logistic > accuracy_nb) {
  cat("Logistic Regression is the better model for this data.\n")
} else {
  cat("Naive Bayes is the better model for this data.\n")
}



# question number 8 (supervised logistic regression and naive bayes classification)
#------NISHAN------------
library(car)
library(e1071)
# a
data <- Arrests
ind <- sample(2, nrow(data), 
              replace = T, prob = c(0.8, 0.2))
train <- data[ind==1,]
test <- data[ind==2,]
#data is divided in 80-20 portion

# b
# For the logistic regression model
logistic_model <- glm(released ~ ., data = train, family = "binomial")

# For the Naive Bayes model
nb_model <- naiveBayes(released ~ ., data = train)

# c
# to get  predictions.
logistic_pred <- predict(logistic_model, newdata = test, type = "response")
nb_pred <- predict(nb_model, newdata = test)

logistic_pred_class <- ifelse(logistic_pred > 0.5, 1, 0)
logistic_conf_matrix <- table(Predicted = logistic_pred_class, Actual = test$released)
logistic_conf_matrix
logistic_accuracy <- sum(diag(logistic_conf_matrix)) / sum(logistic_conf_matrix)
print(paste("Logistic Regression Accuracy:", logistic_accuracy))

# True Negatives (TN): 9
# in this case actual result is no and our model predect no
# False Negatives (FN): 3
# in this case actual result is yes and our model predect no
# False Positives (FP): 176
# in this case actual result is yes and our model predect no.
# True Positives (TP): 837
# in this case actual result is yes and our model predect yes
#it has 83% accuracy

nb_conf_matrix <- table(Predicted = nb_pred, Actual = test$release)
nb_conf_matrix
nb_accuracy <- sum(diag(nb_conf_matrix)) / sum(nb_conf_matrix)
print(paste("Naive Bayes Accuracy:", nb_accuracy))

# True Negatives (TN): 27
# in this case actual result is no and our model predect no
# False Negatives (FN): 32
# in this case actual result is yes and our model predect no
# False Positives (FP): 158
# in this case actual result is yes and our model predect no.
# True Positives (TP): 808
# in this case actual result is yes and our model predect yes
# accuracy of the naive bayes is 81%
# d
# from their accuracy we can say that logistic regression is best because it gives 83% accuracy


# question number 9 (PCA using kaiser's and using VARIMAX rotation)
#--------UU----------
# a) Flower scale using Principle component analysis
flower_scale<- iris[,-5]
head(flower_scale)
pr.out <- prcomp(flower_scale, scale = TRUE)

#b) compute eigen value and interpret PCA using kaiser's
pr.out
std_devs <- pr.out$sdev
std_devs
eigenvalues <- std_devs^2
eigenvalues
# SD of PC1...PC4 are 1.7083611 0.9560494 0.3830886 0.1439265
# eigenvalues of PC1...PC4 are are 2.91849782 0.91403047 0.14675688 0.02071484 which is square of SD
# according to kaisers rule we consider principal components with eigenvalues greater than 1 ie. PC1

# c) Cree plot
# Load necessary library
library(ggplot2)
# Create a data frame for plotting
plot(eigenvalues,type='o',xlab="Principal components")
abline(h=1,col="red")
abline(v=1,col="green")
# since the eigen value of PC1 is only grater than 1 as required by kaisers rule ...the PC1 is the component that describes the 
# which describes  maximum variance among all other components.

# d) Revise th flower scale with 3 components using VARIMAX rotation
library(FactoMineR)
pca.1 <- PCA(flower_scale, scale = TRUE, ncp = 3, graph = FALSE)
varimax_rot <- varimax(pca.1$ind$coord[,1:3])
varimax_rot
pr.out1 <- prcomp(varimax_rot$loadings, scale = TRUE)
pr.out1
std_devs1 <- pr.out1$sdev
std_devs1
eigenvalues1 <- std_devs1^2
eigenvalues1
# even after varimax rotation only one component has eigen value greater than 1 so we consider only one component
# as kaisers rule.
# thus varimax rotation does the bring any new conclusion even after re scaling.


# biplot of PCA model
biplot(pr.out)
pr.out

title("Bi plot of PCA")

# Each point on the biplot represents an observation (data point) in the new coordinate system preserving orgonal data
# with x axis as PC1 and y axis as PC2.

# The arrows (vectors) represent the original variables. 
# The direction and length of the arrows indicate how each variable contributes 
# to the principal components.

# A longer arrow means that the variable has a stronger contribution to the principal component.
# All the arrows has almost similar length so their contribution seems to be equal.

# The angle between the arrows and the axes indicates the correlation between 
# the variable and the principal component.A smaller angle means a higher correlation.
# Petal.Length and Petal.Width has higher angle with PC2 so it has low correlation but has higher coorelation with PC1.
# 



# question number 9 OR (classical multi dimensational model)
#---------KK---------

library(stats)
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

# Assigning names to row and columns
city_names <- c("Atlanta", "Chicago", "Denver", "Houston", "Los Angeles", "Miami",
                "New York", "San Francisco", "Seattle", "Washington D.C.")
rownames(city_distances) <- city_names
colnames(city_distances) <- city_names

## A)
## Get dissimilarity distance as city.dissimilarity object
city.dissimilarity <- as.dist(city_distances)

## B)
## Fit the classical MDS model using city.dissimilarity object
mds.model <- cmdscale(city.dissimilarity, eig = TRUE, k = 2)  # Dimension 2


## C)
# Summary of model
mds.points <- mds.model$points
print(mds.points)
## Interpretation
# 

## D)
## Bi-plot of the model
plot(mds.points, type = "n")
text(mds.points, labels = city_names, cex = 0.7)

## Interpretation
#   


# question number 10 (Hierarchical clustering)
#-------UU-----------

head(iris)
ir_label <- iris$Species
ir_data <- iris[,-5]
head(ir_data)

#a) Using single linkage
# sd.data <- scale(ir_data)
data.dist <- dist(ir_data)
plot(hclust(data.dist,method = "single"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Single Linkage")

#b) Using complete linkage
plot(hclust(data.dist,method = "complete"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Complete Linkage")

#c) Using average linkage
plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

#d) Best hierarchical clustering model
# Best hierarchical model
plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

abline(h = 1.85, col = "red")

hc.out1 <- hclust(dist(ir_data),method = "single")
hc.out2 <- hclust(dist(ir_data),method = "complete")
hc.out3 <- hclust(dist(ir_data),method = "average")

hc.clusters1 <- cutree(hc.out1,3)
hc.clusters2 <- cutree(hc.out2,3)
hc.clusters3 <- cutree(hc.out3,3)


table(hc.clusters1, ir_label)
# virginica is incorrectly clustered as versicolor

table(hc.clusters2, ir_label)
# virginica is incorrectly clustered as versicolor

table(hc.clusters3, ir_label)
# only few of the virginica is incorrectly clustered as versicolor which is better than other methods.

plot(hc.out3, labels = ir_label,main = "Average Linkage (Best HCA model)")
abline(h = 1.85, col = "green")

# since the number of correctly represented data in dendrogram is formes in average method we prefer average method.



# question number 10 OR (k-mean clustering)
#-------SHYAM--(6)--------- 
#Use the first four variables of the "iris" data.

# Load necessary libraries
library(cluster)

# Load and prepare the data
data(iris)
iris_data <- iris[, -5] # Use the first four variables

# a. Fit a k-means cluster model in the data with k=2 and k=3
set.seed(30)
kmeans_2 <- kmeans(iris_data, centers = 2, nstart = 20)
kmeans_3 <- kmeans(iris_data, centers = 3, nstart = 20)

# Display k-means results for k=3
print(kmeans_3)

# b. Plot the clusters formed with k=3 in a single graph and interpret them carefully
plot(iris_data[c("Sepal.Length", "Sepal.Width")], col = kmeans_3$cluster, 
     main = "K-means with 3 clusters", xlab = "Sepal Length", ylab = "Sepal Width")


# Interpretation: Upon looking in the plot, there is three clusters where cluster 1(green) can be totally distinguished for the remaining. The cluster 2(red) and cluster 3(black) are somewhat overlapped.


# c. Add cluster centers for the plot of clusters formed with k=3 above and interpret it carefully
points(kmeans_3$centers[, c("Sepal.Length", "Sepal.Width")], col = 1:3, pch = 8, cex = 3)

# d. Compare the k=3 cluster variable with Species variable of iris data using confusion matrix and interpret the result carefully
# Add the clustering results to the original data
iris$Cluster <- as.factor(kmeans_3$cluster)

# Map clusters to species
species_levels <- levels(iris$Species)
cluster_to_species <- sapply(1:3, function(i) {
  most_common_species <- names(which.max(table(iris$Species[iris$Cluster == i])))
  return(most_common_species)
})
cluster_to_species

# Convert clusters to species labels
iris$PredictedSpecies <- factor(cluster_to_species[iris$Cluster], levels = species_levels)

# Confusion matrix to compare clusters with actual species
cm <- table(iris$Species, iris$PredictedSpecies)
print(cm)

# Visualizing clusters using clusplot from the cluster package
y_kmeans <- kmeans_3$cluster
clusplot(iris_data[, c("Sepal.Length", "Sepal.Width")],
         y_kmeans,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste("Cluster iris"),
         xlab = 'Sepal Length',
         ylab = 'Sepal Width')

# Detailed output of confusion matrix using caret
library(caret)
confusion_matrix_caret <- confusionMatrix(iris$PredictedSpecies, iris$Species)
print(confusion_matrix_caret)

# Interpretation:  Three cluster has been formed with one separate and two overlapped



