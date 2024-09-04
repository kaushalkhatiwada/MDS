
#GGplot layer layer layer
#-----UU----------------------
library(ggplot2)
ggplot(data=diamonds,mapping=aes(x=carat,y=price))+
  geom_point(stat = "identity",position = "identity")+
  scale_x_continuous()+scale_y_continuous()+
  coord_cartesian()+
  labs(title="Scatter plot of price and carat")



# final 2078 6   (histogram, vertical abline, QQ, density plot)
#-------UU-----------
set.seed(1)
mpg<-sample(c(10:50),500,replace = TRUE)
hist(mpg)
hist(mpg,col="blue",border = "white",breaks=8)
abline(v=mean(mpg),col="green")
qqnorm(mpg)
qqline(mpg,col="red")
# data are scatterd and it is randomally distributed
ks.test(mpg,"pnorm")

plot(density(mpg),col="yellow",frame=FALSE)
polygon(density(mpg),col="yellow")


#First assesstment question number 8 (tibble, transform, four graph scatter plot)
#-------UU------------
library(tidyverse)
set.seed(13)
# a) create tibble with randomly Generated data
country <- c("Nepal", "India", "France")
year <- sample(2000:2020, 10, replace = TRUE)
cases <- sample(100:1000, 10)
population <- sample(1000000:10000000, 10)
data <- tibble(
  country = sample(country, 10, replace = TRUE),
  year = year,
  cases = cases,
  population = population
)
# b) transform wider format to longer format
library(tidyr)  #For pivot longer function
data_long <- data %>%
  pivot_longer(cols = c(cases, population),
               names_to = "variable",
               values_to = "value")
print(data_long)

# c) Transform cases and population to natural log scale
library(dplyr)
data_transformed <- data %>%
  mutate(ln_cases = log(cases),
         ln_population = log(population)) %>%
  select(-cases, -population)  # Remove original columns if not needed
print(data_transformed)

# d) Scatter plot
#Cases vs Population
plot(data$cases, data$population,xlab = "Cases", ylab = "Population",main = "Scatter Plot of Cases vs Population")
#ln_cases vs Population
plot(data_transformed$ln_cases, data_transformed$ln_population,xlab = "ln(Cases)", ylab = "Population",main = "Scatter Plot of ln(Cases) vs Population")
#Cases vs ln_population
plot(data$cases, data_transformed$ln_population,xlab = "Cases", ylab = "ln(Population)",main = "Scatter Plot of Cases vs ln(Population)")
#ln_cases vs ln_population
plot(data_transformed$ln_cases, data_transformed$ln_population,xlab = "ln(Cases)", ylab = "ln(Population)",main = "Scatter Plot of ln(Cases) vs ln(Population)")

# e) 
par(mfrow = c(2, 2))
#Scatter Plot of Cases vs Population
plot(data$cases, data$population,xlab = "Cases", ylab = "Population",main = "Scatter Plot of Cases vs Population")
#Scatter Plot of ln_cases vs Population
plot(data_transformed$ln_cases, data_transformed$ln_population,xlab = "ln(Cases)", ylab = "Population",main = "Scatter Plot of ln(Cases) vs Population")
#Scatter Plot of Cases vs ln_population
plot(data$cases, data_transformed$ln_population,xlab = "Cases", ylab = "ln(Population)",main = "Scatter Plot of Cases vs ln(Population)")
#Scatter Plot of ln_cases vs ln_population
plot(data_transformed$ln_cases, data_transformed$ln_population,xlab = "ln(Cases)", ylab = "ln(Population)",main = "Scatter Plot of ln(Cases) vs ln(Population)")
par(mfrow = c(1, 1))


