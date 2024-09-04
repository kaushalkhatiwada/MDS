########### WORK 1 #################

aq_temp <- airquality$Temp
High <- max(aq_temp,na.rm=TRUE)  # max value
Low <- min(aq_temp,na.rm = TRUE)  # min value
N = length(aq_temp)  # number of observation
# Calculate number of class intervals Using Sturges' formula
class_intervals <-  ceiling(log2(N) + 1) # 9 class intervals

breaks <- seq(Low,High,length.out = class_intervals)
print(breaks)

#Frequency

f <- table(cut(aq_temp,breaks = breaks,include.lowest = TRUE))
f

# Get frequency for less than ogive
less_than_ogive <- cumsum(f)

# Get frequency for more than ogive
more_than_ogive <- rev(cumsum(rev(f)))

# Plot less than ogive
plot(breaks[-1],
     less_than_ogive,
     type = "o",
     col = "blue",
     xlab = "Temperature",
     ylab = "Frequency",
     main = "Ogive Plot",
     ylim = c(0,150),
     xlim = c(55,100))

#Plot more than ogive
lines(breaks[-1], 
      more_than_ogive,
      type = "o",
      col = "red",
      ylim = c(0,150),
      xlim = c(55,100))
legend("topright",
       legend = c("Less Than Ogive", "More Than Ogive"),
       col = c("blue", "red"),
       lty = c(1, 1))

# Intersection Point
intersection_lower <- breaks[which(less_than_ogive >= more_than_ogive)[1]]
intersection_upper <- breaks[which(less_than_ogive >= more_than_ogive)[1]+1]
intersection_lower
intersection_upper


# Median in R
median(aq_temp)





# Draw a line from the intersection point (intersection_x, intersection_y)
abline(v = intersection_x, col = "green", lty = 2)  # Vertical line
points(intersection_x, intersection_y, col = "green", pch = 19)

lines(class_intervals[-1],
      more_than_ogive,
      type = "l",
      col = "green")

median <- median(aq_temp)

########### WORK 2 #################
hist(aq_temp, main = "Temperature",col="white",xlab = "Temperature")
h <- hist(aq_temp,plot=F)
#Get the bars
highest_freq <- max(h$counts)       #34
highest_bar <- which.max(h$counts)  # 6th bar
left_bar <- highest_bar - 1         # 5th bar
right_bar <- highest_bar + 1        # 7th bar

# Draw a diagonal line from en edge of the largest bar to the tip of the opposite adjacent bar

left_upper <- h$breaks[left_bar + 1]
left_bar_count <- h$counts[left_bar]

highest_bar_upper <- h$breaks[highest_bar + 1]
highest_bar_count <- h$counts[highest_bar]

segments(left_upper, left_bar_count, highest_bar_upper, highest_bar_count, col = "darkgreen")

# 9 Draw another diagonal line from other edge of the largest bar to the tip of of the opposite adjacent bar
right_lower <- h$breaks[highest_bar] 
right_bar_count <- h$counts[right_bar]

highest_bar_lower <- h$breaks[right_bar] 
highest_bar_count <- h$counts[highest_bar]

segments(right_lower, highest_bar_count, highest_bar_lower, right_bar_count, col = "blue")

#10 Intersection of the two diagonal lines in the x-axis in the mode
# Calculate slopes (m) and y-intercepts (b) of the two lines
slope1 <- (highest_bar_count - left_bar_count) / (highest_bar_upper - left_upper)
slope2 <- (right_bar_count - highest_bar_count) / (highest_bar_lower - right_lower)

intercept1 <- left_bar_count - slope1 * left_upper
intercept2 <- highest_bar_count - slope2 * right_lower

#Using point of intersection formula
intersection_x <- (intercept2 - intercept1) / (slope1 - slope2) 
intersection_x  #80.33333

abline(v = intersection_x, col = "red", lty = 2)

# Mode using R
f <- table(aq_temp)
max_freq <- max(f)
mode <- names(f)[f == max_freq]
mode


