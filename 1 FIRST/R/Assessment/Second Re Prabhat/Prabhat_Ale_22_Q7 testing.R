

# Q.7) 

data <- airquality

# Chaning the Month variable as a factor variable
data$Month <- as.factor(data$Month)


## a) Perform goodness-of-fit test on Wind variable by Month variable to check if it follows normal distribution or not


## If the sample size for each category is less than 100, it's appropriate to use the Shapiro-Wilk test for normality, especially if you're interested in testing the normality assumption within each group separately.
library(dplyr)

per_month_count <- data %>% group_by(Month) %>% summarize(count= n())

per_month_count

## Since wind variable has laround 30 to 31 data points per each month so it is appropriate to use Shapiro-Wilk test for normality test.

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

