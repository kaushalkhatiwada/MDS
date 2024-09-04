

# Social Network Analysis
#Requires relational database
library(igraph)

g <- graph(c(1,2))
plot(g)
plot(g,
     vertex.color="green",
     vertex.size=40,
     edge.color="red",
     edge.size=20)

g <- graph(c(1,2,2,3,3,4,4,1))               #Directed
plot(g,
     vertex.color="green",
     vertex.size=40,
     edge.color="red",
     edge.size=20)

g <- graph(c(1,2,2,3,3,4,4,1),directed=F)     #Undirected
plot(g,
     vertex.color="green",
     vertex.size=40,
     edge.color="red",
     edge.size=20)

g <- graph(c(1,2,2,3,3,4,4,1),directed=F,n=7)   
plot(g,
     vertex.color="green",
     vertex.size=40,
     edge.color="red",
     edge.size=20)

g1 <- graph(c("Sita","Ram","Ram","Rita","Rita","Ram"))
plot(g1,
     vertex.color="green",
     vertex.size=40,
     edge.color="red",
     edge.size=20)
#Degree
degree(g1)
#diameter
diameter(g1,directed = F,weights = NA)
#Edge Density
edge_density(g1,loops=F)
#Edge density
ecount(g1)/vcount(g1)*(vcount((g1)-1))
#Recipeocity of directed graph
reciprocity(g1)
#Closeness
closeness(g1,mode="all",weights=NA)
#Betweeness
betweenness(g1,directed = F,weights = NA)
############################################
