library(stats)

# Question a
# Create a distance matrix from the given data in the problem
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

# Assigning names to row and columns
city_names <- c("Atlanta", "Chicago", "Denver", "Houston", "Los Angeles", "Miami",
                "New York", "San Francisco", "Seattle", "Washington D.C.")
rownames(city_distances) <- city_names
colnames(city_distances) <- city_names

# Convert to a dissimilarity object
city_dissimilarity <- as.dist(city_distances)

# Question b
# Fit the classical MDS model using city.dissimilarity object
mds_model <- cmdscale(city_dissimilarity, eig = TRUE, k = 2)


# Question c
# Summarizing the model
mds_coords <- mds_model$points
print(mds_coords)
#Interpretation: The data points (from the model) represent the position of the
#cities in the new dimensions. The values are calculated in such a way that
# the original properties (such as distance between cities ) are preserved.


# Question d
# Bi-plot of the model
plot(mds_coords, type = "n")
text(mds_coords, labels = city_names, cex = 0.7)
title("Classical MDS of US Cities")
# Interpretation: Here, we have successfully reduced the dimension of the
# dataset and represented the position of the respectice cities in the new
# dimension graphically. The properties of the cities in this new dimension
# is preserved in accordance with the original data.

