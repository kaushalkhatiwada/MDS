
install.packages("haven")
library("haven")
library("car")

hprice <- read_dta("hprice.dta")
head(hprice)

reg_hprice <- lm(price~lotsize+sqrft+bdrms, data=hprice)
summary(reg_hprice)
summ(reg_hprice)

# Residual plot
residualPlot(reg_hprice)

# Durbin Watson Test
durbinWatsonTest(reg_hprice)

# Breusch-Godfrey test
install.packages("lmtest")
library("lmtest")
bgtest(reg_hprice)



##### Detection technique #####
# Normal QQ plot
library(car)
qqPlot(reg_hprice)

# Breusch-Godfrey test
library(lmtest)
bptest(reg_hprice)

# White test
bptest(reg_hprice, ~fitted(reg_hprice)+(fitted(reg_hprice)^2))

### Log transformation
reg_Inhprice <- lm(log(price)~log(lotsize)+log(sqrft)+log(bdrms), data=hprice)
reg_Inhprice

# BP test
bptest(reg_Inhprice)

# White test
bptest(reg_hprice, ~fitted(reg_lnhprice)+fitted(reg_lnhprice)^2)



########################
#######################

library(readxl)
library(dplyr)
wage <- read_excel("wage.xls")
head(wage)

#Regression
reg_wages <- lm(wage~female+nonwhite+union+education+exper, data=wage)
reg_wages
summary(reg_wages)

# To obtain confidence interval estimate
confint(reg_wages)
