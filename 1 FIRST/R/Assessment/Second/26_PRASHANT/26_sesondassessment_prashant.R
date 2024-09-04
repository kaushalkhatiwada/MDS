## Questiotion 7

library(tidyverse)
aq <- airquality
wind_by_month <- sapply(split(aq, aq$Month), FUN = function(x) c(mean(x$Wind), sd(x$Wind)))
wind_by_month_df <- as.data.frame(t(wind_by_month))
colnames(wind_by_month_df) <- c('Mean', 'SD')
print(wind_by_month_df)
#### This table is showing the Mean and Standard Deviation of the speed of wind everyday from month May to September (represented by 5 to 9) in the year 1973.


#### a.
#### I am using Shapiro-Wilk test to perform goodness-of-fit test on wind variable to check if it follows normal distribution or not.
library(stats)
hist(aq$Wind)
shapiro.test(aq$Wind)
#### Since the W value is closer to 1 and p-value is >0.05, I conclude that the variable Wind is normally distributed.


#### C.
#### Goodness-of-fit test to check if variances among different groups(months) are equal or not.
library(car)
aq$Month <- factor(aq$Month)
leveneTest(aq$Wind ~ aq$Month, data = aq, center = mean)
#### Since p-value > 0.05, we accept the null hypothesis that means equal variance among months.


#### D.
#### Normality test of each month.
with(aq, shapiro.test(Wind[Month == 5]))
with(aq, shapiro.test(Wind[Month == 6]))
with(aq, shapiro.test(Wind[Month == 7]))
with(aq, shapiro.test(Wind[Month == 8]))
with(aq, shapiro.test(Wind[Month == 9]))
#### Since the W value is closer to 1 and p-value is >0.05 in each month, I conclude that variable Wind in each Month is normally distributed.So classical one-way anova must be used.
