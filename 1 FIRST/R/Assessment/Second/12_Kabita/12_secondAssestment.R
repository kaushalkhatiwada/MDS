#a)

# Load necessary libraries
library(ggplot2)
library(dplyr)

# Set random seed using the 12 roll number (e.g., 123456)
set.seed(12)

# Generate the dataset
n <- 200

data <- data.frame(
  age = sample(10:99, n, replace = TRUE),
  sex = sample(c("Male", "Female"), n, replace = TRUE),
  educational_level = sample(c("No education", "Primary", "Secondary", "Beyond Secondary"), n, replace = TRUE),
  socioeconomic_status = sample(c("Low", "Middle", "High"), n, replace = TRUE),
  bmi = runif(n, 14, 38)
)

# Display the first few rows of the dataset
head(data)

 #b)

# Scatterplot of Age and BMI
ggplot(data, aes(x = age, y = bmi)) +
  geom_point() +
  labs(title = "Scatterplot of Age and BMI", x = "Age (years)", y = "BMI") +
  theme_minimal()

#c)# Classify BMI into categories
data <- data %>%
  mutate(bmi_class = case_when(
    bmi < 18 ~ "<18",
    bmi >= 18 & bmi < 24 ~ "18-24",
    bmi >= 24 & bmi < 30 ~ "25-30",
    bmi >= 30 ~ "30+"
  ))

# Count the number of cases in each BMI class
bmi_counts <- data %>%
  group_by(bmi_class) %>%
  summarize(count = n())

# Pie chart of BMI classes
ggplot(bmi_counts, aes(x = "", y = count, fill = bmi_class)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Pie Chart of BMI Classes", x = "", y = "") +
  theme_minimal() +
  theme(axis.ticks = element_blank(), axis.text = element_blank())

#d)
# Histogram of Age with bin size 15
ggplot(data, aes(x = age)) +
  geom_histogram(binwidth = 15, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of Age", x = "Age (years)", y = "Frequency") +
  theme_minimal()


