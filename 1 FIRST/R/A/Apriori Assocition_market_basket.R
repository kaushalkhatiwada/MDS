market_basket<-
  list(
    c("bread","milk"),
    c("bread","diapers","beer","Eggs"),
    c("milk","diapers","beer","cola"),
    c("bread","milk","diapers","beer"),
    c("bread","milk","diapers","cola")
  )

# set transaction names (T1 to T5)
names(market_basket)<-paste("T",c(1:5),sep="")

install.packages("arules")
library(arules)
install.packages("arulesViz")
library(arulesViz)

# Transformation
trans<-as(market_basket,"transactions")

# Dimensions
dim(trans)
trans

# item labels
itemLabels(trans)

#Summary
summary(trans)

# PLot
image(trans)

inspect(trans)

# Apriori algorithm

# Min Support 0.3, confidence as 0.5

rules<-apriori(
  trans,
  parameter = list(supp=0.3,conf=0.5,
                   maxle=10,
                   target="rules"
                   )
)

summary(rules)
rules
inspect(rules)

rules<-apriori(
  trans,
  parameter = list(supp=0.3,conf=0.5,
                   maxle=10,
                   minlen=2,
                   target="rules"
  )
)
summary(rules)
rules
inspect(rules)


# RHS rule
beer_rules_rhs<-apriori(trans,parameter = list(supp=0.3,conf=0.5,maxlen=10,minlen=2),appearance = list(default="lhs",rhs="beer"))
beer_rules_rhs
inspect(beer_rules_rhs)
# LHS
beer_rules_lhs<-apriori(trans,parameter = list(supp=0.3,conf=0.5,maxlen=10,minlen=2),appearance = list(default="lhs",lhs="beer"))
beer_rules_lhs

inspect(beer_rules_lhs)

# Product
rules_conf<-sort(rules,
                 by="confidence",
                 decreasing=TRUE)
inspect(head(rules_conf))

plot(rules)


plot(rules,measure="confidence")

plot(rules,method="two-key plot")


install.packages("plotly")
library(plotly)

plot(rules, engine = "plotly")

# Graph based visualization


#graph based visulation
subrules <-head(rules, n=10, by="confidence")
plot(subrules, method="graph", engine="htmlwidget")

# parallel coordinate plot
plot(subrules,method="paracoord")




# Project 5 (appriori)
#-------------
# Load necessary libraries. The arules library is used for mining 
# association rules and frequent itemsets. The arulesViz library provides 
# visualization techniques for the arules package.
library(arules)
library(arulesViz)



# Load Groceries data
# The Groceries dataset is loaded. It contains transaction data where each 
# transaction represents items purchased together.
# Check the structure of the Groceries data
data(Groceries)

# The str function shows the structure of the Groceries dataset.
str(Groceries)



# Plot item frequencies for the top 20 items
# This plot helps identify which items are most commonly purchased, 
# indicating their popularity.
itemFrequencyPlot(Groceries, 
                  topN = 20, 
                  type = "absolute", 
                  main = "Top 20 Frequent Items in Groceries Data")



# Set a priori rule with support = 0.001 and confidence = 0.8
rules <- apriori(Groceries, 
                 parameter = list(supp = 0.001, 
                                  conf = 0.8))

# Summary of the rules generated
# The generated rules show strong associations between items that are frequently bought together.
summary(rules)


# Show the top five rules using inspect
# Rules with a higher lift indicate stronger associations, meaning items are 
# more likely to be bought together than by chance.
rules <- sort(rules, by = "lift", decreasing = TRUE)
top5_rules <- head(rules, 5)
quality(top5_rules) <- round(quality(top5_rules), digits = 2)
inspect(top5_rules)



# Sort the rules by confidence in decreasing order
# Higher confidence indicates a stronger relationship where the presence of 
# items in the left-hand side (lhs) often leads to the presence 
# of items in the right-hand side (rhs).
rules_sorted_by_confidence <- sort(rules, by = "confidence", decreasing = TRUE)
head(rules_sorted_by_confidence, 5)


# Use "whole milk" as target item in lhs
# The code below shows which items are frequently bought together with whole
# milk, revealing customers' common purchase patterns when they buy whole milk.

whole_milk_rules_lhs <- subset(rules, lhs %in% "whole milk")
whole_milk_rules_sorted_by_confidence_lhs <- 
  sort(whole_milk_rules_lhs, by = "confidence", decreasing = TRUE)
head(whole_milk_rules_sorted_by_confidence_lhs, 5)

# Use "whole milk" as target item in rhs
# This reveals which items are likely to be bought when whole milk is 
# part of the transaction, highlighting complementary products to whole milk.
whole_milk_rules_rhs <- subset(rules, rhs %in% "whole milk")
whole_milk_rules_sorted_by_confidence_rhs <- 
  sort(whole_milk_rules_rhs, by = "confidence", decreasing = TRUE)
head(whole_milk_rules_sorted_by_confidence_rhs, 5)



