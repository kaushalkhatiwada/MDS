

#### Project 3
---------------
getwd()
setwd("C:/Users/kaush/OneDrive - Tribhuvan University/MDS/FIRST/R/Assignment/Project3")
library(igraph)

sna <- read.csv("Kaushal Khatiwada - SNA_School.csv")
s <- sna[, 1:2]

# Network diagram
net <- graph_from_data_frame(s, directed = T)

V(net)   # 52 vertices
E(net)   # 290 Edges
degree(net)

# Histogram
degree_table <- table(degree(net))
hist(degree(net),
     main = "Degree",
     xlab = "Degree",
     ylab = "Frequency",
     col= "red")

set.seed(13)
plot(net,
     vertex.color = "green",
     edge.arrow.size = 0.1,
     vertex.label.cex = 0.8)

# Network Diagram using kamada-kawai layout
plot(net,
     layout = layout.kamada.kawai,
     main = "Network Diagram (Kamada-Kawai Layout)",
     vertex.color = rainbow(13),
     edge.arrow.size = 0.1,
     vertex.label.cex = 0.8)

# Hubs is a node with most outer edges
hubs <- hub_score(net)$vector
plot(net,
     main = "Hubs",
     vertex.color = rainbow(13),
     vertex.size = hubs * 30,
     edge.arrow.size = 0.1,
     vertex.label.cex = 0.8)


# Authorities is a node with most inner edges
authorities <- authority.score(net)$vector
plot(net,
     main = "Authority",
     vertex.color = rainbow(13),
     vertex.size = authorities * 30,
     edge.arrow.size = 0.1,
     vertex.label.cex = 0.8)

# Community is form with densely connected noede
net <- graph_from_data_frame(s, directed = F)
community_cluster <- cluster_edge_betweenness(net)
plot(community_cluster,
     net,
     vetex.size = 10,
     vertex.label.cex = 0.8
)





# first question number 10 (SNA)
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