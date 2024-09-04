
 
#Qno 9
library(tidyverse)
#A)
hist(mtcars$mpg)

#B)
hist(mtcars$mpg,col = "blue",breaks = 10)
  
#C)
abline(v=mean(mtcars$mpg))

#D)
#Q-Q plot
qqnorm(mtcars$mpg)
#Q-Q line
qqline(mtcars$mpg,col="red")

#E)
dens <-density(mtcars$mpg)
#plot density
plot(dens,frame=F,main="Density plot of mpg")
polygon(dens,col="yellow")


######################################  
#Qno 10
library(igraph)

#A)
g <- graph(c(1,2,3,4),directed = F)

#B)
plot(g)

#C)
g1 <-graph(c("Sita","Ram","Rita","Gita","Gita","Sita","Sita","Gita","Anita","Rita","Ram","Sita"))

#D)
plot(g1,
     vertex.color="green",
     vertex.size=20,
     edge.color="red",
     edge.size=10)

#E)  
degree(g1,mode = "in")
degree(g1,mode = "out")
degree(g1,mode = "all")
# degree is number of connections for each node. Sita has the highest degree i.e 4 and Anita  has smallest degree i.e 1
# Which means Sita is connected with highest number for vertices. here, mode identities the incoming or outgoing)

closeness(g1)
# Sita is closest and Anita is farthest because Sita has highest number of degree associated with vertices. 

betweenness(g1)
#No vertex will travel through Anita to get to the other vertices .


