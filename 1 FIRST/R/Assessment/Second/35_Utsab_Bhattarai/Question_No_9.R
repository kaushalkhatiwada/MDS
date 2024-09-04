# Do the follows using given dataset of 10 US cities in R studio with R script:
data("UScitiesD")

## a. Get dissimilarity distance as city.dissimilarity object.
city.dissimilarity <- as.dist(UScitiesD)
city.dissimilarity

## b. Fit a classical multidimensional model using the city.dissimilarity object.
mds <- cmdscale(city.dissimilarity,
                eig = TRUE,
                k = 2)
mds$points

## c. Get the summary of the model and interpret it carefully.
summary <- data.frame(
  coordinates = mds$points,
  eigenvalues = mds$eig,
  explained_variance = mds$eig / sum(abs(mds$eig))
)
summary

# Here, summary output consists of three main components. They are Coordinates, eigenvalues and explained_variance. The cities are plotted in a two-dimensional space. For example, San Francisco and Seattle are close to each other (similar coordinates.1 distances), whereas Seattle and Miami are far apart (high coordinates.1 distances). The first eigenvalue is 9.582144*10ˆ6, explaining approximately 84.64% of the total variance. The second eigenvalue of Chicago is 1.686820 10ˆ6, explaining about 14.90% of the total variance.
## d. Get the bi-plot of the model and interpret it carefully
suppressWarnings(
  library(ggplot2)
)
mds_df <- as.data.frame(mds$points)
mds_df$City <- rownames(mds_df)
ggplot(mds_df,
       aes(x = V1,
           y = V2,
           label = City)) +
  geom_point() +
  geom_text(vjust = -0.5,
            hjust = 0.5) +
  labs(title = "MDS Biplot of US Cities",
       x = "Dimension 1",
       y = "Dimension 2") +
  theme_minimal()
