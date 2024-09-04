setwd("C:/Users/pawan/OneDrive/Desktop/21_Pawan")

#create dataset
set.seed(21)
age <- sample(10:99,200,replace = TRUE)
sex <- factor(sample(c(0,1),200,replace = TRUE),levels = c(0,1),labels = c('Male','Female'))
status <-factor(sample(c(0,1,2),200,replace = TRUE),levels = c(0,1,2),labels = c('Low' , 'Medium','High'))
bmi <- round(runif(200,min = 14,max = 38),2)

df <- data.frame (age,sex,status,bmi)
head(df)

2.
# create scatterplot
library(ggplot2)
ggplot(data = df,mapping = aes(x = age , y= bmi),col = 'blue')+
   geom_point()

3.
# create pie chart 


?geom_bar

4. 
# create histogram

ggplot(data = df,mapping = aes(x = age))+
   geom_histogram(binwidth = 1,bins = 15)
   