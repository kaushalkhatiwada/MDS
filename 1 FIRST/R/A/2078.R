'6) 
------------
Do The following in R Studio with R script so that it can be knitted as PDF:
Prepare a column vector of miles per gallon (mpg) variable with random range between 10 to 50 of 500
values, do not forget to use your exam roll number as random seed to replicate the result
Plot histogram of this "mpg" variable and interpret it carefully
Refine the histogram by filling the bars with "blue" color and changing number of bins to 8
Add a vertical abline at the arithmetic mean of the mpg variable
Plot Q-Q plot of mpg variable, add normal Q-Q line of red color on it and interpret it carefully
'
library(car)

# setting random seed with my roll number to replicate the result
set.seed(22)

# creating a mpg variable according to question
mpg <- sample(c(10:50), size = 500, replace = TRUE)

# Plot histogram of mpg variable
hist(mpg)

# From the given histogram I can say that most of the cars or vehicles has around 10 to 15 mpg mileage, 
# second highest milage range is around 15 to 20 miles per gallon. The graph looks like a uniform distribution as most
# of the interval has almost similar milage.

# Refine the histogram by filling the bars with blue color and changing color of bins to 8.

hist(mpg, col = "blue", breaks = 8)

# Add a vertical abline at the arithmetic mean of the mpg variable

abline(v=mean(mpg), col = 'red')

# Plot Q-Q plot of mpg variable, add normal Q-Q line of red color on it and interpret it carefully

qqnorm(mpg, main = "QQ Plot of mpg variable with normal QQ-line in red color")

qqline(mpg, col = 'red', lwd = 2)

# Most of the data points lie in the qqline but still many points do not seem to lie on this line so we can 
# say that the mpg variable is not normally distributed.

# Plot density plot of mpg variable without the border, fill it with yellow color and interpret

dens <- density(mpg)
plot(dens, main = "Density plot of mpg")
polygon(dens, col = "yellow", border = NA)

# Upon analyzing the distribution plot, it seems to form bell shape curve but it is not a perfect bell shaped curve.
# So, we can say that the mpg variable does not follow normal distribution.




'6 OR
----------
Define the first layer of the ggplot object with diamond data, carat as x-axis and price as y-axis
Add layer with geometric aesthetic as "point", statistics and position as "identity"
Add layers with scale of y and x variables as continuous
Add layer with coordinate system as Cartesian
Add layer with appropriate title and interpret the resulting graph carefully
'

library(ggplot2)
library(caret)

ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  geom_point(stat = 'identity', position = 'identity') +
  scale_x_continuous() + scale_y_continuous() +
  coord_cartesian() +
  labs(title = "Relationship between carat and price")


# Layered version of code
ggplot(data = diamonds, mapping = aes(carat, price)) +
  layer(geom = 'point', stat = 'identity', position = 'identity') +
  scale_x_continuous() + scale_y_continuous() +
  coord_cartesian()

# ALternative layer version code
ggplot() + layer(data = diamonds, mapping = aes(x = carat, y = price),
                 geom = "point", stat = "identity",
                 position = "identity") +
  scale_x_continuous() + scale_y_continuous() +
  coord_cartesian()







'7
-------------
Do the following in R Studio with R script so that it can be knitted as PDF:
Prepare a data with 100 random observations and two variables: miles per gallon (mpg) with random
range between 10 to 50 and transmission gears (gear) as random binary variable (3 = three gear, 4=four gear and 5-five gears), do not forget to use your class roll number as random seed to replicate the result)
Perform goodness-of-fit test on miles per gallon (mpg) variable to check if the variances are equal or not on gears variable categories
Perform the best 1-way analysis of variance test based on goodness-of-fit results with justification.
Can you use this test for this data? Interpret the result carefully, if applicable.
'

set.seed(22)
mpg <- sample(c(10:50), size = 100, replace = T)
gears <- as.factor(sample(c(3, 4, 5), size = 100, replace = T))

mpg_data <- data.frame(mpg = mpg, gears = gears)
head(mpg_data)

# Performance goodness-of-fit test on mpg to check if variances are equal or not on gears variable
levene_result <- leveneTest(mpg~gears, data = mpg_data)

levene_result

# Since, pvalue is greater than 0.05, we can say that the variances are equal on gears variable.

# Normality check for mpg variable across each categories
normality_check_category <- function(data)
{
  result <- tapply(data$mpg, data$gears, shapiro.test)
  return(result)
}

