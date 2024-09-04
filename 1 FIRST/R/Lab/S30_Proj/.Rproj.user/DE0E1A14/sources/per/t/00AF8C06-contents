# S28
# Create a list of baskets
market_basket <- list(
  c("bread","milk"),
  c("bread","diapers","beer","Eggs"),
  c("milk","diapers","beer","cola"),
  c("bread","milk","diapers","beer"),
  c("bread","milk","diapers","cola")
)

names(market_basket) <- paste("T",c(1:5), sep = "")

library(arules)

# Transformation
trans<- as(market_basket,"transactions")

#Dimensions
dim(trans)

#Item Labels
itemLabels(trans)

#Summary
summary(trans)

#Plot
image(trans)

#Inspect
inspect(trans)

# Apriori Algorithm
# Min 0.3 and confidence 0.5
rules<- apriori(
  trans,
  parameter = list(supp=0.3, 
                   conf=0.5,
                   maxlen=10,
                   target="rules")
)

summary(rules)

inspect(rules)

####Remove empty rules
rules<- apriori(
  trans,
  parameter = list(supp=0.3, 
                   conf=0.5,
                   maxlen=10,
                   minlen=2,
                   target="rules")
)
inspect(rules)

#### rhs = beer
beer_rules<- apriori(
  trans,
  parameter = list(supp=0.3, 
                   conf=0.5,
                   maxlen=10,
                   minlen=2),
  appearance = list(default="lhs",rhs="beer")
)
inspect(beer_rules)

####lhs = beer
beer_rules_lhs<- apriori(
  trans,
  parameter = list(supp=0.3, 
                   conf=0.5,
                   maxlen=10,
                   minlen=2),
  appearance = list(lhs="beer",default="rhs")
)
inspect(beer_rules_lhs)

#### Product recommendation rule
rules_conf <- sort(rules,by="confidence",decreasing = TRUE)
inspect(head(rules_conf))

################ PLOTTING
library(arulesViz)
plot(rules)
plot(rules, measure = "confidence")
plot(rules, method="two-key plot")

### Interactive plot
library(plotly)
plot(rules, engine = "plotly")

subrules <- head(rules,n=10,by="confidence")
plot(subrules,method="graph",engine = "htmlwidget")

# parallel coordinates
plot(subrules,method="paracoord")


