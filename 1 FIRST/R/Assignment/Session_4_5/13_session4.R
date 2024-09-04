
##Plotting##
x<-c(1:30)
y<-x^3
plot(x,y)    #Plot function is used to plot vector in a graphical representation

##Changing Directory##
initial.dir <- getwd()  #To get the current working directory
setwd("~/R")            #To change the working directory

#Export Output result to a File
sink("13_session4.out")  

##Load csv file from local PC
iris<-read.csv("iris.csv")
plot(iris)
summary(iris)
head(iris)
sink()              ##close the output file
setwd(initial.dir)  #Change working directory to default

##Load data from internet##
iris <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"),header = FALSE)
head(iris)
##Add column names##
names(iris)<-c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width","Species")
head(iris)

##Export internet file to local computer##
write.csv(iris,"iris_export.csv")

##load library##
library(magrittr)

##Square root of Sepal Length
iris$Sepal.Length.SQRT<-iris$Sepal.Length %>% sqrt()
head(iris)
##OR##
#iris$Sepal.Length %<>% sqrt     #It replaces the original data, be careful while using it.


##set.seed function is used to reproduce same results,when we generate random number it will produce difference sample
##But if we use set.seed function to generate random number it will produce same sample
rnorm(5)  #Run multiple time gives you different outcomes

set.seed(123)
rnorm(5)  #run multiple time gives you same outcomes

##Error without tee operator##
set.seed(123)
rnorm(200)%>%
matrix(ncol = 2) %>% 
plot %>%
colSums

set.seed(123)
rnorm(200)%>%
matrix(ncol = 2) %T>% ##"tee" pipe allow to continue to next argument without interruption
plot %>%  
colSums

## Data set is filters to include rows where Sepal length is greater than mean of Sepal length
#Cor function is used to find the correlation between Sepal length and Sepal width
iris %>% subset(Sepal.Length > mean(Sepal.Length)) %$% cor(Sepal.Length,Sepal.Width)
summary(iris)

  