table(mpg_data$gears)
# Since each category contains values less than 30, we can apply shapiro test of normality.

shapiro_test_results <- normality_check_category(data = mpg_data)
shapiro_test_results

# Since p-value is greater than 0.05 for two gears namely 3 and 5, the mpg variable follows normal distribution across those variables but
#  mpg variable does  not follow normal distribution across gear 4 as p value is less than 0.05 in this case.

# Since data is not normally distributed, we must choose non parametric test rather than parametric one-way anova test.
# So, kruskal wallis test is a good test in this case.

test_result <- kruskal.test(mpg~gears, data = mpg_data)

print(test_result)

# Since, p value is greater than 0.05, which means that there is no significant difference in the median of three groups.

# If there is a significant difference in the median of mpg variables across various gear groups, we can use dunn's test for doing post-hoc analysis.

# Post Hoc Test
library(dunn.test)
# Perform Dunn's test
dunn_result <- dunn.test(mpg_data$mpg, mpg_data$gears,  method="bonferroni")

# Print the results
print(dunn_result)

# Since adjusted p-values for all three groups is greater than 0.05, which means that there is no significant difference in the median of the three groups.




'8
--------------
Do the followings in R Studio using R script so that it can be knitted as PDF:
b) Prepare a data with 200 random observations and four variables: miles per gallon (mpg) with random range between 10 to 50;
transmission (am) as random binary variable (0=automatic, 1=Manual), weight (wt) with random range of 1 to 10 and 
horse power (hp) with random range of 125 and 400, do not forget
to use your exam roll number as random seed to replicate the result
c) Divide this data into train and test datasets with 70:30 random splits with your exam roll number as random seed for replication
d) Fit a supervised linear regression model for the train data
e) Explain the model fit and BLUE coefficients for the fitted model
f) Predict the mpg variable in the test data, get fit indices and interpret them carefully
'
set.seed(22)
df <- data.frame(mpg = sample(c(10:50), size = 200, replace = T),
                 am = as.factor(sample(c(0, 1), size = 200, replace = T)),
                 wt = sample(c(1:10), size = 200, replace = T),
                 hp = sample(c(125:400), size = 200, replace = T)
                 )

head(df)

set.seed(22)
index<- sample(2, size = nrow(df), replace = T, prob = c(0.7, 0.3))

train_df <- df[index == 1, ]
test_df <- df[index ==2, ]

print(nrow(train_df))
print(nrow(test_df))


# Fit a supervised linear regression with training data
linear_reg <- lm(formula = mpg ~ ., data = train_df)

# Checking vif scores to see if there is any multicollinearity present in the dataset
vif(linear_reg)

# Since vif score less than 10, we can say that the features are not correlated with each other to a higher degree.
print(summary(linear_reg))


# From this we can say that the variables am, wt and hp are statistically significant features.

normalize_func <- function(x) {
  scaled_values <- ((x-min(x))/ (max(x) - min(x)))
  return(scaled_values)
}

scaled_train_df <- train_df
scaled_train_df$wt <- normalize_func(scaled_train_df$wt)
scaled_train_df$hp <- normalize_func(scaled_train_df$hp)

scaled_test_df <- test_df
scaled_test_df$wt <- normalize_func(scaled_test_df$wt)
scaled_test_df$hp <- normalize_func(scaled_test_df$hp)


# Fit a supervised linear regression with training data
scaled_linear_reg <- lm(formula = mpg ~ ., data = scaled_train_df)

# Checking vif scores to see if there is any multicollinearity present in the dataset
vif(scaled_linear_reg)

# Since vif score less than 10, we can say that the features are not correlated with each other to a higher degree.
print(summary(scaled_linear_reg))

# From the given summary, we can notice an adjusted R-squared of less than 0 which means the model is not a good fit for this data 
# since R2 is smaller than 0.5.

new_df <- df
new_df$am <- as.integer(df$am)

# Finding correlations
cor(new_df)

# All three variables do not have a strong correlation with the target variable.

# Plot to see linear relationship exists between mpg and wt variable
plot(new_df$mpg, new_df$wt)

# Since there is not a linear relationship exists between these data points.

# Check If Intercept only model is better than linear model.

# Intercept only model
intercept_only_model <- lm(mpg ~ 1, data = scaled_train_df)
full_model <- lm(mpg~., data = scaled_train_df)


