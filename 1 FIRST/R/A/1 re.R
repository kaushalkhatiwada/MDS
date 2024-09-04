
# Our First Re assessment
# question number 6
#------KK------------
# A)
#Using Vector
r<-c(1:15)
#Using list
l<- list(1:15)
#Using Array
a<-array(1:15)

# B) column vector
N<- c(1.1,2.2,3.3,4.4,5.5)
str(N)
#It is of numeric data type

#C) operation between vectors
add <- r+N
add
subtract <- N-r
subtract
multiply <- N*r
multiply
divide <- N/r
divide
#Interpret: Since, the size of vector N is 5 and r=5 the vector operation is repeated even the size is not matched
# Vector r repeatedly does operation with N

# D)
#List is defined as the data type which can hold the value of same or different data type
L<- list("This","is","my","first","programming","in","R")
L

# E) Transform list as character
UL <- lapply(L, as.character)
UL



# question number 7
#-------KK------------
# A)
aq <- airquality
str(aq)
# B) how to handle missing value of two variable
# C)
summary(aq)
# D)
library(dplyr)
temp <- aq$Month
summary(temp)
# Interpretation: median month is 7 (i.e July)


# question number 8 (Graph and plot)
#--------KK-----------
# A) bar plot
barplot(aq$Month)
# B) histogram
hist(aq$Temp)
# C) line plot
plot(aq$Temp,aq$Day,type="o")
# D) scatterplot
plot(aq$Ozone,aq$Solar.R)
# Interpret: Has not scattered/speared well


# question number 9 (tibble, transform, scatter, four graph)
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


# question number 10 (SNA)
#-------UU------------

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

