myData <- iris[,-5]


# K-means clusters with k=2 and k=3

# # with K = 3
km.outTwo <- kmeans(myData, 2, nstart = 20)

# # with K = 3
km.outThree <- kmeans(myData, 3, nstart = 20)

km.outThree

# Plotting the clusters with k =3
plot(myData[c("Sepal.Length","Sepal.Width")],col = km.outThree$cluster, main = "K-means with 3 clusters")


# # Interpretration
# After clustering by taking centers, we've used two variables here (Sepal Length and Sepal Width) to 
# plot the graph of the data myData which is the data taking the first four variables of the iris data.
# We can clearly see three different clusters being formed here:
# The first cluster has sepal width on the higher end of the spectrum of the data and sepal length on the lower end of the spectrum
# The second cluster has sepal width on the mid to the lower end of the spectrum while the sepal length is also falls on the middle of the spectrum
# The thrid cluster has sepal width on the middle of the spectrum while the sepal length is clearly on the higher end of the spectrum

# Cluster centers for plot of k = 3
km.outThree$centers
points(km.outThree$centers[,c("Sepal.Length","Sepal.Width")],col = 1:3, pch = 8, cex = 3)

# # Interpretation
# We can see that the first cluster has the center (5.06, 3.42)
# We can see that the second cluster has the center (5.9, 2.7)
# We can see that the third cluster has the center (6.8, 2.07)


# Confusion Matrix to compare with Species variable
cmThree <- table(iris$Species, km.outThree$cluster)
cmThree
#Accuracy
(accuracy <- sum(diag(cmThree))/sum(cmThree))
(mce <- 1 - accuracy)

