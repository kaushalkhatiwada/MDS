# 2080 QN8 or
# a
set.seed(34)
# Number of cases
num_cases <- 250

# Generate random data for each variable
age <- sample(18:99, num_cases, replace = TRUE)

sex <- sample(c("male", "female"), num_cases, replace = TRUE)

education_levels <- sample(c("No education", "Primary", "Secondary", "Beyond Secondary"), num_cases, replace = TRUE)

soc_eco_status <- sample(c("Low", "Middle", "High"), num_cases, replace = TRUE)
bmi <- sample(14:38, num_cases, replace = TRUE)

data <- data.frame(
  Age = age,
  Sex = sex,
  EducationLevel = education_levels,
  SocioEconomicStatus = soc_eco_status,
  BMI = bmi
)

# b
# suggestive plot for normal distribution
qqnorm(data$BMI)
qqline(data$BMI)
# from the q-q plot we can see many data points are outliers so the data set are not normally distributed.

hist(data$BMI)

# conformative test
# ks_test_result <- ks.test(data$BMI, "pnorm", mean = mean(data$BMI), sd = sd(data$BMI))
# ks test if n>100
ks_test_result <- ks.test(data$BMI, "pnorm",mean = mean(data$BMI), sd = sd(data$BMI))
ks_test_result
# if p value is greater than 0.05 it follows normal distribution.
# since p value is less than 0.05 it does not follow normal distribution.


# shapiro.test in n<100
shapiro.test(data$BMI)



# c
# for equality of variance
library(car)
library(ggplot2)
head(data)
str(data)

#Suggestive plot
ggplot(data=data,mapping=aes(y=Sex,x=BMI))+
  geom_boxplot()

# OR

boxplot(bmi ~ sex, data = data, main = "BMI by Sex")
# since the length of whiskers of the boxplot are not same the variance of BMI  with sex donot seem to be equal.


# Conformitary test
data$Sex=as.factor(data$Sex)
(leveneTest(BMI ~Sex, data = data))
# since the value of Pr is greater than 0.05 the variance of BMI with sex is same.


# d
# If Pr(>F) is greater than 0.05, we assume equal variances use Student's t-test.


# if pr(<F) is less than 0.05 we assume unequal varaince and use welch t test.

#e
t.test(BMI ~ Sex, data = data, var.equal = TRUE)
# since p value is greater than 0.05 we accept alternative hypothesis i.e difference in means between group female and group male is not equal to 0

t.test(BMI ~ Sex, data = data, var.equal = FALSE)
# welch t test


# true difference in means between group female and group male is not equal to 0.
# if p value is less than 0.05 we accept null hypothesis.(ie.means between group female and group male is  equal to 0 )


# exam Q7

data<-airquality
head(data)

# a
# suggestive plot for normal distribution
qqnorm(data$Temp)
qqline(data$Temp)
# from the q-q plot we can see many data points are in qqline so the data set seem to be normally distributed.

hist(data$Temp)
# histogram shows that the data seem to be normally distributed although not perfect.

str(data)
# conformative test
# ks_test_result <- ks.test(data$BMI, "pnorm", mean = mean(data$BMI), sd = sd(data$BMI))
# ks test if n>100
ks_test_result <- ks.test(data$Temp, "pnorm",mean = mean(data$Temp), sd = sd(data$Temp))
ks_test_result
# if p value is greater than 0.05 it follows normal distribution.


# b
# for equality of variance
library(car)
library(ggplot2)
head(data)
str(data)

#Suggestive plot
ggplot(data=data,mapping=aes(y=factor(Month),x=Temp))+
  geom_boxplot()

boxplot(Temp ~ Month, data = data, main = "Temp by Month")
# since the length of whiskers of the boxplot are not same the variance of Temp  with Month donot seem to be equal.


# Conformitary test
data$Month=as.factor(data$Month)
data$Temp=as.numeric(data$Temp)
(leveneTest(Temp ~Month, data = data))
str(data)
# since the value of Pr is less than 0.05 the variance of Temp across month is not equal.



# c
# if Pr(>F) is less than 0.05 for more than two groups we use welch_anova
# if Pr(>F) is greater than 0.05 for more than two groups we use standard one way anova


# d
(welch_anova <- oneway.test(data$Temp~factor(data$Month), var.equal = FALSE))
# since p value is less than 0.05 means of Temp across month are not equal.



# if Pr(>F) is greater than 0.05 for more than two groups we use standard one way anova
welch_anova <- oneway.test(aq$Temp~factor(aq$Month), var.equal = TRUE)
welch_anova


