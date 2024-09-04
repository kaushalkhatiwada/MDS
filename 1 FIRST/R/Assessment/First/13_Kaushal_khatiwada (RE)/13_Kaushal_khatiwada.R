
########### 2078 First assessment Q no 6
#### A)
#Using Vector
r<-c(1:15)
r
#Using list
l<- list(1:15)
l
#Using Array
a<-array(1:15)
a

#### B)
N<- c(1.1,2.2,3.3,4.4,5.5)
N
str(N)
#It is of numeric data type

#### C)
add <- r+N
add
subtract <- N-r
subtract
multiply <- N*r
multiply
divide <- N/r
divide
#Interpret: Since, the size of vector N is 5 and r=5 the vector operation is repeated even the size is not matched
# Vector r repeatedly does operation with N

#### D)
#List is defined as the data type which can hold the value of same or different data type
L<- list("This","is","my","first","programming","in","R")
L

#### E) Transform list as character
UL <- lapply(L, as.character)
UL



########### 7
#### A)
aq <- airquality
str(aq)
  
# Ozone  : integer
# Solar.R: integer
# Wind   : numeric
# Temp   : integer
# Month  : integer
# Day    : integer

#### B)

#### C)
summary(aq)

#### D)
library(dplyr)
temp <- aq$Temp
 



########### 8
#### A) 
barplot(aq$Month)

#### B)
hist(aq$Temp)

#### C)
plot(aq$Temp,aq$Day,type="o")

#### D)
plot(aq$Ozone,aq$Solar.R)



########### 9

#### A)
country_data <- tibble(
  Country = c("USA", "Nepal", "UK", "Germany", "France", 
              "Italy", "Spain", "Japan", "China", "Australia",
              "USA", "Nepal", "UK", "Germany", "France", 
              "Italy", "Spain", "Japan", "China", "Australia"),
  Year = c(2020, 2021, 2022, 2020, 2021, 
           2022, 2020, 2021, 2022, 2020,
           2020, 2021, 2022, 2020, 2021, 
           2022, 2020, 2021, 2022, 2020),
  Cases = c(10000, 12000, 15000, 8000, 9500, 
            11000, 7500, 8200, 10500, 6000,
            10000, 12000, 15000, 8000, 9500, 
            11000, 7500, 8200, 10500, 6000),
  Population = c(330000000, 37000000, 67000000, 83000000, 67000000, 
                 60000000, 47000000, 126000000, 1400000000, 25000000,
                 330000000, 37000000, 67000000, 83000000, 67000000, 
                 60000000, 47000000, 126000000, 1400000000, 25000000)
)

##### B) 
country_data$LnCase <- log(country_data$Cases)
country_data$LnPop <- log(country_data$Population)


##### C)
plot(country_data$Cases, country_data$Population)
plot(country_data$LnCase, country_data$Population)
plot(country_data$Cases, country_data$LnPop)
plot(country_data$LnCase, country_data$LnPop)

##### D)
par(mfrow=c(2,2))
plot(country_data$Cases, country_data$Population, main = "Cases Vs Population", xlab='Cases',ylab = 'Population',)
plot(country_data$LnCase, country_data$Population,main = "LnCases Vs Population", xlab='LnCases',ylab = 'Population')
plot(country_data$Cases, country_data$LnPop, main = "Cases Vs LnPopulation",xlab='Cases',ylab = 'LnPopulation')
plot(country_data$LnCase, country_data$LnPop,main = "LnCases Vs LnPopulation", xlab='LnCases',ylab = 'LnPopulation')
par(mfrow=c(1,1))

########### 10

library(igraph)

##### A)
g <- graph(c(1,2))
plot(g)

#### B)
g1 <- graph(c("S","R","R","G","G","S","S","G","A","R"))

##### C)
plot(g1, 
     vertex.color='green',
     vertex.size=30,
     edge.size=5,
     edge.color='red')

##### D)
# degree is number of connections for each node. All "S", "R","G" have same degree i.e 3
degree(g1)

# closeness
closeness(g1)

# Betweeness
betweenness(g1)






