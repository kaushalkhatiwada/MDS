
# Use “Groceries” data available in the “datasets” package to do as follows in R Studio to knit PDF output
head(Groceries)
# a.	
# Load “arules” and “arulesViz” libraries
library(arules)
library(arulesViz)

# b.	
# Load “Groceries” data, check its structure and interpret it carefully
data(Groceries)
str(Groceries)

# c.	
# Get Frequent Item frequencies using itemFrequencyPlot function and interpret it carefully
itemFrequencyPlot(Groceries, topN=20, type="absolute")

# Whole milk is Frequenty used item


# d.	
# Set a priori rule with support = 0.001 and confidence = 0.8 and interpret the output carefully
apriori_rule <- apriori(Groceries, 
                        parameter = list(supp = 0.001, 
                                         conf = 0.8,
                                         maxlen=10,
                                         target="rules"))



# e.	
# Show the top five rules using inspect and round the results to two digits
five_rules<- inspect(apriori_rule[1:5])



# f.	
# Sort the rule by confidence in decreasing order
sorted_rules <- sort(apriori_rule, by = "confidence", decreasing = TRUE)
inspect(sorted_rules[1:5])


# g.	
# Use “whole milk” as target item and show the items in “lhs” with decreasing order of confidence and show the top five rules
milk_rule <- apriori(Groceries, 
                       parameter = list(supp = 0.001, 
                                        conf = 0.8),
                                          appearance = list(default="lhs", rhs="whole milk"))


milk_sorted_rules <- sort(milk_rule, by = "confidence", decreasing = TRUE)
inspect(milk_sorted_rules[1:5])

# h.	
# Use “whole milk” as target item and show the items in “rhs” with decreasing order of confidence and show the top five rules
milk_rule1 <- apriori(Groceries, 
                     parameter = list(supp = 0.001, 
                                      conf = 0.8),
                     appearance = list(lhs="whole milk", default="rhs"))


milk_sorted_rules1 <- sort(milk_rule1, by = "confidence", decreasing = TRUE)
inspect(milk_sorted_rules1[1:5])

# i.	
# Write summary and conclusion based on your findings above
















#### Filter rules with 'whole milk' in rhs
milk_rules <- subset(rules, rhs %in% "whole milk")

#### Sort rules by confidence in decreasing order
sorted_milk_rules <- sort(milk_rules, by = "confidence", decreasing = TRUE)

#### Inspect the top 5 rules
inspect(sorted_milk_rules[1:5])

#### Function to inspect rules with rounded values
inspect_rules_rounded <- function(rules, digits = 2) {
  rules_df <- as(rules, "data.frame")
  rules_df[, c("support", "confidence", "lift")] <- round(rules_df[, c("support", "confidence", "lift")], digits)
  return(rules_df)
}

#### Inspect and print the top 5 rules with rounded values
inspect_rules_rounded(sorted_milk_rules[1:5])


