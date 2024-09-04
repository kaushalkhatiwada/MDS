# Load necessary packages
install.packages("car")
install.packages("onewaytests")

library(car)
library(onewaytests)

# Load the dataset
data("airquality")

# a) Perform Shapiro-Wilk test for normality on Temp variable
shapiro_test <- shapiro.test(airquality$Temp)
print(shapiro_test)





# c) Discussion on which test to use
if (levene_p_value > 0.05) {
  print("Variances are equal; use standard ANOVA.")
  
  # d) Perform standard ANOVA
  anova_result <- aov(Temp ~ factor(Month), data = airquality)
  print(summary(anova_result))
} else {
  print("Variances are not equal; use Welch's ANOVA.")
  
  # d) Perform Welch's ANOVA
  welch_anova_result <- welch.test(Temp ~ factor(Month), data = airquality)
  print(welch_anova_result)
}
