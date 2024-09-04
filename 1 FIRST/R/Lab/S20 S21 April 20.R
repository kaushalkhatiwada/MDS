
with(mtcars,shapiro.test(mpg[gear==3]))

with(mtcars,shapiro.test(mpg[gear==4]))

with(mtcars,shapiro.test(mpg[gear==5]))

install.packages("car")
library(car)

leveneTest(mpg ~gear,data=mtcars)

summary(aov(mpg ~gear,data=mtcars))  
 #now post hoc test


TukeyHSD(aov(mpg ~gear,data=mtcars))

mean(mtcars$mpg[gear==5])
sapply(mtcars,FUN = mean,gear)


###################
table(mtcars$gear)
prop.test(x=c(15,12,5),n=c(32,32,32),correct = F)
pairwise.prop.test(x=c(15,12,5),n=c(32,32,32),correct=F)  #post hoc test

#################
plot(mtcars$wt,mtcars$mpg)
plot(mtcars$disp,mtcars$mpg)


cov(mtcars$wt,mtcars$mpg)
cor(mtcars$wt,mtcars$mpg)

##################LINEAR REGRESSION#########
shapiro.test(mtcars$mpg)  # Normality Test p-value>0.05, so normal distribution assumption 1
plot(mtcars$wt,mtcars$mpg) 
cor.test(mtcars$wt,mtcars$mpg) # assumption 2 linear relation

lm1 <- lm(mtcars$mpg ~mtcars$wt)  #regression model
lm1

summary(lm1)  # coefficient of determinant(multiple R- squared) is > 50%, so good regression model assumption 3
# ANOVA is significant so fitted model is validated model Assumption 4
###BLUE###

##Now LINE test

#Linearity
plot(lm1,which=1,col=("blue"))
summary(lm1$residuals)

#Independence
acf(lm1$residuals)
durbinWatsonTest(lm1)

#Normal
plot(lm1,which=2,col=c("blue"))
shapiro.test(lm1$residuals)

#Equal variance
plot(lm1,which=3,col=c("blue"))

install.packages("lmtest")
library(lmtest)
bptest(lm1)

###now predict --------- follow the link in the slide
p <- as.data.frame(6)
colnames(p) <- "wt"

predict(lm1,newdata =p)