# Perform an F-test to compare the models
anova(intercept_only_model, full_model)

# From this we can see that the p value is greater tha n 0.05 which concludes that predictors in the full model does not
# provide a better fit than the intercept only model.
library(car)

density <- density(train_df$mpg)
plot(density)
polygon(density, col = 'red')

# From the figure also, it does not look like a gausian or a bell shaped curve.

# SInce all the assumptions of a BLUE Estimate is not satisfied, we can say that the given predictions can not provide a better fit.


# Fit the model on the test dataset and get the indices and interpret them
predictions <- predict(scaled_linear_reg, scaled_test_df)

library(caret)



indices <- data.frame(
  R2 = R2(predictions, scaled_test_df$mpg),
  RMSE = RMSE(predictions, scaled_test_df$mpg),
  MAE = MAE(predictions, scaled_test_df$mpg)
)

# R2 is less than 0.5 so we can say that this is not a good model.


"9
-----------
Do the following in R Studio with R script so that it can be knitted as PDF:

a) Prepare a data with four random variables and 300 observations: miles per gallon (mpg) with random
range between 10 to 50; transmission (am) as random binary variable (0-automatic, I-Manual), weight
(wt) with random range of 1 to 10 and horse power (hp) with random range of 125 and 400, do not forget
to use your exam roll number as random seed to replicate the result
b) Divide this data into train and test datasets with 80:20 random splits with your exam roll number as

random seed for replication
c) Fit a supervised logistic regression model on train data with transmission (am) as dependent variable and
miles per gallon (mpg), horse power (hp) and weight (wt) as independent variable

d) Predict the transmission variable in the test data and interpret the predicted result carefully

e) Get the confusion matrix, sensitivity, specificity of the predicted model and interpret them carefully
"

set.seed(22)
data <- data.frame(mpg = sample(c(10:50), size = 300, replace = T),
                   am = as.factor(sample(c(0, 1), size = 300, replace = T)),
                   wt = sample(c(1:10), size = 300, replace = T),
                   hp = sample(c(125:400), size = 300, replace = T))


library(ggplot2)
library(grid)
library(gridExtra)

create_cust_plot <- function(data, ind_feat, target_feat) {
  ggplot(data = data, mapping = aes_string(x = target_feat, y = ind_feat)) +
    geom_point(stat = 'identity', position = 'identity', col = 'red')
}

plot1 <- create_cust_plot(data = data, ind_feat = "mpg", target_feat = "am")
plot2 <- create_cust_plot(data = data, ind_feat = "wt", target_feat = "am")
plot3 <- create_cust_plot(data = data, ind_feat = "hp", target_feat = "am")

grid.arrange(plot1, plot2, plot3, nrow = 3, ncol = 1)

# No linear relationship between dependent and independent feature
head(data)

set.seed(22)
index <- sample(2, nrow(data), replace = T, prob = c(0.8, 0.2))
train_data <- data[index ==1, ]
test_data <- data[index ==2, ]



# Fitting a logistic regression on the test dataset.
log_model <- glm(formula = am ~ ., data = train_data, family = 'binomial')

summary(log_model)


# Check vif for this model if multicollinearity exist and is affecting the model
vif(log_model)
# Since the vif value for all these variables are less than 1 we can say that there is no multicollinearity issue in the dataset.

# Make predictions on the test dataset
predictions <- predict(log_model, test_data, type = "response")

predictions <- ifelse(predictions > 0.5, 1, 0)

# Predictions dataframe

pred_df <- data.frame(actual_value = test_data$am, 
                      predicted_value = as.factor(predictions))

head(pred_df)


library(caret)

# Confusion Matrix
confusionMatrix(as.factor(predictions), test_data$am)

# Accuracy is around 53%, sensitivity is around 56% and specificity is around 50%.
# The model is not that of a great model.



"10
-------------
. Do as follows using 'mtcars' dataset in R studio with R script so that it can be knitted as PDF:

a) Check the head and the structure of the dataset

b) Create a 'cars scale' using the Principal Component Analysis (PCA) model based on nine numerical
variables with centering and scaling of the variables

c) Based on the PCA summary result, how many components must be extracted? Why?

d) Get the bi-plot of the fitted model and interpret it carefully

e) Improve the fitted model with VARIMAX process and interpret the results carefully
"
data <- mtcars
# Checking the head of the dataset
head(data)