# First assesstment question number 9 (graph and plots)
#---------KK-----------
df <- mtcars
# a) histogram of mpg variable
hist(df$mpg)
# b) 
hist(df$mpg,col = 'blue', breaks=10)
# c) vertical abline at mean
abline(v=mean(df$mpg), color='red',lwd=3,lty=2)
# d) QQ plot and QQ line of mpg
qqnorm(df$mpg)
qqline(df$mpg, col='red', lwd=3)
# e) density plot
plot(density(df$mpg), type='n')
polygon(density(df$mpg), col='yellow', border = NA)



# Second assessment question number 6 (Graph and plot)
#-------KK-----------

library(ggplot2)
set.seed(13)

# A) Generate data
age <- sample(10:99, 200, replace = TRUE)
sex <- sample(c("Male", "Female"), 200, replace = TRUE)
education <- sample(c("No education", "Primary", "Secondary", "Beyond secondary"), 200, replace = TRUE)
socioeconomic_status <- sample(c("Low", "Middle", "High"), 200, replace = TRUE)
bmi <- sample(14:38, 200, replace = TRUE)

# B) scatter plot of age and body mass index
ggplot(data = data.frame(age, bmi), aes(x = age, y = bmi)) +
  geom_point() +
  labs(x = "Age", y = "BMI", title = "Relationship between Age and BMI")
## Interpret: No trend is seen from the data that means the data is well spread

# C) Pie chart 
bmi_class <- cut(bmi, breaks = c(0, 18, 24, 30, Inf), labels = c("<18", "18-24", "25-30", "30+"))
ggplot(data.frame(bmi_class), aes(x = "", fill = bmi_class)) +
  geom_bar(width = 1) +
  coord_polar("y", start = 0) +
  labs(title = "Distribution of BMI Classes") +
  theme_void() +
  theme(legend.position = "right")
## From the pie chart we can see the maximum part of the data is covered by group 25-30 and 30+ 
#and minimum part of the data is from <18 

# D) histogram of age
ggplot(data.frame(age), aes(x = age)) +
  geom_histogram(binwidth = 15, fill = "steelblue", color = "white") +
  labs(x = "Age", y = "Count", title = "Distribution of Age") +
  theme_classic()
#From above plot we can see that all the data has similar frequency except highest one


# second re question number 6
#--------PRABHAT----------
# a) generate data set
set.seed(13)
dataset <- data.frame(
  age = sample(c(20:59), 150, replace = T),
  height = sample(c(110:190), 150, replace = T),
  weight = sample(c(40:90), 150, replace = T)
)
head(dataset)

# b) Compute BMI (The formula should be BMI = weight in kg/height in m squared) but according to the question i have applied it.
dataset$bmi <- dataset$weight / ((dataset$height)/100)^2

# c) Categorizing bmi as underweight, normal, overweight,obese
dataset$bmi_category <- ifelse(dataset$bmi < 18, 'underweight', 
                               ifelse(dataset$bmi <= 24, 'normal',
                                      ifelse(dataset$bmi <= 30), 'overweight', 'obese'))
head(dataset)

