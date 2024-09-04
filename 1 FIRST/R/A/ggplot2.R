# Load the ggplot2 package
library(ggplot2)

  # View the first few rows of the mtcars dataset
head(mtcars)

# Create a scatter plot with ggplot2
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  labs(title = "Scatter plot of Car Weight vs. MPG",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon (MPG)")


ggplot(data = mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed", color = "black") +
  labs(title = "Scatter plot of Car Weight vs. MPG",
       subtitle = "Colored by Number of Cylinders",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon (MPG)",
       color = "Cylinders") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))


# Bar plot of the number of cars with different numbers of cylinders
ggplot(data = mtcars, aes(x = factor(cyl))) +
  geom_bar(fill = "skyblue") +
  labs(title = "Count of Cars by Number of Cylinders",
       x = "Number of Cylinders",
       y = "Count") +
  theme_minimal()


# Box plot of miles per gallon by number of cylinders
ggplot(data = mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_boxplot(fill = "orange", color = "black") +
  labs(title = "Box Plot of MPG by Number of Cylinders",
       x = "Number of Cylinders",
       y = "Miles Per Gallon (MPG)") +
  theme_minimal()


# Histogram of miles per gallon
ggplot(data = mtcars, aes(x = mpg)) +
  geom_histogram(binwidth = 2, fill = "purple", color = "white") +
  labs(title = "Histogram of Miles Per Gallon (MPG)",
       x = "Miles Per Gallon (MPG)",
       y = "Count") +
  theme_minimal()


# Density plot of miles per gallon
ggplot(data = mtcars, aes(x = mpg)) +
  geom_density(fill = "green", alpha = 0.5) +
  labs(title = "Density Plot of Miles Per Gallon (MPG)",
       x = "Miles Per Gallon (MPG)",
       y = "Density") +
  theme_minimal()


# Line plot of horsepower vs. weight
ggplot(data = mtcars, aes(x = wt, y = hp)) +
  geom_line(color = "blue") +
  labs(title = "Line Plot of Horsepower vs. Weight",
       x = "Weight (1000 lbs)",
       y = "Horsepower (HP)") +

    theme_minimal()

# Scatter plot with facets for each number of cylinders
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  facet_wrap(~ cyl) +
  labs(title = "Scatter Plot of Car Weight vs. MPG",
       subtitle = "Faceted by Number of Cylinders",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon (MPG)") +
  theme_minimal()

# piechart

# Load the necessary packages
library(ggplot2)
library(dplyr)

# Aggregate the data
cyl_data <- mtcars %>%
  count(cyl) %>%
  mutate(percentage = n / sum(n) * 100)

# Create the pie chart
ggplot(cyl_data, aes(x = "", y = percentage, fill = factor(cyl))) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  labs(title = "Pie Chart of Car Cylinders",
       fill = "Cylinders",
       y = "Percentage") +
  theme_void() +  # This removes the background and axis
  theme(plot.title = element_text(hjust = 0.5))

# Load the necessary package
library(ggplot2)

# Aggregate the data by gear and cylinder
mtcars$gear <- factor(mtcars$gear) # Convert gear to a factor for better labeling
mtcars$cyl <- factor(mtcars$cyl)   # Convert cyl to a factor for better labeling


#sub divided
# Create the stacked bar chart
ggplot(mtcars, aes(x = gear, fill = cyl)) +
  geom_bar(position = "stack") +
  labs(title = "Stacked Bar Chart of Gears and Cylinders",
       x = "Number of Gears",
       y = "Count",
       fill = "Number of Cylinders") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))


# Load necessary package
library(ggplot2)
library(dplyr)

# Categorize Age into groups
data <- data %>%
  mutate(Age_Group = cut(Age, 
                         breaks = c(18, 30, 40, 50, 60, 70, 80, 90, 100),
                         labels = c("18-29", "30-39", "40-49", "50-59", "60-69", "70-79", "80-89", "90+")))

# Display the first few rows of the updated dataset
head(data)

# Create the grouped bar chart of Age Groups by Sex and Education Level
ggplot(data, aes(x = Age_Group, fill = Sex)) +
  geom_bar(position = "dodge") +
  labs(title = "Grouped Bar Chart of Age Groups by Sex",
       x = "Age Group",
       y = "Count",
       fill = "Sex") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))


