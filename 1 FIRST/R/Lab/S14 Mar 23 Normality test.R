
aq<-airquality
hist(aq$Ozone)
plot(density(aq$Ozone,na.rm=T))
qqnorm(aq$Ozone)
qqline(aq$Ozone,col = 2)
shapiro.test(aq$Ozone) #observed data doesnt follow normal distribution

#solar radiation variable
hist(aq$Solar.R)
plot(density(aq$Solar.R,na.rm = T))
qqnorm(aq$Solar.R)
qqline(aq$Solar.R,col=2)
shapiro.test(aq$Solar.R) #this data doesnt follow normal distribution so we take median.

#wind variable of aq dataframe
hist(aq$Wind)
plot(density(aq$Wind.R,na.rm = T))
qqnorm(aq$Wind.R)
qqline(aq$Wind.R,col=2)
shapiro.test(aq$Wind.R)


######################
#Test of normality:types
#Multiple graphs in a single window?

#Random data
x<- rnorm(500)
y<- x + rnorm(500)

#data
my_ts <- ts(matrix(rnorm(500),
                   nrow=500,ncol=1),
            start=c(1950,1),
            frequency = 12)

my_dates <- seq(as.Date("2005/1/1"),
                by="month","length"=50)

my_factor <- factor(mtcars$cyl)
func <- function(x)x^2

#Create a windoa for graph in 2 rows and 3 column
par(mfrow=c(2,3))

plot(x,y,main="Scatterplot")
plot(my_factor,main="Barplot")
plot(my_factor,rnorm(32),main="Boxplot")
plot(my_ts,main="Time series")
plot(my_dates,rnorm(50),main="Time based plot")
plot(func,0,10,main="Plot a function")

#Grpah is defaulf mode
par(mfrow=c(1,1))

plot(trees[,1:3],main="Correlation plot")

#################################33
#p point of plot
#s
#l
#o
#b
#h

j <- 1:20
k <- j
par(mfrow=c(1,3))

plot(j,k,type="l",main="type='l'")
plot(j,k,type="s",main="type='s'")
plot(j,k,type="p",main="type='p'")

plot(j,k,type="o",main="type='o'")
plot(j,k,type="b",main="type='b'")
plot(j,k,type="h",main="type='h'")


par(mfrow=c(1,1))
####################################3
r <- c(sapply(seq(5,25,5),
               function(i) rep(i,5)))

t <- rep(seq(25,5,-5),5)

plot(r,t,pch=1:25,cex=3,yaxt="n",xaxt="n",ann=FALSE,xlim=c(3,27),lwd=1:3)
text(r-1.5,t,1:25)

plot(r,t,pch=21:25,
     cex=3,
     yaxt="n",
     xaxt="n",
     ann=FALSE,
     xlim=c(3,27),
     lwd=1:3,
     bg=1:25,
     col=rainbow(25))

plot(x,y,pch=21,
     bg="red",     
     col="blue",
     cex=3,            #Symbol size
     lwd=3)            #Border width

#Custom symbol as well

#Math expression
plot(x,y,main=expression(aplha[1]^2+frac(beta,3)))

########################################


install.packages("latex2exp")
library(latex2exp)

plot(x,y,main = TeX('$\\beta^3.\\beta\\in1\\ldots 10$'))

########################
install.packages("Hmisc")
library(Hmisc)


##########################