#d)  pie chart
library(ggplot2)
# Create a summary data frame
bmi_summary <- as.data.frame(table(dataset$bmi_category))
colnames(bmi_summary) <- c("Category", "Frequency")
# Calculate percentages
bmi_summary$Percentage <- (bmi_summary$Frequency / sum(bmi_summary$Frequency)) * 100
# Create a pie chart
ggplot(bmi_summary, aes(x = "", y = Frequency, fill = Category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  theme_void() +
  labs(title = "BMI Categories Distribution") +
  theme(legend.position = "right") +
  geom_text(aes(label = paste0(round(Percentage, 1), "%")),
            position = position_stack(vjust = 0.5))


# 2080 2nd assessment 7 (clone Table)
-UU----------------------------------------

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


##### 2080 6
set.seed(1)
# Number of cases
num_cases <- 150
# Generate random data for each variable
age <- sample(18:99, num_cases, replace = TRUE)
sex <- sample(c("male", "female"), num_cases, replace = TRUE)
education_levels <- sample(c("No education", "Primary", "Secondary", "Beyond Secondary"), num_cases, replace = TRUE)
soc_eco_status <- sample(c("Low", "Middle", "High"), num_cases, replace = TRUE)
bmi <- sample(14:38, num_cases, replace = TRUE)
str(factor(bmi))
str(sex)
str(factor(sex))
table(factor(sex))
table(bmi)
table(factor(bmi))
# Create a data frame
data <- data.frame(
  Age = age,
  Sex = sex,
  EducationLevel = education_levels,
  SocioEconomicStatus = soc_eco_status,
  BMI = bmi
)
head(data)
head(data$BMI)
str(data)

#6 b
# sub-divided bar diagram
ggplot(data=data,mapping=aes(x=BMI,fill=SocioEconomicStatus))+
  geom_bar()
# The given sub divided grpah for BMI with respect to socioEconomicstatus 
# Each BMi is partitioned into each socio economic status
# Indivisual BMi doesn't show any pattern with respect to socioEconomicstatus
# We cannot draw any definite conclusion.
# For BMI =20,people belonging to  socioEconomicstatus of middle and low.
ggplot(data=data,mapping=aes(x=BMI,fill=Sex))+
  geom_bar()
# For most of the data each BMi are of both sex category.
# for eg: BMI=15 seems to have equal proportion of male and female
#6 c

ggplot(data=data,mapping=aes(x=Age,fill=Sex))+
  geom_bar(position="dodge")
# Given multiple bar digaram shows the  distribution of age with respect to
# sex. We cannot see any patterns. Some of the data of Age are missing so 
# we can see gaps in the multiple bar graph.
ggplot(data=data,mapping=aes(x=Age,fill=EducationLevel))+
  geom_bar(position="dodge_2")
# 6 d
ggplot(data=data,mapping=aes(y=Age))+
  geom_boxplot()
ggplot(data=data,mapping=aes(y=BMI))+
  geom_boxplot()
#using base R
boxplot(data$Age)

summary(data$Age)
# From We can obtain Q2=,min=,max=,Q1=,Q3=...
boxplot(data$BMI)

ggplot(data=data,mapping=aes(x=Age))+
  geom_histogram(color="white",fill="red",bins=15)
hist(data$Age)
# Given data is not normally distributed and highest number of 
# data is present in 50 to 60 and minimum in below 20
summary(data$Age)

table(mtcars$mpg)
table(data$Age)

boxplot(data$Age)
boxplot(data$BMI) 
################################################################################



# PROJECT 3 ( more than ogive and less than ogive, Histogram and find the mode )

aq<-airquality
aq$Temp

### Hint 1: Divide the “Temp” variable into different class intervals using a statistical rule and get number of frequencies in each class interval

num_intervals <- ceiling(log2(length(aq$Temp)) + 1)
# Defining the number of intervals using a statistical rule (Sturges' formula)

aq_intervals <- cut(aq$Temp, breaks = num_intervals)
# Creating intervals using the cut() function

aq_interval_freq <- table(aq_intervals)
aq_interval_freq
# Calculating frequencies in each interval using the table() function

### Hint 2: Get less than frequency data for less than ogive

cumulative_freq <- cumsum(aq_interval_freq)
cumulative_freq
cumulative_freq2 <- cumsum(rev(aq_interval_freq))
cumulative_freq2
# Calculate cumulative frequencies


upper_boundaries <- as.numeric(sub("\\((.*),.*\\]", "\\1", names(cumulative_freq)))
upper_boundaries
# Geting  the upper class boundaries of the intervals using regular expression


max_upper_boundary <- max(upper_boundaries)
max_upper_boundary
min_upper_boundary<-min(upper_boundaries)
min_upper_boundary
# Get the maximum and minimum upper boundary

### hint 3 : Get more than frequency data for more than ogive
rev_upper_boundaries<-rev(upper_boundaries)
rev_cumulative_freq<-rev(cumulative_freq2)

library(ggplot2)

df_more_than <- data.frame(Upper_Class_Boundary = upper_boundaries, Cumulative_Frequency = rev_cumulative_freq)
df_less_than <- data.frame(Upper_Class_Boundary = upper_boundaries, Cumulative_Frequency = cumulative_freq)

common_xlim <- c(min(min_upper_boundary, rev_upper_boundaries), max(max_upper_boundary, upper_boundaries))

ggplot() +
  geom_line(data = df_more_than, aes(x = Upper_Class_Boundary, y = Cumulative_Frequency), color = "blue") +
  geom_line(data = df_less_than, aes(x = Upper_Class_Boundary, y = Cumulative_Frequency), color = "red") +
  labs(x = "Upper Class Boundary", y = "Cumulative Frequency", 
       title = "Ogive Comparison") +
  xlim(common_xlim)+
  geom_vline(xintercept = median(aq$Temp))

# Create data frames
# Plot the Ogives
# Determine the common xlim for both plots
# Plot the Ogives with the same xlim

### hint 5 : Intersection of less than and more than ogive in the x-axis is the median
median(aq$Temp)
# from ogive comparison the intersection was found around 77 which is not exact as median itself.


# Q2
### hint 7 : Get histogram of “Temp” variable

hist(aq$Temp, xlab = "Temperature", ylab = "Frequency", main = "Histogram of Temperature")
# Plotting histogram of 'Temp' variable

### hint 8 : Draw a diagonal line from en edge of the largest bar to the tip of the opposite adjacent bar


hist_data <- hist(aq$Temp, plot = FALSE)
# Creating histogram

max_freq_index <- which.max(hist_data$counts)
max_freq_index
# Finding the index of the bin with the highest frequency

left_bin <- max_freq_index - 1
left_bin
right_bin <- max_freq_index + 1
right_bin
# Determining the adjacent bins to the left and right of the highest frequency bin


x_left1 <- hist_data$breaks[left_bin + 1]  
x_right1 <- hist_data$breaks[max_freq_index + 1] 
y_max <- max(hist_data$counts)
y_left1 <- hist_data$counts[left_bin]
y_right1 <- hist_data$counts[max_freq_index]
# Calculating coordinates for the diagonal line from the edge of the largest bar to the tip of the opposite adjacent bar

segments(x_left1, y_left1, x_right1, y_right1, col = "blue")
# plotting 1st diagonal line


### hint 9: Draw another diagonal line from other edge of the largest bar to the tip of of the opposite adjacent bar
x_left2 <- hist_data$breaks[max_freq_index]  # Other edge of the largest bar
x_right2 <- hist_data$breaks[right_bin]  # Tip of the opposite adjacent bar
y_left2 <- hist_data$counts[max_freq_index]
y_right2 <- hist_data$counts[right_bin]
# Calculating coordinates for the diagonal line from the other edge of the largest bar to the tip of the opposite adjacent bar

segments(x_left2, y_left2, x_right2, y_right2, col = "blue")
# plotting 2nd diagonal line


### hint 10 : Intersection of the two diagonal lines in the x-axis in the mode

slope1 <- (y_right1 - y_left1) / (x_right1 - x_left1)
slope2 <- (y_right2 - y_left2) / (x_right2 - x_left2)
# Calculate the slopes of the two lines

intercept1 <- y_left1 - slope1 * x_left1
intercept2 <- y_left2 - slope2 * x_left2
# Calculate the y-intercepts of the two lines

intersection_x <- (intercept2 - intercept1) / (slope1 - slope2)
intersection_x
# Calculate the intersection point

abline(v = intersection_x, col = "red", lty = 2)
# Plot vertical line at intersection point

### hint 11: Check this value with mode code of R
mode(aq$Temp)
freq_table <- table(aq$Temp)
mode <- as.numeric(names(freq_table)[freq_table == max(freq_table)])
mode
intersection_x
abline(v = mode, col = "green")

# two values from graph and median are similar but not exact