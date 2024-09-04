
####### Prabhat #### table type question
# Q9)

# a) Get dissimilarity distance as city dissimilarity object
## Create a dataframe

df <- data.frame(City = c("Atlanta", 'Chicago', 'Denver', 'Houston', 
                          'Los Angeles', 'Miami', 'New York', 'San Francisco',
                          'Seattle', 'Washington D.C'),
                 Atlanta = c(0, 587, 1212, 701, 1936, 604,
                             748, 2139, 2182, 543),
                 Chicago = c(587, 0, 920, 940, 1745, 1188, 
                             713, 1858, 1737, 597),
                 Denver = c(1212, 920, 0, 879, 831, 1726,
                            1631, 949, 1021, 1494),
                 Houston = c(701, 940, 879, 0, 1374, 968, 
                             1420, 1645, 1891, 1220),
                 'Los Angeles' = c(1936, 1745, 831, 1374, 0, 
                                   2339, 2451, 347, 959, 2300),
                 Miami = c(604, 1188, 1726, 968, 2339, 0, 
                           1092, 2594, 2734, 923),
                 'New York' = c(748, 713, 1631, 1420, 2451, 1092, 
                                0, 2571, 2408, 205),
                 'San Francisco' = c(2139, 1858, 949, 1645, 347, 
                                     2594, 2571, 0, 678, 2442),
                 Seattle = c(2182, 1737, 1021, 1891, 959, 2734,
                             2408, 678, 0, 2329),
                 'Washington D.C' = c(543, 597, 1494, 1220, 2300,
                                      923, 205, 2442, 2329, 0)
)

rownames(df) <- df$City

## Removing city column from the column after adding it as rownames
df <- df[, -which(names(df) == 'City')]

city.dissimilarity_object <- dist(df, method = "euclidean")

city.dissimilarity_object




## b) FIt a classical multidimensional model using the city.dissimilarity object
city_mdm <- cmdscale(city.dissimilarity_object, eig = TRUE, k = 2)

# c. Get the summary of the model and interpret it carefully
# Get the MDM coordinates
mdm_coordinates <- city_mdm$points
# Print the summary of the model
summary(city_mdm)

# Interpretation: The summary includes the eigenvalues, which indicate the amount of variance captured by each dimension.

eigenvalues <- city_mdm$eig

variance_explained <- eigenvalues / sum(eigenvalues) * 100
variance_explained



# d. Get the bi-plot of the model and interpret it carefully
# Plot the MDS result
plot(mdm_coordinates, type = "n", xlab = "Coordinate 1", ylab = "Coordinate 2",
     main = "Classical MDM of US Cities")
text(mdm_coordinates, labels = rownames(mdm_coordinates), col = "blue")


## Based on the biplot we can say that Los Angeles, and San Fransciso are close to each other. Similarly, New York, Washington DC and Miami are close to each other but they are far away from Denver and Houston.

##################################### UJWAL #####

# QN  8 or

library(stats)

# Question a
city_distances <- matrix(c(
  0, 587, 1212, 701, 1936, 604, 748, 2139, 2182, 543,
  587, 0, 920, 940, 1745, 1188, 713, 1858, 1737, 597,
  1212, 920, 0, 879, 831, 1726, 1611, 1949, 2204, 1494,
  701, 940, 879, 0, 1374, 968, 1420, 1645, 1891, 1220,
  1936, 1745, 831, 1374, 0, 2339, 2451, 347, 2734, 2300,
  604, 1188, 1726, 968, 2339, 0, 1092, 2594, 2408, 923,
  748, 713, 1611, 1420, 2451, 1092, 0, 2571, 678, 205,
  2139, 1858, 1949, 1645, 347, 2594, 2571, 0, 678, 2442,
  2182, 1737, 2204, 1891, 2734, 2408, 678, 678, 0, 2329,
  543, 597, 1494, 1220, 2300, 923, 205, 2442, 2329, 0
), nrow = 10, byrow = TRUE)
# Create a distance matrix from the given data in the problem

city_names <- c("Atlanta", "Chicago", "Denver", "Houston", "Los Angeles", "Miami", "New York", "San Francisco", "Seattle", "Washington D.C.")
rownames(city_distances) <- city_names
colnames(city_distances) <- city_names
# Assigning names to row and columns
summary(city_distances)
city_dissimilarity <- as.dist(city_distances)
city_dissimilarity
# Convert to a dissimilarity object

# Question b
mds_model <- cmdscale(city_dissimilarity, eig = TRUE, k = 2)
mds_model
# Fit the classical MDS model using city.dissimilarity object
# the original location of the cities with respect to other cities are preserved in the new dimension 


# Question c
mds_coords <- mds_model$points
print(mds_coords)
summary(mds_coords)
# Summarizing the model
# these cordinate points preserve the original properties of the cities location


# Question d
plot(mds_coords, type = "n")
text(mds_coords, labels = city_names, cex = 0.7)
title("Classical MDS of US Cities")
# Bi-plot of the model
# the bi-plot shows the city map in two dimension where the oroginal distance disimilaty of cities is preserved.




# 2078 10 or (PCA vs MDS)
-------------------------------
# Load the data
data <- USArrests
# Check the first few rows of the data
head(data)
names(data)
data<-as.matrix(data)
str(data)
dim(data)

# a
# Compute the distance matrix
state_dissimilarity <- dist(data)

# b
mds_model <- cmdscale(state_dissimilarity, eig = TRUE, k = 2)
mds_model
# Fit the classical MDS model using city.dissimilarity object
# the original data  of the state for arrest are preserved in the new dimension 


# c
mds_coords <- mds_model$points
print(mds_coords)
summary(mds_coords)
# Summarizing the model
# these cordinate points preserve the original properties of the cities location

# d
plot(mds_coords, type = "n")
text(mds_coords, labels = row.names(data), cex = 0.7)
title("Classical MDS of USArrests")
# Bi-plot of the model
# the bi-plot shows the city map in two dimension where the oroginal distance disimilaty of cities is preserved.


# e

# PCA coordinates
pca_coords <- pr.out$x[, 1:2]

# MDS coordinates
mds_coords <- mds_model$points

# Plot PCA vs MDS
par(mfrow = c(1, 2))
plot(pca_coords, main = "PCA", xlab = "PC1", ylab = "PC2", pch = 19, col = "blue")
text(pca_coords, labels = rownames(data), cex = 0.7, pos = 4)
plot(mds_coords, main = "MDS", xlab = "Dim 1", ylab = "Dim 2", pch = 19, col = "red")
text(mds_coords, labels = rownames(data), cex = 0.7, pos = 4)

# Correlation between PCA and MDS coordinates
cor(pca_coords, mds_coords)

# PCA1  has high degree of positive correlation with MDS1 and low degree of positive correlation with MDS2
# PCA2  has low degree of positive correlation with MDS1 and high degree of negative correlation with MDS2
# These findings imply that both PCA and MDS reveal similar structures in the data, with PC1 and MDS1 representing 
# a common dimension, and PC2 and MDS2 representing another common dimension but with reversed directionality.



