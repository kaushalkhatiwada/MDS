# Creating a flower scale using PCA

library(dplyr)

flower.scale <- iris[,-5] %>% scale

flowerpca <- prcomp(flower.scale)

flowerpca

summary(flowerpca)

# Computing EigenValues

eigenvalues.PC1 <- flowerpca$sdev[1]^2
eigenvalues.PC2 <- flowerpca$sdev[2]^2
eigenvalues.PC3 <- flowerpca$sdev[3]^2
eigenvalues.PC4 <- flowerpca$sdev[4]^2

eigenV <- data.frame(eigenvalues.PC1, eigenvalues.PC2, eigenvalues.PC3, eigenvalues.PC4)
eigenV

# Kaiser's Rule states that Principal Component with Eigenvalue >= 1 must be retained for latent variable
# So here, PC1 is the only component required to create the latent variable.

# Scree Plot
# calculating total variance explained by each principal component
varExplained = flowerpca$sdev^2 / sum(flowerpca$sdev^2)

varExplained

#create scree plot
library(ggplot2)
qplot(c(1:4), varExplained) +
  geom_line() +
  xlab("Principal Component") +
  ylab("Variance Explained") +
  ggtitle("Scree Plot") +
  ylim(0, 1)

# So here, PC1 is the only component required to be retained as it explains the 72% variance.

# with VARIMAX rotation
# flowerpca2 <- psych::principal(flowerpca, nfactors = 3, rotate = "varimax")
# summary(flowerpca2)
