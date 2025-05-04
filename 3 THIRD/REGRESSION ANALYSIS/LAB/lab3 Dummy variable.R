

emp=read.csv("employee.csv")

# Option 1: Making dummies
emp$gender_m <- ifelse(emp$gender=="m",1,0)
head(emp)

emp$jobcat_A <- ifelse(emp$jobcat==1,1,0)
emp$jobcat_B <- ifelse(emp$jobcat==2,1,0)
head(emp)

# Option 2: By using package
install.packages("fastDummies")
library(fastDummies)

emp <- dummy_cols(emp,select_columns = "jobcat")
head(emp)

sal_m <- lm(emp$salary ~emp$gender_m, emp)
sal_m
summary(sal_m)
coefficients(sal_m)


emp <- dummy_cols(emp,select_columns = "gender")
head(emp)
sal_f <- lm(emp$salary~emp$gender_f, emp)
summary(sal_f)
coefficients(sal_f)

# Mean comparison
sal_jobcat <- lm(salary~jobcat_1+jobcat_2, emp)
summary(sal_jobcat)
coefficients(sal_jobcat)


