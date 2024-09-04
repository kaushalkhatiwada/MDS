
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

