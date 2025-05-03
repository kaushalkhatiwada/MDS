
library("jtools")
library("huxtable")
library("car")
library("dplyr")
library("readxl")

CEOSAL=read_excel("CEOSAL1.xls")
WAGE = read_excel("wage.xls")

###################### Regression ###########################
# Simple linear regression
reg_female_wage<-lm(wage ~female, data=WAGE)
reg_female_wage                                # yhat = 14.119 - 3.525 X
summ(reg_female_wage)
Confint(reg_female_wage)            # to obtain confidence interval estimate


# Multi regression
reg_mul_wage<-lm(wage ~female+nonwhite+union+education+exper, data=WAGE)
reg_mul_wage
summ(reg_mul_wage)
Confint(reg_mul_wage)

# Multi regression without experience
reg_mul_wo_exper_wage<-lm(wage ~female+nonwhite+union+education, data=WAGE)
reg_mul_wo_exper_wage
summ(reg_mul_wo_exper_wage)
Confint(reg_mul_wo_exper_wage)

# Compare
export_summs(reg_mul_wage, reg_mul_wo_exper_wage)
summ(reg_mul_wo_exper_wage, scale=TRUE, vifs=TRUE, part.corr = TRUE, confint = TRUE, pvals=FALSE)
