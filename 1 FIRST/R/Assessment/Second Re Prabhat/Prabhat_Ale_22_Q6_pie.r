

# Q.6)
# a)
set.seed(22)
dataset <- data.frame(
  age = sample(c(20:59), 150, replace = T),
  height = sample(c(110:190), 150, replace = T),
  weight = sample(c(40:90), 150, replace = T)
)


head(dataset)


# b) Compute BMI (The formula should be BMI = weight in kg/height in m squared) but according to the question i have applied it.
dataset$bmi <- dataset$weight / (dataset$height)^2




# c) Categorizing bmi
dataset$bmi_category <- ifelse(dataset$bmi < 18, 'underweight', ifelse(dataset$bmi <= 24, 'normal',
                                                               ifelse(dataset$bmi <= 30), 'overweight', 'obese'))

head(dataset)




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


## If bmi is computed using a formula (BMI = weight in kg/height in m^2 ) then

# b) Compute BMI (The formula should be BMI = weight in kg/height in m squared) but according to the question i have applied it.
dataset$bmi <- dataset$weight / ((dataset$height)/100)^2




# c) Categorizing bmi
# Calculate BMI
dataset$bmi <- dataset$weight / ((dataset$height)/100)^2

# Categorize BMI
dataset$bmi_category <- ifelse(dataset$bmi < 18, 'underweight', 
                               ifelse(dataset$bmi <= 24, 'normal',
                                      ifelse(dataset$bmi <= 30, 'overweight', 'obese')))

head(dataset)




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


