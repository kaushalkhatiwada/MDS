# Question no 6

# 6a
set.seed(1)

n <- 200
age <- sample(10:99, n, replace = TRUE)
sex <- sample(c("male", "female"), n, replace = TRUE)
education <- sample(c("No education", "Primary", "Secondary", "Beyond secondary"), n, replace = TRUE)
socio_economic <- sample(c("Low", "Middle", "High"), n, replace = TRUE)
bmi <- runif(n, min = 14, max = 38)

my_dataset <- data.frame(age, sex, education, socio_economic, bmi)

summary(my_dataset)

# 6b
library(ggplot2)

ggplot(my_dataset, aes(x = age,y=bmi)) +
  geom_point() +
  labs(title = "Scatter plot of Age and BMI", x = "Age", y = "BMI")

# 6d

ggplot(my_dataset,mapping=aes(age))+(geom_histogram(bins = 15))

# The maximum count is at 


# Question no 7
# a)
air_quality<- airquality


shapiro.test(air_quality$Temp)



# Question 8
# 8a

library(car)

arrests_data<-Arrests
str(arrests_data)

arrests_data$year <- as.factor(arrests_data$year)
arrests_data$age <- as.factor(arrests_data$age)
arrests_data$checks <- as.factor(arrests_data$checks)

set.seed(1)
ind <- sample(2,nrow(arrests_data), replace = T, prob = c(0.8,0.2))
train <- data[ind==1,]
test <- data[ind==2,]


model_lr <- glm(released ~ colour+age+sex+employed+citizen  , data = train, family = binomial)


library(e1071)
model_nb <- naiveBayes(released ~ colour+age+sex+employed+citizen, data = train)

predict<-predict(model_lr,newdata=test,type="response")
 

predict_lr<-as.factor((ifelse(predict>0.5,1,0)))


# Question no  9
library(stats)

distance <- matrix(c(
  0, 587, 1212, 701, 1936, 604, 748, 2139, 2182, 543,
  587, 0, 920, 940, 1745, 1188, 713, 1858, 1737, 597,
  1212, 920, 0, 879, 831, 1726, 1631, 949, 1021, 1494,
  701, 940, 879, 0, 1374, 968, 1420, 1645, 1891, 1220,
  1936, 1745, 831, 1374, 0, 2339, 2451, 347, 959, 2300,
  604, 1188, 1726, 968, 2339, 0, 1092, 2594,2734 , 923,
  748, 713, 1631, 1420, 2451, 1092, 0, 2571, 2408, 205,
  2139, 1858, 949, 1645, 347, 2594, 2571, 0, 678, 2442,
  2182, 1737, 1021, 1891, 959, 2734, 2408, 678, 0, 2329,
  543, 597, 1494, 1220, 2300, 923, 205, 2442, 2329, 0
), nrow = 10, byrow = TRUE)

names <- c("Atlanta", "Chicago", "Denver", "Houston", "Los Angeles", "Miami",
                "New York", "San Francisco", "Seattle", "Washington D.C.")


# 9a

city.dissimilarity <- as.dist(distance)

# 9b

mds_model <- cmdscale(city.dissimilarity)


# 9c

summary(mds_model)



# 9d

plot(mds_model)
text(mds_model ,pos=3,labels = names)


