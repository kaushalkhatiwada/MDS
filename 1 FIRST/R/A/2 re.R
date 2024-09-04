
# Our Second Re assessment
# question number 6
#--------PRABHAT----------
# a) generate data set
set.seed(13)
dataset <- data.frame(
  age = sample(c(20:59), 150, replace = T),
  height = sample(c(110:190), 150, replace = T),
  weight = sample(c(40:90), 150, replace = T)
)
head(dataset)

# b) Compute BMI (The formula should be BMI = weight in kg/height in m squared) but according to the question i have applied it.
dataset$bmi <- dataset$weight / ((dataset$height)/100)^2

# c) Categorizing bmi as underweight, normal, overweight,obese
dataset$bmi_category <- ifelse(dataset$bmi < 18, 'underweight', 
                               ifelse(dataset$bmi <= 24, 'normal',
                                      ifelse(dataset$bmi <= 30), 'overweight', 'obese'))
head(dataset)

#d)  pie chart
library(ggplot2)
# Create a summary data frame
bmi_summary <- as.data.frame(table(dataset$bmi_category))
colnames(bmi_summary) <- c("Category", "Frequency")
# Calculate percentages
bmi_summary$Percentage <- (bmi_summary$Frequency / sum(bmi_summary$Frequency)) * 100
# Create a pie chart
ggplot(bmi_summary, aes(x = "", y = Frequency, fill = Category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  theme_void() +
  labs(title = "BMI Categories Distribution") +
  theme(legend.position = "right") +
  geom_text(aes(label = paste0(round(Percentage, 1), "%")),
            position = position_stack(vjust = 0.5))




# question number 7 (test of normality, test of equal variance, best independent,post hoc test)
#-------PRABHAT-----------

data <- airquality
# Changing the Month variable as a factor variable
data$Month <- as.factor(data$Month)

# a) Perform goodness-of-fit test on Wind variable by Month variable to check if it follows normal distribution or not
## If the sample size for each category is less than 100, it's appropriate to use the Shapiro-Wilk test for normality, especially if you're interested in testing the normality assumption within each group separately.
library(dplyr)
per_month_count <- data %>% group_by(Month) %>% summarize(count= n())
per_month_count

## Since wind variable has around 30 to 31 data points per each month so it is appropriate to use Shapiro-Wilk test for normality test.

## Shapiro Wilk Test Of Normality
##  H0: The sample data comes from a normally distributed population.
##  H1: The sample data does not come from a normally distributed population.
## If the p-value obtained from the Shapiro-Wilk test is less than or equal to α (p ≤ 0.05),
## you reject the null hypothesis. This suggests that the sample data significantly deviates
## from a normal distribution.
## If the p-value is greater than α (p > 0.05), you fail to reject the null hypothesis.
## This suggests that there is no significant evidence to say that the sample data is not 
## normally distributed.

# Function to perform Shapiro-Wilk test for normality within each group
shapiro_within_month <- function(data) {
  result <- tapply(data$Wind, data$Month, shapiro.test)
  return(result)
}
# Perform Shapiro-Wilk test for each month
shapiro_results <- shapiro_within_month(data)
# View the results
print(shapiro_results)

## Since the p-value is greater than 0.05 for every months, then we can say that the data comes from a normal distribution.
## Thus, we can say that wind variable by each month follows a normal distribution.

## b)	Perform a test of equality of variance on "Wind" variable by each categories of the Month variable and interpret the results.
# Levene's test for homogeneity of variances

## H0: The variances of wind speed are equal across all categories of the "Month" variable.
## H1: The variances of wind speed are not equal across all categories of the "Month" variable.

library(car)
# Perform Levene's test
levene_result <- leveneTest(Wind ~ Month, data = data)
# View the test result
print(levene_result)
## Since the p-value is 0.9467 which is way greater than 0.05 so we fail to reject the null hypothesis.
## That means the variances of wind speed are equal across all categories of the "Month" variable.


## c) Perform the best independent sample statistical test for this data now and interpret the result carefully?

#### Since, wind variable is normally distributed across each month and the variances of wind speed are
#### equal across all cateogries of the "Month" variable, we can apply Classical One-Way Anova test.

## Applying One Way ANOVA
## H0: There are no differences in the means of the "Wind" variable in different months.
## H1: There is a difference in the means of the "Wind" variable in different months.

summary(aov(Wind ~ Month, data = data))

#### Since the p-value (0.00879) is less than the common significance level of 0.05, we reject the null hypothesis.
#### This suggests that there is a statistically significant difference in mean wind speed across different months.

#### This means, post-hoc test or pairwise comparison is required!

# d) Perform the post-hoc test for this data and interpret the results carefully.
#### For classical 1-way ANOVA, Tukey HSD is the best post-hoc test!
#### This will help in identifying which months have significantly different mean wind speeds from each other.

#### H0: There is no significant difference in mean wind speed between the two months being compared.
#### H1: There is a significant difference in mean wind speed between the two months being compared.

#### When the p-value is greater than 0.05, we fail to reject the null hypothesis. This means 
#### that we do not have sufficient evidence to conclude that there is a statistically 
#### significant difference in mean wind speed between the two groups.
#### When the p-value is less than 0.05, we reject the null hypothesis. This means that we
#### have sufficient evidence to conclude that there is a statistically significant difference
#### in mean wind speed between the two groups.
TukeyHSD (aov(Wind ~ Month, data = data))


#### Since, adjusted p value for june and may (6-5) is 0.53 which is greater than 0.05, that means the
#### there is no significant difference in windspeed betweeen these two months.
#### From the above table, we can say that there is a significant difference in windspeeds in
#### July-May (7-5) and August-May(8-5) but in all other months there is no such difference in windspeeds.

summary(lm(Wind ~ Month, data = data))

#### The coefficients for both July and August are negative and statistically significant, indicating that mean wind speed in both months is significantly lower compared to May.


# Conclusion
#### Both Tukey's HSD test and the linear regression model suggest that July and August have statistically significant differences in mean wind speed compared to May.
#### According to Tukey's HSD test, the adjusted p-values for both comparisons are less than 0.05, indicating significant differences.
#### In the linear regression model, the coefficients for July and August are negative and statistically significant at α = 0.05, further confirming lower mean wind speeds in these months compared to May.





# question number 8 (supervised logistic regression and naive bayes classification)
#--------PRABHAT---------- 

library(car)
library(dplyr)
data <- Arrests

### taking color, age, sex, employed and citizen as independent variable and released as dependent variable
### Converting the target variable into numeric values and then again converting them as factor variables.

data$released <- ifelse(data$released == "Yes", 1, 0)
data$released <- as.factor(data$released)

final_data <- select(data, "released", "colour", "age", 
                     "sex", "employed", "citizen")

table(final_data$colour)

## Converting categorical variables colour into binary intergers and then as factors
final_data$colour <- ifelse(final_data$colour == "Black", 0, 1)
final_data$colour <- as.factor(final_data$colour)

### Converting categorical variables gender female as 0 and male as 1
final_data$sex <- ifelse(final_data$sex == "Female", 0, 1)
final_data$sex <- as.factor(final_data$sex)

### Converting categorical variables employed  no as 0 and yes as 1
final_data$employed <- ifelse(final_data$employed == "No", 0, 1)
final_data$employed <- as.factor(final_data$employed)

### Converting categorical variables citizen no as 0 and yes as 1
final_data$citizen <- ifelse(final_data$citizen == "No", 0, 1)
final_data$citizen <- as.factor(final_data$citizen)


library(ggplot2)

##
create_plot <- function(x, y, title) {
  ggplot(data, aes(x = !!x, y = !!y)) +
    geom_point(color = 'red') +
    labs(title = title) +
    theme_bw()
}

plot1<- create_plot(final_data$released, final_data$colour, "released vs colour")
plot2<- create_plot(final_data$released, final_data$age, "released vs age")
plot3<- create_plot(final_data$released, final_data$sex, "released vs sex")
plot4<- create_plot(final_data$released, final_data$employed, "released vs employed")
plot5<- create_plot(final_data$released, final_data$citizen, "released vs citizen")


library(gridExtra)



grid.arrange(plot1, plot2, plot3, plot4, plot5, 
             nrow = 3, ncol = 2)


### From this graph, we can see that there exist non linear relationship between the target variable and independent variable.


### Apply multivariate logistic regression

model.lr <- glm(released~., data = final_data,
                family = 'binomial'
)


summary(model.lr)

### Checking whether there exist mulitcollinearity in the features.
### TO check it, we have VIF(Variance Inflation Factor).
### IF the VIF value of the feautures in a model is greater than 2, then we can remove such feature as it suffers from multicolinearity issue.
vif(model.lr)

### Since, the vif of all of these features are less than 2, we can say that these features are not collinear to each other.

## Divide the data into train and test sets using 70:30 random splits
set.seed(13)

ind <- sample(2, size = nrow(final_data), replace = T, 
              prob = c(0.7, 0.3))




train.data <- final_data[ind == 1,]
test.data <- final_data[ind == 2, ]


## Now only applying logistic regression on the training dataset
model.lr <- glm(released~., data = train.data,
                family = 'binomial'
)


#### Making predictions on the test datasets

predictions <- predict(model.lr, test.data)


predictions <- ifelse(predictions > 0.5, 1, 0)


lr_pred_df<- data.frame(actual = test.data$released, 
                        predicted = predictions)


head(lr_pred_df, 10)


### Based on the predicted results, we can say that the model is pgiving more postive(1) predictions correct than 0 predictions correct.

### Confusion Matrix

library(caret)


confusionMatrix(as.factor(predictions), test.data$released)

### The accuracy of the logistic regression model is 0.8296 and specificity is 0.98 and sensitivity is 0.06.

## naive bayes algorithm
library(e1071)


model.nb <- naiveBayes(released~., data = train.data)



predictions <- predict(model.nb, test.data)

nb_pred_df<- data.frame(actual = test.data$released, 
                        predicted = predictions)


head(nb_pred_df, 10)

### Based on the predicted results, we can say that the model is pgiving more postive(1) predictions correct than 0 predictions correct.


confusionMatrix(as.factor(predictions), test.data$released)

### The accuracy of the naive bayes model is 0.8277 and specificity is 0.98 and sensitivity is 0.066.




# question number 9 (classical multidimensional model)
#--------PRABHAT----------
# a) Get dissimilarity distance as city dissimilarity object
## Create a data frame

df <- data.frame(City = c("Atlanta", 'Chicago', 'Denver', 'Houston', 
                          'Los Angeles', 'Miami', 'New York', 'San Francisco',
                          'Seattle', 'Washington D.C'),
                 Atlanta = c(0, 587, 1212, 701, 1936, 604,
                             748, 2139, 2182, 543),
                 Chicago = c(587, 0, 920, 940, 1745, 1188, 
                             713, 1858, 1737, 597),
                 Denver = c(1212, 920, 0, 879, 831, 1726,
                            1631, 949, 1021, 1494),
                 Houston = c(701, 940, 879, 0, 1374, 968, 
                             1420, 1645, 1891, 1220),
                 'Los Angeles' = c(1936, 1745, 831, 1374, 0, 
                                   2339, 2451, 347, 959, 2300),
                 Miami = c(604, 1188, 1726, 968, 2339, 0, 
                           1092, 2594, 2734, 923),
                 'New York' = c(748, 713, 1631, 1420, 2451, 1092, 
                                0, 2571, 2408, 205),
                 'San Francisco' = c(2139, 1858, 949, 1645, 347, 
                                     2594, 2571, 0, 678, 2442),
                 Seattle = c(2182, 1737, 1021, 1891, 959, 2734,
                             2408, 678, 0, 2329),
                 'Washington D.C' = c(543, 597, 1494, 1220, 2300,
                                      923, 205, 2442, 2329, 0)
)

rownames(df) <- df$City
## Removing city column from the column after adding it as rownames
df <- df[, -which(names(df) == 'City')]
city.dissimilarity_object <- dist(df, method = "euclidean")
city.dissimilarity_object


## b) FIt a classical multidimensional model using the city.dissimilarity object
city_mdm <- cmdscale(city.dissimilarity_object, eig = TRUE, k = 2)

# c. Get the summary of the model and interpret it carefully
# Get the MDM coordinates
mdm_coordinates <- city_mdm$points
# Print the summary of the model
summary(city_mdm)
# Interpretation: The summary includes the eigenvalues, which indicate the amount of variance captured by each dimension.

eigenvalues <- city_mdm$eig
variance_explained <- eigenvalues / sum(eigenvalues) * 100
variance_explained

# d. Get the bi-plot of the model and interpret it carefully
# Plot the MDS result
plot(mdm_coordinates, type = "n", xlab = "Coordinate 1", ylab = "Coordinate 2",
     main = "Classical MDM of US Cities")
text(mdm_coordinates, labels = rownames(mdm_coordinates), col = "blue")


## Based on the biplot we can say that Los Angeles, and San Fransciso are close to each other. Similarly, New York, Washington DC and Miami are close to each other but they are far away from Denver and Houston.



# question number 10 (Hierarchical clustering)
#-------UU-----------.

head(iris)
ir_label <- iris$Species
ir_data <- iris[,-5]
head(ir_data)

#a
# sd.data <- scale(ir_data)
data.dist <- dist(ir_data)
plot(hclust(data.dist,method = "single"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Single Linkage")

#b
plot(hclust(data.dist,method = "complete"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Complete Linkage")

#c
plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

#d
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
#-------UU-----------
data <- USArrests
head(data)
## a) Applying K-Means Algorithm with k = 2 and ploting it in a single graph and interpret it carefully.
## Before applying K-means clustering algorithm, we need to scale the values at a common scale since Kmeans depends on distance (euclidean distance metrics)
library(dplyr)
scaled_data <- data %>% scale()
head(scaled_data)
## Applying Kmeans Clustering
scaled_kmeans_clust <- kmeans(scaled_data, centers = 2, nstart = 20)
scaled_kmeans_clust$cluster
## We have used centers = 2 so we have 2 clusters. These two clusters explain 86.75% of the point variability.
plot(scaled_data, col = (scaled_kmeans_clust$cluster + 1),
     main = "K-Means Clustering with K=2",
     xlab = "",
     ylab = "",
     pch = 20, cex = 2)
### From this graph we can clearly see that the two groups separated by our clustering algorithm. 
### One of the group is in green color whereas the other group is in red color. 
### There are 2 red points which fall nearer to the green cluster.


# b) Add cluster centers for the plot of clusters formed with k = 2 and interpret it carefully.
## Visualizing clusters
y_kmeans <- scaled_kmeans_clust$cluster
cluster_centroids <- scaled_kmeans_clust$centers
library(cluster)
clusplot(x = scaled_data,
         y_kmeans,
         main = "Clustering using k= 2",
         color = TRUE,
         labels = 0,
         xlab = '',
         ylab = '')
# Add cluster centroids
points(cluster_centroids, col = c('red', 'blue'), pch = 8, cex = 2)
## We can clearly see two different clusters with their centroid located with red star and blue star for each of the cluster.


## c) Applying K-Means Algorithm with k = 3 and ploting it in a single graph and interpret it carefully.
## Applying Kmeans Clustering with k = 3
scaled_kmeans_clust <- kmeans(scaled_data, centers = 3, nstart = 20)
scaled_kmeans_clust$cluster
## We have used centers = 2 so we have 2 clusters. These two clusters explain 86.75% of the point variability.
plot(scaled_data, col = (scaled_kmeans_clust$cluster + 1),
     main = "K-Means Clustering with K=3",
     xlab = "",
     ylab = "",
     pch = 20, cex = 2)
### From this graph we can clearly see that the three groups separated by our clustering algorithm. 
### One of the group is in green color whereas the other group is in red color and the last group is in blue color. 
### Some of the data points of green and red color are overlapped.
### The right side of cluster for k=2 and k=3 are same but the left side of cluster is broken down into another cluster.


# d) Add cluster centers for the plot of clusters formed with k = 3 and interpret it carefully.
## Visualizing clusters
y_kmeans <- scaled_kmeans_clust$cluster
cluster_centroids <- scaled_kmeans_clust$centers
library(cluster)
clusplot(x = scaled_data[,c("Assault", "UrbanPop")],
         y_kmeans,
         main = "Clustering using k= 3 with their centroids",
         color = TRUE,
         labels = 0,
         xlab = '',
         ylab = '')
# Add cluster centroids
points(cluster_centroids, col = c('red', 'blue', 'green'), pch = 8, cex = 2)
## We can clearly see two different clusters with their centroid located with red star and blue star and green star for each of the cluster.



# question number 10 (K-mean clustering)
#---------PRABHAT---------
# Q.10)
data <- USArrests

head(data)

## a) Applying K-Means Algorithm with k = 2 and ploting it in a single graph and interpret it carefully.

## Before applying K-means clustering algorithm, we need to scale the values at a common scale since Kmeans depends on distance (euclidean distance metrics)
library(dplyr)
scaled_data <- data %>% scale()

head(scaled_data)


## Applying Kmeans Clustering
scaled_kmeans_clust <- kmeans(scaled_data, centers = 2, nstart = 20)

scaled_kmeans_clust$cluster

## We have used centers = 2 so we have 2 clusters. These two clusters explain 86.75% of the point variability.


plot(scaled_data, col = (scaled_kmeans_clust$cluster + 1),
     main = "K-Means Clustering with K=2",
     xlab = "",
     ylab = "",
     pch = 20, cex = 2)

### From this graph we can clearly see that the two groups separated by our clustering algorithm. 
### One of the group is in green color whereas the other group is in red color. 
### There are 2 red points which fall nearer to the green cluster.

# b) Add cluster centers for the plot of clusters formed with k = 2 and interpret it carefully.


## Visualizing clusters

y_kmeans <- scaled_kmeans_clust$cluster

cluster_centroids <- scaled_kmeans_clust$centers

library(cluster)
clusplot(x = scaled_data,
         y_kmeans,
         main = "Clustering using k= 2",
         color = TRUE,
         labels = 0,
         xlab = '',
         ylab = '')

# Add cluster centroids
points(cluster_centroids, col = c('red', 'blue'), pch = 8, cex = 2)

## We can clearly see two different clusters with their centroid located with red star and blue star for each of the cluster.



## c) Applying K-Means Algorithm with k = 3 and ploting it in a single graph and interpret it carefully.


## Applying Kmeans Clustering with k = 3
scaled_kmeans_clust <- kmeans(scaled_data, centers = 3, nstart = 20)

scaled_kmeans_clust$cluster

## We have used centers = 2 so we have 2 clusters. These two clusters explain 86.75% of the point variability.


plot(scaled_data, col = (scaled_kmeans_clust$cluster + 1),
     main = "K-Means Clustering with K=3",
     xlab = "",
     ylab = "",
     pch = 20, cex = 2)

### From this graph we can clearly see that the three groups separated by our clustering algorithm. 
### One of the group is in green color whereas the other group is in red color and the last group is in blue color. 
### Some of the data points of green and red color are overlapped.
### The right side of cluster for k=2 and k=3 are same but the left side of cluster is broken down into another cluster.


# d) Add cluster centers for the plot of clusters formed with k = 3 and interpret it carefully.


## Visualizing clusters

y_kmeans <- scaled_kmeans_clust$cluster

cluster_centroids <- scaled_kmeans_clust$centers

library(cluster)
clusplot(x = scaled_data[,c("Assault", "UrbanPop")],
         y_kmeans,
         main = "Clustering using k= 3 with their centroids",
         color = TRUE,
         labels = 0,
         xlab = '',
         ylab = '')

# Add cluster centroids
points(cluster_centroids, col = c('red', 'blue', 'green'), pch = 8, cex = 2)

## We can clearly see two different clusters with their centroid located with red star and blue star and green star for each of the cluster.

