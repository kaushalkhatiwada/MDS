'
Do the following in R Studio with R script:
a) Create a dataset with following variables: age (18-99 years), sex (male/female), educational levels (No
education/Primary/Secondary/Beyond secondary), socio-economic status (Low, Middle, High) and body
mass index (14-38) with 150 random cases of each variable. Your exam roll number must be used to
set the random seed.
b) Show a sub-divided bar diagram of body mass index variable by sex and socio-economic variables
separately with interpretations.
c) Show multiple bar diagram of age variable withsexand educational level variablesand interpret
carefully.
d) Show boxplots of age and body mass index variable separately and interpret the results carefully
e) Create histogram of age and body mass index variable separately and interpret the results carefully
'

set.seed(22)
dataset <- data.frame(age = sample(c(18:99), size = 150, replace = T),
                      sex = as.factor(sample(c('male', 'female'), size = 150, replace = T)),
                      education_levels = as.factor(sample(c('No education', 'Primary', 'Secondary', 'Beyond Secondary'), size = 150, replace = T)),
                      socio_economic_status = as.factor(sample(c('Low', 'Middle', 'High'), size = 150, replace = T)),
                      bmi = sample(c(14:38), size = 150, replace = T))

head(dataset)


nrow(dataset)

'
b) Show a sub-divided bar diagram of body mass index variable by sex and socio-economic variables
separately with interpretations.
'
## Stacked Barplot Of Bodymass Index & Sex

sex_bmi_table <- table(dataset$sex, dataset$bmi)
sex_bmi_matrix <- as.matrix(sex_bmi_table)

barplot(sex_bmi_matrix,beside = F,  main= "distribution of body mass index with respect to sex.",
        xlab = "body mass index", ylab = "frequency count",
        col = c('red', 'green'))
legend("topright", legend = unique(dataset$sex), fill = c("red", "green"), border = NA, cex = 0.5)


# Multiple Bar diagram of age with sex and education levels are

barplot(sex_bmi_matrix,beside = T,  main= "distribution of body mass index with respect to sex.",
        xlab = "body mass index", ylab = "frequency count",
        col = c('red', 'green'))
legend("topright", legend = unique(dataset$sex), fill = c("red", "green"), border = NA, cex = 0.5)


## Stacked Barplot Of Socio_Economic_Staus & Education Status
socioeco_education_table <- table(dataset$socio_economic_status, dataset$education_levels)
socioeco_education_matrix <- as.matrix(socioeco_education_table)
barplot(socioeco_education_matrix, beside= FALSE, main="Rel Study of education levels and socio-economic status",
        ylab = "Frequency", xlab = "Education Levels", col = c('red', 'green', 'blue', 'black'),
        legend.text = TRUE
)
legend("topright", legend = unique(dataset$socio_economic_status), fill = c("red", 'green', 'blue', 'orange'))



# c) Show multiple bar diagram of age variable withsexand educational level variablesand interpret carefully.
barplot(socioeco_education_matrix, beside = T, main = "Relationship between socio economic status and education level using
        multiple bar graph",
        xlab = "Education level", ylab = "Frequency",
        col = c("red", 'green', 
                'blue', 'orange'))

legend("topright", legend = unique(dataset$socio_economic_status), fill = c("red", 'green', 
                                                                           'blue', 'orange'))


# d) Show boxplots of age and body mass index variable separately and interpret the results carefully

boxplot(dataset$age, col = 'red', main = "Boxplot of age variable",
        ylab = "age")

# From this box plot we can say that the age variable has a median value around 60.
# There are no outliers in this age variable.

boxplot(dataset$bmi, col = 'green', main = "Boxplot of age variable",
        ylab = "age")

# From this box plot we can say that the bmi variable has a median value of 25 and 30. 


# e) Create histogram of age and body mass index variable separately and interpret the results carefully

hist(dataset$age, col = 'red', xlab = "age", main = "Histogram of age variable")

# From the given histogram, we can say that the age variable does not follow normal distribution.

hist(dataset$bmi, col = 'blue', xlab = "bmi", main = "Histogram of variablle bmi")
# From the given histogram, we can say that bmi does not follow normal distribution.
# The highest no of people has a bmi around 15. More than 20 people have bmi around that range.




