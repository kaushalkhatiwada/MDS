
employee = read.csv("employee.csv")
head(employee)
summary(employee)
summary(employee$salary)
mean(employee$salary)
sd(employee$salary)
cor(employee$salary,employee$salbegin)
cor.test(employee$salary,employee$salbegin)   # Finding the p-value using correlation test

# Coefficient table
reg<-lm(salary~salbegin,data=employee)
summary(reg)

library(jtools)
summ(reg)


#----------------------
summary(employee[,c("salary","salbegin","jobtime","prevexp")])
cor(employee[,c("salary","salbegin","jobtime","prevexp")])   # Correlation matrix

#Multiple regression
mul<-lm(salary~salbegin + jobtime + prevexp , data=employee)
summary(mul)
