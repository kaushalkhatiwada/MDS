data(airquality)

shapiro.test(airquality$Temp)

# p-value = 0.009319 < 0.05, hence it does not follow the normal distribution

data <- airquality[, c("Temp", "Month")]
row_names <- row.names(data)

# Step 2: Standardize the data
data_standardized <- scale(data)

# Step 3: Assign row names back to the standardized data
rownames(data_standardized) <- row_names

classical_state_disimilarity <- dist(data_standardized)
classical_mds <- cmdscale(classical_state_disimilarity)
summary(classical_mds)

# Perform Shapiro-Wilk test for each month separately
months <- unique(airquality$Month)

for (month in months) {
  temp_values <- airquality$Temp[airquality$Month == month]
  result <- shapiro.test(temp_values)
  cat("Shapiro-Wilk Test for Temp in Month", month, ":\n")
  print(result)
  cat("\n")
}

library(dplyr)
library(purrr)

# Group data by 'Month' and perform Shapiro-Wilk test on 'Temp'
results <- airquality %>%
  group_by(Month) %>%
  summarise(test_result = list(shapiro.test(Temp)))

# Print the results
results %>%
  mutate(p_value = map_dbl(test_result, "p.value")) %>%
  select(-test_result)

# Interpretation: P-value for each month is above 0.005 hence we can conclude that the data are normally distributed