'
Do the following in a studio and with R script to run RTMS output:
a) Define an object "rating" with 9, 2, 5, 8, 6, 1, 3, 2, 8, 4, 6, 8, 7, 1, 2, 6, 10, 5, 6, 9, 6, 2, 4, 7 values.
b) Replicate the given table obtained from SPSS software for the rating object in R.
'
rating <- c(9, 2, 5, 8, 6, 1, 3, 2, 8, 4, 6, 8, 7, 1, 2, 6, 10, 5, 6, 9, 6, 2, 4, 7)

rating_df <- as.data.frame(table(rating))

names(rating_df) <- c('Valid', 'Frequency')


total_freq <- sum(rating_df$Frequency)

rating_df$Percent <- round((rating_df$Frequency / total_freq) * 100, 1)


rating_df$ValidPercent <- rating_df$Percent


rating_df$CumulativePercent <- cumsum(rating_df$ValidPercent)


rating_df


total_row <- data.frame(
  Valid = "Total",
  Frequency = total_freq,
  Percent = 100.0,
  'ValidPercent' = 100.0,
  'CumulativePercent' = ""  # No cumulative percentage for the total row
)

rating_df <- rbind(rating_df, total_row)


library(gt)
library(dplyr)

rating_df %>% gt() %>% 
  tab_header(title = "rating")



'
Do the following in a studio with R script:
a) Create a dataset with following variables: age (18-99 years), sex (male/female), educational levels (No
education/Primary/Secondary/Beyond secondary), socio-economic status (Low, Middle, High) and body
mass index (14-38) with 250 random cases of each variable. Your exam roll number must be used to
set the random seed.
b) Create a scatterplot of age and body mass index variable and interpret it carefully.
c) Which correlation coefficient must be used based on the interpretation of the scatterplot? Why?
d) Compute the best correlation coefficient identified from the scatterplot and interpret it carefully.
e) Test whether this correlation coefficient is statistically valid or not and justify its value
'
set.seed(22)
dataset <- data.frame(age = sample(c(18:99), size = 250, replace = T),
                      sex = as.factor(sample(c('male', 'female'), size = 250, replace = T)),
                      education_level = as.factor(sample(c('No education', 'Primary', 'Secondary',
                                                           'Beyond Secondary'), size = 250, replace = T)),
                      socio_economic_status = sample(c('Low', 'Middle', 'High'), size = 250, replace = T),
                      body_mass_index = sample(c(14:38), size = 250, replace = T)
                      )

head(dataset)

nrow(dataset)

# b) Create a scatterplot of age and body mass index variable and interpret it carefully.

library(ggplot2)

ggplot(data = dataset, mapping = aes(x= age, y = body_mass_index)) +
  geom_point(stat = 'identity', position = "identity", col = 'red') +
  coord_cartesian() +
  labs(title= "Scatterplot to show the relationship between age and body mass index variables")
  theme_classic() 
  
# The relationship between age and body mass index variable can not be identified from the graph alone. 
# So, need to check the correlation for better confirmation about their relationship.

#  c) Which correlation coefficient must be used based on the interpretation of the scatterplot? Why?

# Based on the graph, we can say that there is a non linear relationship between the age and body mass index so we should 
# not use pearson correlation but instead use spearman rank correlation.
  
# d) Compute the best correlation coefficient identified from the scatterplot and interpret it carefully.
cor(dataset$age, dataset$body_mass_index, method = "spearman")

# From this, we can say that there is a weak positive correlation between age and body mass index in the dataset.
# A unit change in age value will make 0.07 unit change in body mass index value.


# e) Test whether this correlation coefficient is statistically valid or not and justify its value
cor.test(dataset$age, dataset$body_mass_index, method = "spearman")
 
# Since pvalue is greater than 0.05 and correlation value is 0.07, we can say that there is no linear relationship between age and body mass index.
# Also, this correlation coefficient is not statistically valid.




'
Do the following in a studio with R script:
a) Create a dataset with following variables: age (18-99 years), sex (male/female), educational levels (No
education/Primary/Secondary/Beyond secondary), socio-economic status (Low, Middle, High) and body
mass index (14-38) with 250 random cases of each variable. Your exam roll number must be used to
set the random seed.
b) Check if body mass index variables follows normal distribution for sex variable using suggestive plot and confirmatory test and interpret the results carefully.
c) Check if body mass index variables have equal variance for sex variable using suggestive plot and confirmatory test and interpret the results carefully.
d) Which independent sample t-test must be used to compare body mass index by sex?
e) Perform the independent sample t-test identified above and interpret it carefully.
'
set.seed(22)
dataset <- data.frame(age = sample(c(18:99), size = 250, replace = T),
                      sex = as.factor(sample(c('male', 'female'), size = 250, replace = T)),
                      education_level = as.factor(sample(c('No education', 'Primary', 'Secondary',
                                                           'Beyond Secondary'), size = 250, replace = T)),
                      socio_economic_status = sample(c('Low', 'Middle', 'High'), size = 250, replace = T),
                      body_mass_index = sample(c(14:38), size = 250, replace = T)
)