(anova_model <- aov(Temp ~ Month, data = data))


# Apply TukeyHSD to the ANOVA model
tukey_result <- TukeyHSD(anova_model)
print(tukey_result)
# the pairs in  which p value is less than 0.05 ie. 6-5 has difference in mean temperature.
# the pairs in  which p value is less than 0.05 ie. 8-7 has no difference in mean temperature.





# Qn 8
# a
head(iris)
flower_scale<- iris[,-5]
head(flower_scale)
pr.out <- prcomp(flower_scale, scale = TRUE)


#b
pr.out

std_devs <- pr.out$sdev
std_devs
eigenvalues <- std_devs^2
eigenvalues
# SD of PC1...PC4 are 1.7083611 0.9560494 0.3830886 0.1439265
# eigenvalues of PC1...PC4 are are 2.91849782 0.91403047 0.14675688 0.02071484 which is square of SD
# according to kaisers rule we consider principal components with eigenvalues greater than 1 ie. PC1

# c
# Load necessary library
library(ggplot2)

# Create a data frame for plotting
plot(eigenvalues,type='o',xlab="Principal components")
abline(h=1,col="red")
abline(v=1,col="green")
# since the eigen value of PC1 is only grater than 1 as required by kaisers rule ...the PC1 is the component that describes the 
# which describes  maximum variance among all other components.

# d
library(FactoMineR)
pca.1 <- PCA(flower_scale, scale = TRUE, ncp = 3, graph = FALSE)
pca.1$ind$coord
varimax_rot <- varimax(pca.1$ind$coord[,1:3])
varimax_rot
pr.out1 <- prcomp(varimax_rot$loadings, scale = TRUE)
pr.out1
std_devs1 <- pr.out1$sdev
std_devs1
eigenvalues1 <- std_devs1^2
eigenvalues1


# even after varimax rotation only one component has eigen value greater than 1 so we consider only one component
# as kaisers rule.
# thus varimax rotation does the bring any new conclusion even after re scaling.


# biplot of PCA model
biplot(pr.out)
pr.out

title("Bi plot of PCA")

# Each point on the biplot represents an observation (data point) in the new coordinate system preserving orgonal data
# with x axis as PC1 and y axis as PC2.

# The arrows (vectors) represent the original variables. 
# The direction and length of the arrows indicate how each variable contributes 
# to the principal components.

# A longer arrow means that the variable has a stronger contribution to the principal component.
# All the arrows has almost similar length so their contribution seems to be equal.

# The angle between the arrows and the axes indicates the correlation between 
# the variable and the principal component.A smaller angle means a higher correlation.
# Petal.Length and Petal.Width has higher angle with PC2 so it has low correlation but has higher coorelation with PC1.
# 


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








# QN 10 or 


install.packages("ClusterR")
install.packages("cluster")
library(ClusterR)
library(cluster)
head(iris)
table(iris$Species)
iris_1<-iris[,-5]
sum(is.na(iris_1))
set.seed(34)
# observing the data set

## a

kmeans.c2<-kmeans(iris_1,centers = 2,nstart = 20)
kmeans.c2
# k mean clustering with two clusters
# it forms two clusters of sizes 53, 97

kmeans.c3<-kmeans(iris_1,centers = 3,nstart = 20)
kmeans.c3
# k mean clustering with three clusters
# it forms two clusters of sizes 50, 62, 38


