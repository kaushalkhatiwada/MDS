## Q.No.6 
library(dplyr)
library(ggplot2)

# Set seed for reproducibility
set.seed(32)

# Generate random data for 200 cases
data <- data.frame(
  age = sample(10:99, 200, replace = TRUE),
  sex = sample(c("male", "female"), 200, replace = TRUE),
  education = sample(c("No education", "Primary", "Secondary", "Beyond Secondary"), 200, replace = TRUE),
  socio_economic_status = sample(c("Low", "Middle", "High"), 200, replace = TRUE),
  bmi = runif(200, 14, 38)
)

scatterplot()

## Q.No. 7
install.packages("tidyverse")
library(tidyverse)
aq <- airquality
wind_by_month <- sapply(split(aq, aq$Month), FUN = function(x) c(mean(x$Wind), sd(x$Wind)))
wind_by_month_df <- as.data.frame(t(wind_by_month))
colnames(wind_by_month_df) <- c('Mean', 'SD')
print(wind_by_month_df)
## This table is showing the Mean and Standard Deviation of the speed of wind everyday from 
## month May to September (represented by 5 to 9) in the year 1973.


## a.
## Using Shapiro-Wilk test to perform goodness-of-fit test on wind variable to check if it 
## follows normal distribution or not.
library(stats)
hist(aq$Wind)
shapiro.test(aq$Wind)
#### Since the W value is closer to 1 and p-value is >0.05, I conclude that the variable 
## Wind is normally distributed.


#### b.
#### Goodness-of-fit test to check if variances among different groups(months) are equal or not.
library(car)
aq$Month <- factor(aq$Month)
leveneTest(aq$Wind ~ aq$Month, data = aq, center = mean)
#### Since p-value > 0.05, we accept the null hypothesis that means equal variance among months.


#### c.
#### Normality test of each month.
with(aq, shapiro.test(Wind[Month == 5]))
with(aq, shapiro.test(Wind[Month == 6]))
with(aq, shapiro.test(Wind[Month == 7]))
with(aq, shapiro.test(Wind[Month == 8]))
with(aq, shapiro.test(Wind[Month == 9]))
#### Since the W value is closer to 1 and p-value is >0.05 in each month, I conclude that variable Wind in each Month is normally distributed.So classical one-way anova must be used


## Q.No.9 
## 
install.packages("tinytex")

## Q.No.10
dataset <- iris
dataset

## 10.a),b),c)
## Putting the iris data set and creating a hierarchical clustering using these methods.
hcasingle <- hclust(dist(dataset),method = "single")
hcacomplete <- hclust(dist(dataset),method = "complete")
hcaaverage <- hclust(dist(dataset),method = "average")

## Getting the dendrogram using three different models i.e. single linkage, complete linkage,
## average linkage
plot(hcasingle, main = "Single Linkage",xlab="",sub="",cex = 0.6)
plot(hcacomplete, main = "Complete Linkage",xlab="",sub="",cex = 0.6)
plot(hcaaverage, main = "Average Linkage",xlab="",sub="",cex = 0.6)


fviz_nbclust(dataset,FUN = kmeans, method = "wss") + labs(subtitle="complete linkage")