head(dataset)
nrow(dataset)

boxplot(dataset$body_mass_index)



# Create distribution plot
# Set up the plotting area
par(mfrow = c(1, 2))  # 1 row, 2 columns

qqnorm(dataset[dataset$sex == 'male',]$body_mass_index, main = "QQ Plot of Sample Data")
qqline(dataset[dataset$sex == 'male',]$body_mass_index, col = "red")

qqnorm(dataset[dataset$sex == 'female',]$body_mass_index, main = "QQ Plot of Sample Data")
qqline(dataset[dataset$sex == 'female',]$body_mass_index, col = "red")

# From the above qqplot and qqline, we can say that most of the points fall in the qqline but not perfectly fit on all lines.
# Need to do confirmative test for normality
new_dataset <- dataset

new_dataset$sex <- ifelse(new_dataset$sex == "male", 1, 0)


female_bmi <- new_dataset[new_dataset$sex ==0, ]$body_mass_index
male_bmi <- new_dataset[new_dataset$sex ==1, ]$body_mass_index
  
  
ks.test(female_bmi, "pnorm", mean(female_bmi), sd(female_bmi))
ks.test(male_bmi, "pnorm", mean(male_bmi), sd(male_bmi))

# Since pvalue for male and female is both greater than 0.05, we can say that the bmi follows normal distribution among two groups.

# Load necessary libraries
library(ggplot2)


# Create a box plot
ggplot(dataset, aes(x = sex, y = body_mass_index)) +
  geom_boxplot(fill = "lightblue", color = "blue") +
  labs(title = "Box Plot of Bodymass Index by sex", x = "sex", y = "body mass index")

# From the given box plot, we can see there is a small difference in the mean bmi for male and female. 
# But is that difference in median significant? Need to conduct a confirmative test to see it. Levene's test is required.

library(car)


# Performance goodness-of-fit test on mpg to check if variances of bmi are equal or not on sex variable
levene_result <- leveneTest(body_mass_index~sex, data = dataset)

levene_result

# Since the pvalue for levene's test is 0.64 which is less than 0.05, that means bmi has equal variance across two sex categories.


# Equal variances assumed (Student's t-test)
# Unequal variances assumed (Welch's t-test)

# Independent samples t-test should be used in this case as we are comparing the variances of two independent groups (male and feamle)
t.test(body_mass_index~sex, data= dataset)
# Here we can see that mean bmi in male group is 25.91 whereas mean bmi in female groups is 25.70 and pvalue is greater than
# 0.05 so we can say that there is an equal variances among each group in their bmi values.


'
Exercise 9: Do the following in a studio using "mtcars" dataset with a script:
Divide the inputs data into train and test datasets with 70/30 random inputs.
Fit a supervised logistic regression model and naïve bayes classification models on train data with transmission (am) as dependent variable and miles per gallon, displacement (disp), horse power (hp) and weight (wt) as independent variable.
Predict the transmission (am) variable in the test data for both the models and interpret the result carefully.
Get the confusion matrix, sensitivity, specificity of both the models using predicted transmission variable on test data and interpret them carefully.
Which supervised classification model is the best for doing prediction? Why?
'

dataset <- mtcars

index <- sample(2, size = nrow(dataset), replace = T, prob = c(0.7, 0.3))
train_data <- dataset[index ==1, ]
test_data <- dataset[index ==2, ]
  
print(nrow(train_data))
print(nrow(test_data))

head(dataset)

# Fit a supervised logistic regression model and naïve bayes classification models on train data with transmission (am) as dependent variable and miles per gallon, displacement (disp), horse power (hp) and weight (wt) as independent variable.
library(ggplot2)

linearity_check <- function(data, ind_var, dep_var, col) {
  ggplot(data = data, mapping = aes_string(dep_var, ind_var)) +
    geom_point(stat = 'identity', position = 'identity', col = col) +
    coord_cartesian() +
    theme_classic()
}
  

