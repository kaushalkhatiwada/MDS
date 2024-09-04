# WORK 1
#Loading the ggplot2 library for graphing purposes
library(ggplot2)
#Loading the in-built airquality dataset
data(airquality)
aq <- airquality
#Calculating the number of intervals using Sturges' formula (a statistical tool/ formula)
num_intervals <- ceiling(log2(length(aq$Temp)) + 1)
#Creation of intervals using built-in cut() function
aq_intervals <- cut(aq$Temp, breaks = num_intervals)
#Calculation of frequency in each class using the table() function
aq_interval_freq <- table(aq_intervals)
aq_interval_freq
#Calculation of cumulative frequencies
(cumulative_freq <- cumsum(aq_interval_freq))
(cumulative_freq2 <- cumsum(rev(aq_interval_freq)))
#Getting upper class boundaries using RegEx
(upper_boundaries <- as.numeric(sub("\\((.*),.*\\]", "\\1", names(cumulative_freq))))
#Evaluating the maximum and minimum upper boundary
(max_upper_boundary <- max(upper_boundaries))
(min_upper_boundary<-min(upper_boundaries))
#More than frequency data for more than ogive
rev_upper_boundaries<-rev(upper_boundaries)
rev_cumulative_freq<-rev(cumulative_freq2)

#Creation of data frame, plotting of ogives, and determining the intersection point
df_more_than <- data.frame(Upper_Class_Boundary = upper_boundaries, Cumulative_Frequency = rev_cumulative_freq)
df_less_than <- data.frame(Upper_Class_Boundary = upper_boundaries, Cumulative_Frequency = cumulative_freq)

common_xlim <- c(min(min_upper_boundary, rev_upper_boundaries), max(max_upper_boundary, upper_boundaries))

ggplot() +
  geom_line(data = df_more_than, aes(x = Upper_Class_Boundary, y = Cumulative_Frequency), color = "blue") +
  geom_line(data = df_less_than, aes(x = Upper_Class_Boundary, y = Cumulative_Frequency), color = "red") +
  labs(x = "Upper Class Boundary", y = "Cumulative Frequency", 
       title = "Ogive Comparison") +
  xlim(common_xlim) 

#Calculation of median using the median() function of R
median(aq$Temp)


# WORK 2
# Plotting histogram of 'Temp' variable
hist(aq$Temp, xlab = "Temperature", ylab = "Frequency", main = "Histogram of Temperature")

hist_data <- hist(aq$Temp, plot = FALSE)
#Calculation of the bin index that has the highest frequency
(max_freq_index <- which.max(hist_data$counts))
#Determining the left and right bin adjacent to the bin with highest frequency
(left_bin <- max_freq_index - 1)
(right_bin <- max_freq_index + 1)

#Coordinates' calculation for the diagonal line from the edge of the largest bar to the tip of the opposite adjacent bar
x_left1 <- hist_data$breaks[left_bin + 1]  
x_right1 <- hist_data$breaks[max_freq_index + 1] 
y_max <- max(hist_data$counts)
y_left1 <- hist_data$counts[left_bin]
y_right1 <- hist_data$counts[max_freq_index]

#Plotting the diagonal line
segments(x_left1, y_left1, x_right1, y_right1, col = "blue")

#Drawing another diagonal line
x_left2 <- hist_data$breaks[max_freq_index] 
x_right2 <- hist_data$breaks[right_bin] 
y_left2 <- hist_data$counts[max_freq_index]
y_right2 <- hist_data$counts[right_bin]

#Plotting another diagonal line
segments(x_left2, y_left2, x_right2, y_right2, col = "blue")

#Slopes of the two lines
slope1 <- (y_right1 - y_left1) / (x_right1 - x_left1)
slope2 <- (y_right2 - y_left2) / (x_right2 - x_left2)

#Calculation of intercept of the lines
intercept1 <- y_left1 - slope1 * x_left1
intercept2 <- y_left2 - slope2 * x_left2

#Calculation of intersection point
intersection_x <- (intercept2 - intercept1) / (slope1 - slope2)

#Plot vertical line at the intersection point
abline(v = intersection_x, col = "green", lty = 2)

#Calculation of mode using the statistical method built into R
mode(aq$Temp)
freq_table <- table(aq$Temp)
mode <- as.numeric(names(freq_table)[freq_table == max(freq_table)])
mode
intersection_x



# WORK 3
#Loading the required library file
library(igraph)
#Reading the csv file and saving it as a dataframe object
sna_school<-read.csv("C:/Users/HOME/Downloads/Niraj Raj Kharel - SNA_School.csv")
#Viewing the first few rows of data
head(sna_school)

# Importing and creating a data frame “s” with first and second column of the data
s <- data.frame(first = sna_school$first, second = sna_school$second)

#Saving it as network graph data object “net” with directed = T argument
net<-graph.data.frame(s,directed = T)
net

#Checking the number of vertices, edges, degree of “net” and interpret the carefully
V(net)

#The output indicates that there are 290 edges in the graph, each represented by a pair of vertices. Each pair of vertices indicates a directed edge from the first vertex to the second vertex.
E(net)

#The degree of a vertex provides information about its importance and connectivity within the graph. 
degree(net)



#Histogram of net degree and interpret it carefully
degree_values <- degree(net)
#Creation of a histogram of degree distribution
hist(degree_values, xlab = "Degree", ylab = "Frequency", main = "Degree Distribution of Network")


#Network diagram of “net” 
set.seed(16)
#Plotting the graph
plot(net)
