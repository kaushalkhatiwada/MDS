# Question 7 (Not mentioned)
data("airquality")

# Assigning airquality dataframe to a new variable
aq <- airquality
str(aq)

# Question a
# Test of normality
# Perform Shapiro-Wilk test for temperature 
result <- tapply(aq$Temp, aq$Month, shapiro.test)

# Print the results
# The p-value is not significant and this implies that the temp variable
# with month does follow normal distribution
print(result)

# Question b
# Convert Month to a factor
aq$Month <- factor(aq$Month)

# Perform Bartlett's test for homogeneity of variances
bartlett_result <- bartlett.test(Temp ~ Month, data = aq)

# Print Bartlett's test result
print(bartlett_result)
#Here it can be seen that the variances are not equal.

# Question c
#In the above scenario, Bartlett's test indicates that the variances of the 
# "Wind" variable are not approximately equal across different months. 

#Fit one way anova model
# Convert Month to a factor
aq$Month <- factor(aq$Month)

anova_model <- aov(Wind ~ Month, data = aq)
summary(anova_model)

#Question d

# Perform Tukey's HSD test
tukey_result <- TukeyHSD(anova_model)

# Print the Tukey HSD test result
print(tukey_result)
# Here it makes a pairwise comparison across months for temperature variable.
# We can see that the month pairs 7-5 and 8-5 are significant 
# where there is the difference in mean temperatures.