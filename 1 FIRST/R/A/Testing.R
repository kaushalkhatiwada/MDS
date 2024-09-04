# 2080 QN8 or ( independent sample t-test)
#--------------UU------------------------------
# a
set.seed(34)
# Number of cases
num_cases <- 250

# Generate random data for each variable
age <- sample(18:99, num_cases, replace = TRUE)

sex <- sample(c("male", "female"), num_cases, replace = TRUE)

education_levels <- sample(c("No education", "Primary", "Secondary", "Beyond Secondary"), num_cases, replace = TRUE)

soc_eco_status <- sample(c("Low", "Middle", "High"), num_cases, replace = TRUE)
bmi <- sample(14:38, num_cases, replace = TRUE)

data <- data.frame(
  Age = age,
  Sex = sex,
  EducationLevel = education_levels,
  SocioEconomicStatus = soc_eco_status,
  BMI = bmi
)

# b
# suggestive plot for normal distribution
qqnorm(data$BMI)
qqline(data$BMI)
# from the q-q plot we can see many data points are outliers so the data set are not normally distributed.

hist(data$BMI)

# conformative test
# ks_test_result <- ks.test(data$BMI, "pnorm", mean = mean(data$BMI), sd = sd(data$BMI))
# ks test if n>100
ks_test_result <- ks.test(data$BMI, "pnorm",mean = mean(data$BMI), sd = sd(data$BMI))
ks_test_result
# if p value is greater than 0.05 it follows normal distribution.
# since p value is less than 0.05 it does not follow normal distribution.


# shapiro.test in n<100
shapiro.test(data$BMI)



# c
# for equality of variance
library(car)
library(ggplot2)
head(data)
str(data)

#Suggestive plot
ggplot(data=data,mapping=aes(y=Sex,x=BMI))+
  geom_boxplot()

boxplot(bmi ~ sex, data = data, main = "BMI by Sex")
# since the length of whiskers of the boxplot are not same the variance of BMI  with sex donot seem to be equal.


# Conformitary test
data$Sex=as.factor(data$Sex)
(leveneTest(BMI ~Sex, data = data))
# since the value of Pr is greater than 0.05 the variance of BMI with sex is same.


# d
# If Pr(>F) is greater than 0.05, we assume equal variances use Student's t-test.


# if pr(<F) is less than 0.05 we assume unequal varaince and use welch t test.

#e
t.test(BMI ~ Sex, data = data, var.equal = TRUE)
# since p value is greater than 0.05 we accept alternative hypothesis i.e difference in means between group female and group male is not equal to 0

t.test(BMI ~ Sex, data = data, var.equal = FALSE)
# welch t test


# true difference in means between group female and group male is not equal to 0.
# if p value is less than 0.05 we accept null hypothesis.(ie.means between group female and group male is  equal to 0 )



# second assessment 2081 Q7 (Goodness of fit test and independent sample test)
------------UU-------------------------------

data<-airquality
head(data)

# a Good-ness of fit test for normality
# suggestive plot for normal distribution
qqnorm(data$Temp)
qqline(data$Temp)
# from the q-q plot we can see many data points are in qqline so the data set seem to be normally distributed.

hist(data$Temp)
# histogram shows that the data seem to be normally distributed although not perfect.

str(data)
# conformative test
# ks_test_result <- ks.test(data$BMI, "pnorm", mean = mean(data$BMI), sd = sd(data$BMI))
# ks test if n>100
ks_test_result <- ks.test(data$Temp, "pnorm",mean = mean(data$Temp), sd = sd(data$Temp))
ks_test_result
# if p value is greater than 0.05 it follows normal distribution.


# b
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



# c
# if Pr(>F) is less than 0.05 for more than two groups we use welch_anova
# if Pr(>F) is greater than 0.05 for more than two groups we use standard one way anova


# d
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






# PROJECT 4 (supervised learning, goodness-of-fit-test)
#-------------
#Question a

# Assigning airquality dataframe to a new variable
aq <- airquality
str(aq)

# Calculate mean of the wind by month using apply function
mean_wind <- tapply(aq$Wind, aq$Month, mean, na.rm = T)



# Calculate the standard deviation of wind by month using tapply function
sd_wind <- tapply(aq$Wind, aq$Month, sd, na.rm = T)

# Creating a data frame to show the output
mean_sd_table <- data.frame(
  Mean_wind = mean_wind,
  SD_wind = sd_wind
)


# Display the table
print(mean_sd_table)

# Question b
# Test of normality
# Perform Shapiro-Wilk test for each month
result <- tapply(aq$Wind, aq$Month, shapiro.test)

# Print the results
print(result)

# Question c
# Convert Month to a factor
airquality$Month <- factor(airquality$Month)

# Perform Bartlett's test for homogeneity of variances
bartlett_result <- bartlett.test(Wind ~ Month, data = airquality)

# Print Bartlett's test result
print(bartlett_result)

# Question d
#In the above scenario, Bartlett's test indicates that the variances of the "Wind" variable are approximately equal across different months. 
#Therefore, we can use the standard one-way ANOVA.

# Question e
#Fit one way anova model
# Convert Month to a factor
airquality$Month <- factor(airquality$Month)

anova_model <- aov(Wind ~ Month, data = airquality)
summary(anova_model)

#Question f

# Perform Tukey's HSD test
tukey_result <- TukeyHSD(anova_model)

# Print the Tukey HSD test result
print(tukey_result)





# PROJECT 4
#------------
#Part I
#Question a
library(car)

# Assigning airquality dataframe to a new variable
aq <- airquality
dim(aq)

# Calculate mean of the wind by month using apply function
mean_wind <- tapply(aq$Wind, aq$Month, mean, na.rm = T)


# Calculate the standard deviation of wind by month using tapply function
sd_wind <- tapply(aq$Wind, aq$Month, sd, na.rm = T)

# Creating a data frame to show the output
mean_sd_table <- data.frame(
  Mean_wind = mean_wind,
  SD_wind = sd_wind
)


# Display the table
print(mean_sd_table)

# Question b
# Test of normality
# Perform Shapiro-Wilk test for each month
result <- tapply(aq$Wind, airquality$Month, shapiro.test)

# Print the results
print(result)
#Here the p values for all the months are greater than 0.05. Thus, the wind data
# observations in various months follow normal distribution.

# Question c
# Convert Month to a factor
airquality$Month <- factor(airquality$Month)

# Perform Bartlett's test for homogeneity of variances
levene_test <- leveneTest(airquality$Wind ~ as.factor(airquality$Month), data = airquality)

# Print Bartlett's test result
print(levene_test)

# Question d
#In the above scenario, Levene test indicates that the variances of the "Wind" variable are approximately equal across different months. 
# Therefore, we can use the standard one-way ANOVA.

# Question e
# Load the airquality dataset if not already loaded
data("airquality")

# Fit one-way ANOVA model
anova_model <- aov(Wind ~ Month, data = airquality)

# Summary of the ANOVA model
summary(anova_model)


# Question f
# Convert Month to a factor
airquality$Month <- factor(airquality$Month)

# Fit one-way ANOVA model
anova_model <- aov(Wind ~ Month, data = airquality)

# Perform Tukey's HSD test
tukey_result <- TukeyHSD(anova_model)

# Print the Tukey HSD test result
print(tukey_result)
