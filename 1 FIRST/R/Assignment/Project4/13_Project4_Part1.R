
# Using airquality Dataset

aq <- airquality

## A
#Get mean and standard deviation of Wind variable by Month variable 
#using the appropriate “apply” family of function, 
#show both the results in a single table and interpret them carefully 
aq_mean<- tapply(aq$Wind,aq$Month,mean)  #Mean
aq_sd <- tapply(aq$Wind,aq$Month,sd)     #Standard Deviation
aq_table <- data.frame(Month = names(aq_means), 
                            Mean_of_Wind = as.numeric(aq_mean), 
                            SD_of_Wind = as.numeric(aq_sd))
aq_table


## B
# Perform goodness-of-fit test on Wind variable by Month variable 
# to check if it follows normal distribution or not
library(stats)
library(dplyr)
permonth <- aq %>% group_by(Month) %>% summarize(count= n())
permonth

# Shapiro-Wilk normality test because sample size < 100.
tapply(aq$Wind, aq$Month, shapiro.test)
# p-value = 0.4659 , Normally distributed
# p-value = 0.501 , Normally distributed
# p-value = 0.1564 , Normally distributed
# p-value = 0.937 , Normally distributed
# p-value = 0.7852 , Normally distributed
# p-value < 0.05  so sample data are normally distribution

## C
# Perform goodness-of-fit test on Wind variable by Month variable 
# to check if the variances of Wind are equal or not on a variable categories

library(car)
aq$Month <- factor(aq$Month)
leveneTest(aq$Wind ~ aq$Month, data=aq,center=mean)  # Homogeneity of variance # Levene Test because > 2 categorical group 
# p-value = 0.9454 i.e > 0.05 so,we accept the null hypothesis that means equal variance among months


## D
# Discuss which one-way ANOVA must be used to compare “Wind” variable by “Month” variable categories based on the results obtained above
###### ASSUMPTIONS #####
# Normality Test using shapiro-wilk also fulfilled
# Variance Test using LeveneTest also fulfilled
# Now ready to fit one-way ANOVA

## E
# Fit the best one-way ANOVA for this data now and interpret the results carefully
summary(aov(Wind ~ Month, data = aq))
# p-value 0.0275 i.e <0.05. so post-hoc test is required

## F
# Fit the most-appropriate post-hoc test if the ANOVA is statistically significant and interpret the result carefully
TukeyHSD(aov(Wind ~ Month,data=aq))
