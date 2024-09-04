## Our First Assessment 
# question number 6
#-------KK-----------
# A) column vector X from 1 to 30
X <- 1:30
# B) column vector Y of cubes of vector Y
Y <- X ^ 3
# c) converted the the X, Y in data frame
DF <- data.frame(X=X,Y=Y)
# D) plotted a scatter plot to see relationship between X and Y
plot(X,Y)
# E) Since there was no linear relationship we take log of X and Y
logX <- log(X)
logY <- log(Y)
plot(logX, logY)



# question number 7 (dice and roll)
#-------Suman------------
# a) Random sampling with replacement as true
set.seed(33)
roll <- function(die=1:6){
  sample(die, size=2, replace = T)
}
# b) first roll
roll()
# c) second roll
roll()
# d) third roll
roll()
# e) summary
# Interpreat: given a die with sample size two everything we roll we get different rolls in dice
# mimicing the real world dice game



# question number 8 (tibble, transform, four graph scatter plot)
#-------UU------------
library(tidyverse)
set.seed(13)
# a) create tibble with randomly Generated data
country <- c("Nepal", "India", "France")
year <- sample(2000:2020, 10, replace = TRUE)
cases <- sample(100:1000, 10)
population <- sample(1000000:10000000, 10)
data <- tibble(
  country = sample(country, 10, replace = TRUE),
  year = year,
  cases = cases,
  population = population
)
# b) transform wider format to longer format
library(tidyr)  #For pivot longer function
data_long <- data %>%
  pivot_longer(cols = c(cases, population),
               names_to = "variable",
               values_to = "value")
print(data_long)

# c) Transform cases and population to natural log scale
library(dplyr)
data_transformed <- data %>%
  mutate(ln_cases = log(cases),
         ln_population = log(population)) %>%
  select(-cases, -population)  # Remove original columns if not needed
print(data_transformed)

# d) Scatter plot
#Cases vs Population
plot(data$cases, data$population,xlab = "Cases", ylab = "Population",main = "Scatter Plot of Cases vs Population")
#ln_cases vs Population
plot(data_transformed$ln_cases, data_transformed$ln_population,xlab = "ln(Cases)", ylab = "Population",main = "Scatter Plot of ln(Cases) vs Population")
#Cases vs ln_population
plot(data$cases, data_transformed$ln_population,xlab = "Cases", ylab = "ln(Population)",main = "Scatter Plot of Cases vs ln(Population)")
#ln_cases vs ln_population
plot(data_transformed$ln_cases, data_transformed$ln_population,xlab = "ln(Cases)", ylab = "ln(Population)",main = "Scatter Plot of ln(Cases) vs ln(Population)")

# e) 
par(mfrow = c(2, 2))
#Scatter Plot of Cases vs Population
plot(data$cases, data$population,xlab = "Cases", ylab = "Population",main = "Scatter Plot of Cases vs Population")
#Scatter Plot of ln_cases vs Population
plot(data_transformed$ln_cases, data_transformed$ln_population,xlab = "ln(Cases)", ylab = "Population",main = "Scatter Plot of ln(Cases) vs Population")
#Scatter Plot of Cases vs ln_population
plot(data$cases, data_transformed$ln_population,xlab = "Cases", ylab = "ln(Population)",main = "Scatter Plot of Cases vs ln(Population)")
#Scatter Plot of ln_cases vs ln_population
plot(data_transformed$ln_cases, data_transformed$ln_population,xlab = "ln(Cases)", ylab = "ln(Population)",main = "Scatter Plot of ln(Cases) vs ln(Population)")
par(mfrow = c(1, 1))


# question number 9 (graph and plots)
#---------KK-----------
df <- mtcars
# a) histogram of mpg variable
hist(df$mpg)
# b) 
hist(df$mpg,col = 'blue', breaks=10)
# c) vertical abline at mean
abline(v=mean(df$mpg), color='red',lwd=3,lty=2)
# d) QQ plot and QQ line of mpg
qqnorm(df$mpg)
qqline(df$mpg, col='red', lwd=3)
# e) density plot
plot(density(df$mpg), type='n')
polygon(density(df$mpg), col='yellow', border = NA)


# question number 10 (SNA)
#------UU-------------

library(igraph) 
#a) define graph
g<-graph(c(1,2,3,4))
#b) plot
plot(g)
#c) 
g1<-graph(c("Sita","Ram","Rita","Gita","Gita","Sita","Sita","Gita","Anita","Rita"))
#d)
plot(g1,vertex.color="green",vertex.size=20,edge.color="red",edge.size=10)
#from the graph we can see that the relation between g and s in both way but
#the relation of g and r in one way G,S,R are interconnected with each other but A is only connected with R
# Here the function vertex.color is for changing the color of vertex and the function edge.color is for changing the color of the connection line

#e)
degree(g1) #degree states that how many relations a single node is holding then
#from the result we see that R,S,G have 3 relations but A has only one relation

closeness(g1)
closeness(g1, mode = "all", weights = NA)
#closeness of the nodes is how close the node is with the other nodes

betweenness(g1) #it gives how many nodes have the relation with that node 
#here R has 2 betweenness that means 2 nodes have relation with r

reciprocity(g1)
ecount(g1)
vcount(g1)
edge_density(g1)
diameter(g1)


g2 <- cluster_edge_betweenness(g1)
plot(g2,
     g1,
     vetex.size = 10,
     vertex.label.cex = 0.8)