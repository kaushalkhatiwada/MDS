# Question 9

data(iris)
ir_data <- iris
ir_label <- iris$Species
ir_data <- ir_data[,-5]
head(ir_data)

#a
sd.data <- scale(ir_data)
data.dist <- dist(sd.data)
plot(hclust(data.dist,method = "single"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Single Linkage")

#b
plot(hclust(data.dist), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Complete Linkage")

#c
plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

#d
# Best hierarchical model
hc.out <- hclust(dist(sd.data))
hc.clusters <- cutree(hc.out, 4)
table(hc.clusters, ir_label)
par(mfrow = c(1, 1))
plot(hc.out, labels = ir_label)
abline(h = 4, col = "red")

