# Q,9)
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