# Checking the structure of the dataset
str(data)

# Create a 'cars scale' using the Principal Component Analysis (PCA) model based on nine numerical variables with centering and scaling of the variables
## Scaling the data before applying PCA
scaled_data <- scale(data)

library(factoextra)
library(FactoMineR)

cars_scale <- PCA(scaled_data)

# Summarizing the PCA result
summary(cars_scale)
# Finding the eigen values of the result
cars_scale$eig

# By analyzing the summary we can see that there are two eigenvalue namely Dim.1 and Dim.2 greater than 1 so we can choose these two components.
# These two components or variables can explain more than 84% of the total variance. So, the principal componenets are these two variables.

cars_scale_pca <- prcomp(scaled_data)
summary(cars_scale_pca)

## From here also, we can see that PC1 and PC2 have standard deviations greater than 1 and have explained more than 84% of total variance.
# THus, based on the summary obtained we can say that two principal componenets can be extracted.

library(psych)

pca_cars_scale <- psych::principal(scaled_data, nfactors = 2, rotate = 'none')


biplot(pca_cars_scale, labels = rownames(data))
# From the given biplot I can say that PC1 explains the most variation than PC2.
# Looking at the variable arrows, we can see that variables like 'cyl' (number of cylinders), 
# 'wt'(weight), seem to have a positive correlation on PC1. This suggests that cars with higher values on these variables tend to have higher scores on PC1.
# On the other hand, 'drat' (drag ratio), mpg seems to have a negative correlation with PC1, indicating an opposite relationship. Cars with higher drag ratios tend to have lower scores on PC1.

# e) Improve the fitted model with VARIMAX process and interpret the results carefully

pca_cars_scale_varimax <- psych::principal(scaled_data, nfactors = 10, rotate = 'varimax')

print(pca_cars_scale_varimax)

# After applying varimax rotation, we can see RC1, RC2, RC3 and RC4 eigen values are greater than 1 so there are four componenet as PCA after applying varimax rotation.


'10 OR
------------------
Do as follows using "USArrests" dataset in R studio with R script so that it can be knitted as PDF:
a) Get dissimilarity distance as state.dissimilarity object
b) Fit a classical multidimensional model using the state dissimilarity object
c) Get the summary of the model and interpret it carefully
d) Get the plot of the model and interpret it carefully
e) Compare this model with the first two components from principal component analysis in this data
'
# a) Get dissimilarity distance as state.dissimilarity object
data <- USArrests
state.dissimilarity <- dist(data, method = 'euclidean')

# b) Fit a classical multidimensional model using the state dissimilarity object
model <- cmdscale(d = state.dissimilarity, k = 2, eig = TRUE)

# c) Get the summary of the model and interpret it carefully
summary(model)

mdm_coordinates <- model$points

eigenvalues <- model$eig

variance_explained <- eigenvalues / sum(eigenvalues) * 100

variance_explained
# Interpretation: The summary includes the eigenvalues, which indicate the amount of variance captured.

# d) Get the plot of the model and interpret it carefully


plot(mdm_coordinates, main = "Classical Multi dimensional Model Of USArrests Datasets",
     xlab = "Coordinate 1", ylab = "Coordinate 2")
text(mdm_coordinates, labels = rownames(mdm_coordinates), col = "blue")

# Nevada and New York are close to each other, similarly Texas and Colorado are close to each other.

# e) Compare this model with the first two components from principal component analysis in this data

library(psych)
scaled_data <- scale(data)

pr_comp_model <- prcomp(scaled_data)

summary(pr_comp_model)

# THe following pca model yields two eigen values for the given dataset.

# Biplot interpretation
pca_model<- psych::pca(scaled_data, nfactors = 4, rotate = "none")

print(pca_model)

# 50 % variance is explained by PCA1 and remaining 50% is explained by PCA 2.
biplot(pca_model, labels = rownames(mdm_coordinates),
       main = "PCA of two principal components")

# From the given biplot I can say that PC2 explains the most variation than PC2.
# Looking at the variable arrows, we can see that variables like 'cyl' (number of cylinders), 
# 'wt'(weight), seem to have a positive correlation on PC1. This suggests that cars with higher values on these variables tend to have higher scores on PC1.
# On the other hand, 'drat' (drag ratio), mpg seems to have a negative correlation with PC1, indicating an opposite relationship. Cars with higher drag ratios tend to have lower scores on PC1.