plot1 <- linearity_check(data = dataset, ind_var = 'mpg', dep_var = 'am', col = 'red')
plot2 <- linearity_check(data = dataset, ind_var = 'disp', dep_var = 'am', col = 'blue')
plot3 <- linearity_check(data = dataset, ind_var = 'hp', dep_var = 'am', col = 'green')
plot4 <- linearity_check(data = dataset, ind_var = 'wt', dep_var = 'am', col='orange')


library(gridExtra)


grid.arrange(plot1, plot2, plot3, plot4, nrow = 2, ncol = 2)

# From this figure we can see that there is a non linear relationship between the independent and target variable.

train_dataset <- train_data[, c('am', 'mpg', 'disp', 'hp', 'wt')]
test_dataset <- test_data[, c('am', 'mpg', 'disp', 'hp', 'wt')]

# convert dependent variable as factor variable
train_data$am <- as.factor(train_data$am)
test_data$am <- as.factor(test_data$am)


# Fitting logistic regression
log_reg <- glm(formula = am ~ ., data = train_data, family = "binomial")

# Check vif values or multicollinear features
vif(log_reg)

# Since vif values for mpg is greater than 2, removing that feature
train_data <- train_data[, -which(names(train_data) == 'mpg')]
test_data <- test_data[, -which(names(test_data) == 'mpg')]

# checking vif again
log_reg <- glm(formula = am ~ ., data = train_data, family = 'binomial')

vif(log_reg)

# vif for disp is greater than 7 and around 8 removing it, 
train_data <- train_data[, -which(names(train_data) == 'disp')]
test_data <- test_data[, -which(names(test_data) == 'disp')]

# checking vif again
log_reg <- glm(formula = am ~ ., data = train_data, family = 'binomial')

vif(log_reg)


# Since vif values for hp is greater than 2 so removing any one of them.
train_data <- train_data[, -which(names(train_data) == 'hp')]
test_data <- test_data[, -which(names(test_data) == 'hp')]

# Fitting logistic regression model again
log_reg <- glm(formula = am ~ ., data = train_data, family = 'binomial')


# Fitting logistic regression 

log_reg <- glm(formula = am~., data = train_dataset, family = 'binomial')


# Make predictions on the test dataset
predictions <- predict(log_reg, test_dataset, type = 'response')


predictions <- ifelse(predictions > 0.5, 1, 0)


library(caret)


confusionMatrix(as.factor(predictions), as.factor(test_dataset$am))

# Accuracy of 81.82%, Sensitivity of around 71%, and a specificity of 100%.


# Applying naive bayes algorithm
library(e1071)

# Fit a naive bayes model
nb_model <- naiveBayes(am ~ ., data = train_dataset)

# Make predictions on the test dataset
predictions <- predict(nb_model, test_dataset)



confusionMatrix(predictions, as.factor(test_dataset$am))

# Upon applying naive bayes algorithm, we achieve an accuracy of around 72%, sensitivity of around 71% and a specificity of 
# around 75%.

# Upon reviewing the performance metrics of both the models, we can say that accuracy of logistic regression model is slightly higher than that of naive bayes algorithm model.


'
Use the first four variables of "iris" data file into R Studio and do as follows with R script:

a) Fit a k-means clustering model in the data with (k=2) and (k=3)

b) Plot the clusters formed with (k=3) in the single graph and interpret them carefully.

c) Add cluster centers for the plot of clusters formed with (k=3) above and interpret it carefully.

d) Compare the (k=3) cluster variable with Species variable of iris data using confusion matrix and interprete the result carefully.
'

dataset <- iris

head(dataset)

# removing the target label from the dataset
preprocessed_dataset <- dataset[, -which(names(dataset) == "Species")]

# scaling processed dataset
preprocessed_dataset <- scale(preprocessed_dataset)


head(preprocessed_dataset)



clust_model_2 = kmeans(preprocessed_dataset, nstart = 20, centers = 2)

summary(clust_model_2)

# centers of cluster model 
clust_model_2$centers

# FItting a model with 3 clusters
clust_model_3 <- kmeans(preprocessed_dataset, nstart = 20, centers = 3)

summary(clust_model_3)

clust_model_3$cluster

clust_model_3$centers


# Plot the graph

plot(preprocessed_dataset, col = (clust_model_3$cluster + 1),
     main = "K means clustering with 3 clusters",
     xlab = "",
     ylab = "",
     pch = 0.5)

