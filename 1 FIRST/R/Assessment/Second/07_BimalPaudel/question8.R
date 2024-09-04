
library(car)
data(Arrests)

a.sample <- sample(c(TRUE, FALSE), nrow(Arrests), replace=T, prob=c(0.8,0.2))
train <- Arrests[a.sample, ]
test <- Arrests[!a.sample, ]



