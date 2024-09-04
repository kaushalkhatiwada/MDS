

mu0<- 20
sigma<- 6
xbar<- mean(mtcars$mpg)
n<- length(mtcars$mpg)

z<- sqrt(n)* (xbar - mu0)/sigma
p_value<- 2*pnorm(-abs(z))
p_value<- 2*pnorm((z))

t.test(mtcars$mpg,mu=20)

#########################
#Normal distribution for each category
with(mtcars,shapiro.test(mpg[am==0]))
with(mtcars,shapiro.test(mpg[am==1]))

# Variance Check 
var.test(mpg ~am,data=mtcars)    
##############################

# Two sample T-Test
t.test(mpg ~am,var.equal=T,data=mtcars)

#Linear model
summary(lm(mpg ~am,data=mtcars))