## b
plot(iris_1[c("Sepal.Length", 
              "Sepal.Width")],
     col = kmeans.c3$cluster,
     main = "K-means with 3 
clusters")

plot(iris_1$Sepal.Length,iris_1$Sepal.Width,col=kmeans.c3$cluster)

# the plot for three clusters is formed
# each cluster is colored differently ie. black, red and green
# in plot some of the green and red are seen mixed which means points are not well clustered
# for better visualization sepal length and sepal width are considered for plotting


## c

kmeans.c3$centers
kmeans.c3$centers[, 
                  c("Sepal.Length", "Sepal.Width")]
plot(iris_1[c("Sepal.Length", 
              "Sepal.Width")],
     col = kmeans.c3$cluster,
     main = "K-means with 3 
clusters")

points(kmeans.c3$centers[, 
                         c("Sepal.Length", "Sepal.Width")],col = 1:3, pch= 8, cex= 5)

# the center of clusters with respect to sepal length and sepal width is found 
# the center is plotted with plot () function
# the center gives mean of each cluster

## d
(iris$Species[50])
(kmeans.c3$cluster[50])
cm<-table(iris$Species,kmeans.c3$cluster)
cm

(accuracy<-
    sum(diag(cm))/sum(cm))

# three clusters were compared using confusion matrix
# the cm gives that 50 of setosa , 48 of versicolor and 36 of virginica were clustered correctly
# 14 of virginica and 2 of versicolr are predicted incorrectly
# using confusion matrix accuracy was found to be 9.33 %






# QN 10


head(iris)
ir_label <- iris$Species
ir_data <- iris[,-5]
head(ir_data)

#a
# sd.data <- scale(ir_data)
data.dist <- dist(ir_data)
plot(hclust(data.dist,method = "single"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Single Linkage")

#b
plot(hclust(data.dist,method = "complete"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Complete Linkage")

#c
plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

#d
# Best hierarchical model

plot(hclust(data.dist, method = "average"), xlab = "", sub = "", ylab = "",
     labels = ir_label, main = "Average Linkage")

abline(h = 1.85, col = "red")


hc.out1 <- hclust(dist(ir_data),method = "single")
hc.out2 <- hclust(dist(ir_data),method = "complete")
hc.out3 <- hclust(dist(ir_data),method = "average")

hc.clusters1 <- cutree(hc.out1,3)
hc.clusters2 <- cutree(hc.out2,3)
hc.clusters3 <- cutree(hc.out3,3)


table(hc.clusters1, ir_label)
# virginica is incorrectly clustered as versicolor

table(hc.clusters2, ir_label)
# virginica is incorrectly clustered as versicolor

table(hc.clusters3, ir_label)
# only few of the virginica is incorrectly clustered as versicolor which is better than other methods.

plot(hc.out3, labels = ir_label,main = "Average Linkage (Best HCA model)")
abline(h = 1.85, col = "green")

# since the number of correctly represented data in dendrogram is formed in average method we prefer average method.




# Final 2078  6 OR
ggplot(data=diamonds,mapping=aes(x=carat,y=price))+
  geom_point(stat = "identity",position = "identity")+
  scale_x_continuous()+scale_y_continuous()+
  coord_cartesian()+
  labs(title="Scatter plot of price and carat")

# final 2078 6
set.seed(34)
mpg<-sample(c(10:50),500,replace = TRUE)
hist(mpg)
hist(mpg,col="blue",border = "white",breaks=8)
abline(v=mean(mpg),col="red")
qqnorm(mpg)
qqline(mpg,col="red")
# data are scatterd and it is randomally distributed
ks.test(mpg,"pnorm")

plot(density(mpg),col="yellow",frame=FALSE)
polygon(density(mpg),col="yellow")


#First term 6

x<-c(1:30)
y<-x^3
data<-data.frame(x,y)
plot(x,y)
plot(log(x),log(y))



# 2078 10 or
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
state_dissimilarity

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
pr.out <- prcomp(data, scale = TRUE)
pr.out
pca_coords <- pr.out$x[, 1:2]
pca_coords
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




# 2080 first assememnt

# 10

library(igraph) 
#a
g<-graph(c(1,2,3,4))

#b
plot(g)
#this graph represent the relation between 1 and 2 their interconnection

#c
g1<-graph(c("Sita","Ram","Rita","Gita","Gita","Sita","Sita","Gita","Anita","Rita"))
# to define the g1 as givwen by the question

#d
plot(g1)
#from the graph we can see that the relation between g and s in both way but
#the relation of g and r in one way G,S,R are interconnected with each other but A is only connected with R

plot(g1,vertex.color="green",vertex.size=20,edge.color="red",edge.size=10)
# Here the function vertex.color is for changing the color of vertex and the function edge.color is for changing the color of the connection line

#e
degree(g1)
#degree states that how many relations a single node is holding then
#from the result we see that R,S,G have 3 relations but A has only one relation

closeness(g1)
closeness(g1, mode = "all", weights = NA)
#closeness of the nodes is how close the node is wuth the other nodes

betweenness(g1) #it gives how many nodes have the relation with that node 
#here R has 2 betweenness that means 2 nodes have relation with r

reciprocity(g1)
ecount(g1)
vcount(g1)
edge_density(g1)
diameter(g1)


g2 <- cluster_edge_betweenness(g1)
plot(g2,
     g1,
     vetex.size = 10,
     vertex.label.cex = 0.8)







# 2080 first assememnt

# 8
# Question 8a


library(tibble)
set.seed(34)

# Generate random data
country <- c("Nepal", "India", "France")
year <- sample(2000:2020, 10, replace = TRUE)
cases <- sample(100:1000, 10)
population <- sample(1000000:10000000, 10)

# Create the tibble
data <- tibble(
  country = sample(country, 10, replace = TRUE),
  year = year,
  cases = cases,
  population = population
)

# Print the tibble
print(data)

# Question 8b
library(tidyr)  #For pivot longer function

# Assuming 'data' is the tibble created in the previous example

# Transform to long format
data_long <- data %>%
  pivot_longer(cols = c(cases, population),
               names_to = "variable",
               values_to = "value")

# Print the long format data
print(data_long)

#Question 8c
library(dplyr)
# Transform cases and population to natural log scale
data_transformed <- data %>%
  mutate(ln_cases = log(cases),
         ln_population = log(population)) %>%
  select(-cases, -population)  # Remove original columns if not needed

# Print the transformed data
print(data_transformed)


#Question 8d

#Scatter Plot of Cases vs Population
plot(data$cases, data$population,
     xlab = "Cases", ylab = "Population",
     main = "Scatter Plot of Cases vs Population")

#Scatter Plot of ln_cases vs Population
plot(data_transformed$ln_cases, data_transformed$ln_population,
     xlab = "ln(Cases)", ylab = "Population",
     main = "Scatter Plot of ln(Cases) vs Population")

# 3. Scatter Plot of Cases vs ln_population
plot(data$cases, data_transformed$ln_population,
     xlab = "Cases", ylab = "ln(Population)",
     main = "Scatter Plot of Cases vs ln(Population)")

#Scatter Plot of ln_cases vs ln_population
plot(data_transformed$ln_cases, data_transformed$ln_population,
     xlab = "ln(Cases)", ylab = "ln(Population)",
     main = "Scatter Plot of ln(Cases) vs ln(Population)")

#Question 8 e
par(mfrow = c(2, 2))
#Scatter Plot of Cases vs Population
plot(data$cases, data$population,
     xlab = "Cases", ylab = "Population",
     main = "Scatter Plot of Cases vs Population")

#Scatter Plot of ln_cases vs Population
plot(data_transformed$ln_cases, data_transformed$ln_population,
     xlab = "ln(Cases)", ylab = "Population",
     main = "Scatter Plot of ln(Cases) vs Population")

# 3. Scatter Plot of Cases vs ln_population
plot(data$cases, data_transformed$ln_population,
     xlab = "Cases", ylab = "ln(Population)",
     main = "Scatter Plot of Cases vs ln(Population)")

#Scatter Plot of ln_cases vs ln_population
plot(data_transformed$ln_cases, data_transformed$ln_population,
     xlab = "ln(Cases)", ylab = "ln(Population)",
     main = "Scatter Plot of ln(Cases) vs ln(Population)")


par(mfrow = c(1, 1))

# 2080 1st assement

#Question 10 OR
#Question a
getwd()
install.packages("topicmodels")
install.packages("pdftools")
library(pdftools)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(topicmodels)
# Specify the path to your PDF file
#Question b
pdf_file <- "Intro R.pdf"


library(tm)
#Question c
# Extract text from PDF using pdftools
pdf_text <- pdf_text(pdf_file)

# Convert the text into a corpus using tm package
corpus <- Corpus(VectorSource(pdf_text))

# Preprocessing: Convert to lower case, remove numbers and punctuation
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, stopwords("en"))  # Remove English stopwords

# Strip whitespace
corpus <- tm_map(corpus, stripWhitespace)
corpus<-tm_map(corpus,stemDocument)

#Question d
# Create Document Term Matrix
myTdm<- TermDocumentMatrix(corpus,control = list(wordLengths=c(1,Inf)))


# Get term frequencies
(freq.terms<-findFreqTerms(myTdm,lowfreq = 150))

# Subset term frequencies for most frequent terms
m<-as.matrix(myTdm)
# Sort frequencies in descending order
(freq<-sort(rowSums(m),decreasing = T))

new_freq<-freq[freq>50]
new_freq
# Extract words (terms) and their frequencies
words <- names(new_freq)
words

max(freq)
# Create histogram
hist(new_freq, 
     main = "Histogram of Frequency for Most Frequent Terms",
     xlab = "Frequency",
     ylab = "Number of Terms",
     col = "skyblue",  # Specify color if desired
     xlim = c(0, max(new_freq) + 5),  # Adjust x-axis limits to have some padding
     las = 1,  # Orientation of axis labels
     breaks = 5)  # Number of bins


# Create barplot #Better
barplot(new_freq, 
        main = "Frequency of Most Frequent Terms",
        xlab = "Terms",
        ylab = "Frequency",
        names.arg = words,  # Display words on x-axis
        las = 2,  # Rotate x-axis labels if needed
        col = "skyblue")  # Specify color if desired


#Question e
# Generate word cloud
set.seed(34)  # For reproducibility
wordcloud(words = names(new_freq),
          freq = new_freq,
          min.freq = 10,  # Minimum frequency threshold for inclusion
          max.words = 100,  # Maximum number of words in cloud
          random.order = FALSE,  # Order words by frequency
          colors = brewer.pal(8, "Dark2"))  # Color palette from RColorBrewer package

#Question f

# Perform Topic Modeling (LDA)
# Create Document Term Matrix (DTM)
dtm <- DocumentTermMatrix(corpus)
myTdm<- TermDocumentMatrix(corpus,control = list(wordLengths=c(1,Inf)))
# Perform Topic Modeling (LDA)
k <- 5  # Number of topics
lda_model <- LDA(myTdm, k = k, method = "Gibbs", control = list(seed = 34))

# Get terms for each topic
terms <- terms(lda_model, 10)  # Extract top 10 terms for each topic
terms

#Interpretation: Latent Dirichlet Allocation is a statistical model used to identify 
# topics in a collection of text documents. It assigns each word in the 
# corpus to a topic based on the probability distribution.



#2081 first reassement 
#6

#a
R <- 1:15

R <- seq(1, 15)

R <- c(1:15)
R

#b
N <- c(1.1, 2.2, 3.3, 4.4, 5.5)

#c
addition <- N + R
addition

subtraction <- N - R
subtraction

multiplication <- N * R
multiplication

division <- N / R
division


#d
L <- list("This", "is", "my", "first", "programming", "in", "R")
L





# 2080  7

rating<- c(9,2,5,8,6,1,3,2,8,4,6,8,7,1,2,6,10,5,6,9,6,2,4,7)

rating<-as.factor(rating)
str(rating)
rating<-sort(rating)
valid<-levels(rating)

valid
table(rating)

frequency<-as.numeric(table(rating))
frequency

percent<-round(as.numeric(frequency/sum(frequency)*100),1)
percent

valid_percent<-round(as.numeric(frequency/length(rating)*100),1)
valid_percent



cumulative_percent<-round(cumsum(as.numeric(frequency/sum(frequency)*100)),1)
cumulative_percent

data_frame<-data.frame(
  valid,
  frequency,
  percent,
  valid_percent,
  cumulative_percent
)
data_frame

total<-c("Total",sum(frequency),round(sum(percent),0),round(sum(valid_percent),0),"")
total
data_frame<-rbind(data_frame,total)
data_frame




# Assessment 2081
#Question 6 
# Question a

library(ggplot2)
library(dplyr)
library(tidyr)
set.seed(35)
data <- tibble(
  age = sample(10:99,
               size = 200,
               replace = TRUE),
  sex = sample(c("Male", "Female"),
               size = 200,
               replace = TRUE),
  educational_level = sample(c("No education", "Primary", "Secondary", "Beyond Secondary"),
                             size = 200,
                             replace = TRUE),
  socio_economic_status = sample(c("Low", "Middle", "High"),
                                 size = 200,
                                 replace = TRUE),
  body_mass_index = sample(14:38,
                           size = 200,
                           replace = TRUE)
)
# Question b

ggplot(data, aes(x = age, y = body_mass_index)) +
  geom_point() +
  labs(title = "Scatterplot of Age vs Body Mass Index",
       x = "Age",
       y = "Body Mass Index")

# Question c

data <- data %>%
  mutate(bmi_class = case_when(
    body_mass_index < 18 ~ "<18",
    body_mass_index >= 18 & body_mass_index <= 24 ~ "18-24",
    body_mass_index >= 25 & body_mass_index <= 30 ~ "25-30",
    body_mass_index > 30 ~ "30+"
  ))
bmi_class_counts <- data %>%
  count(bmi_class)
ggplot(bmi_class_counts,
       aes(x = "",
           y = n,
           fill = bmi_class)) +
  geom_bar(stat = "identity",
           width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Pie Chart of BMI Classes") +
  theme_void()

# Question d
ggplot(data, aes(x = age)) +
  geom_histogram(binwidth = 15, fill = "green", color = "black") +
  labs(title = "Histogram of Age",
       x = "Age",
       y = "Frequency")