# We can clearly see three clusters are separated properly. The one in right color is far away from the blue and green clusters.
# THe blue and green clusters are closer to each other with some points overlapping each other cluster.

library(cluster)
cluster_centroids <- clust_model_3$centers
clusplot(preprocessed_dataset[, c("Sepal.Length", "Petal.Length")], clust_model_3$cluster,
             color = TRUE,
             xlab = "",
             ylab = "",
             )
points(cluster_centroids, col = c('red', 'blue', 'orange'), pch=10, cex = 2)

# THe three clusters with their centroid position is clearly seen in the given plot.



# d) Compare the (k=3) cluster variable with Species variable of iris data using confusion matrix and interprete the result carefully.
library(caret)


# Convert Species to numeric labels
dataset$Species_converted <- as.numeric(factor(iris$Species, levels = c("setosa", "virginica", "versicolor")))


confusionMatrix(as.factor(clust_model_3$cluster), as.factor(dataset$Species_converted))

# The species are converted as 'setosa', 'virginica' and 'versicolor'.
# Upon converting the species as this, we get an accuracy of around 83%, and the model can accurately classify setosa species.



'
a) Get this data in R and compute dissimilarity distance as city.dissimilarity object.
b) Fit a classical multidimensional scaling model using the city.dissimilarity object.
c) Get the summary of the model and interpret it carefully.
d) Get the bi-plot of the model and interpret it carefully.
e) Compare this model with the first two components from principal component analysis model in this
data.
'

data <- data.frame(
  City = c('Atlanta', 'Chicago', 'Denver',
           'Houston', 'LosAngeles', 'Miami',
           'NewYork', 'SanFrancisco', 'Seattle',
           'WashingtonDC'),
  Atlanta = c(0, 587, 1212, 701, 1936, 604, 748, 
              2139, 2182, 543),
  Chicago = c(587, 0, 920, 940, 1745, 1188, 713,
              1858, 1737, 597),
  Denver = c(1212, 920, 0, 879, 831, 1726, 1631,
             949, 1021, 1494),
  Houston = c(701, 940, 879, 0, 1374, 968, 1420, 
              1645, 1891, 1220),
  LosAngeles = c(1936, 1745, 831, 1374, 0, 2339, 
                 2451, 347, 959, 2300),
  Miami = c(604, 1188, 1726, 968, 2339, 0, 1092, 
            2594, 2734, 923),
  NewYork = c(748, 713, 1631, 1420, 2451, 1092, 
              0, 2571, 2408, 205),
  SanFrancisco = c(2139, 1858, 949, 1645, 347, 2594, 
                   2571, 0, 678, 2442),
  Seattle = c(2182, 1737, 1021, 1891, 959, 2734, 
              2408, 678, 0, 2329),
  WashingtonDC = c(543, 597, 1494, 1220, 2300,
                   923, 205, 2442, 2329, 0)
  )

head(data)

rownames(data) <- data$City

data <- data[, -which(names(data) == "City")]

head(data)

city.dissimilarity <- dist(data, method = "euclidean")

city.dissimilarity

# b) Fit a classical multidimensional scaling model using the city.dissimilarity object.
mdm_model <- cmdscale(city.dissimilarity, k = 2, eig = TRUE)

# Variance explanation

variance_explained <- mdm_model$eig/sum(mdm_model$eig)

variance_explained

summary(mdm_model)


# THe summary of the model contains the eigen values of the model which can be used to find the total variance captured by the model in the data.

mdm_coordinates <- mdm_model$points

plot(mdm_coordinates, type = 'p', xlab = 'coordinate1', ylab = 'coordinate2',
     main = "Classical Multidimensional Model For US Cities")
text(mdm_coordinates, labels = rownames(data), col = 'red')

# Chicago and Atlanta are closer to each other,
# Los Angeles and San Franciso are also closer to each other. NewYork and Seatle are far from each other.


# e) Compare this model with the first two components from principal component analysis model in this data.

# Applying PCA
library(factoextra)
library(FactoMineR)

pca_model <- PCA(mdm_coordinates)

print(pca_model$eig)

# Both componenets of the model has eigen values greater than 2 and they both explain 50% of variance in the model, summing up to 100% variance explained.

library(psych)


pca_model_psych <- psych::pca(mdm_coordinates, nfactors = 2, rotate = 'none')


pca_model_psych

# THese two components explaining 50-50% of the variance and both have eigen values greater than 1.

biplot(pca_model_psych, labels = rownames(mdm_coordinates))



