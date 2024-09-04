## Short
#******
# Data visualization

#Data visualization is the graphical representation of information and data. By using visual elements like charts, graphs, and maps, data visualization tools provide an accessible way to see and understand trends, outliers, and patterns in data.
#******
#The Grammar of Graphics, developed by Leland Wilkinson, provides a systematic and powerful framework for creating data visualizations. Wilkinson’s approach breaks down the process of creating visualizations into a set of fundamental components, enabling a more flexible and coherent way to construct and interpret complex statistical graphics.

#The Grammar of Graphics, as proposed by Leland Wilkinson, provides a comprehensive framework for creating and understanding data visualizations.
#By breaking down the visualization process into components such as data, aesthetics, scales, geometries, statistics, coordinates, facets, and annotations, it allows for a systematic and flexible approach to building complex and effective visualizations.
#This approach underlies many modern visualization tools, enabling users to construct detailed and informative graphics that effectively communicate data insights.


# The Grammar of Graphics, implemented in ggplot2, provides a structured and flexible framework for creating data visualizations. 
# By breaking down the visualization process into distinct layers—data, aesthetics, geometries, statistics, scales, coordinates, facets, and annotations—it allows for a clear, modular, and comprehensive way to build and understand data visualizations. 
# This layered approach facilitates the creation of detailed and informative graphics that effectively communicate data insights, making ggplot2 a powerful tool for data scientists and analysts.

# Benefits of the Layered Approach
# Modularity: Each layer can be added, modified, or removed independently, making it easy to customize and enhance the visualization.
# Clarity: By breaking down the visualization into layers, it becomes easier to understand and communicate the construction process.
# Flexibility: The layered approach can handle a wide variety of data types and visualization requirements, from simple plots to complex, multi-faceted graphs.

#******
# Key Layers in the Grammar of Graphics
# Data Layer:
  #  The data layer is the foundation of any visualization. It involves selecting the dataset and specifying which variables will be visualized.

#Aesthetics Layer (aes):
  #  Aesthetics map data variables to visual properties of the graphical elements. Common aesthetics include position (x and y coordinates), color, shape, size, and transparency.

#Geometric Layer (geom):
  #  Geometries define the type of graphical elements used to represent data points, such as points, lines, bars, or histograms. Each geom type is suitable for different kinds of data and analyses.

#Statistical Transformation Layer (stat):
  #  This layer applies statistical transformations to the data, such as calculating means, counts, or fitting a regression line. It helps in summarizing or modifying the data to reveal underlying patterns.

#Scales Layer:
  #  Scales map data values to aesthetic values, ensuring that the data is accurately represented in the visual space. For example, they convert numerical data into positions on the axes or map categorical data to different colors.

#Coordinate Layer:
  #  The coordinate layer determines how data points are positioned in the plot. The most common coordinate system is Cartesian coordinates, but others like polar coordinates can also be used.

#Facet Layer:
  #  Faceting splits the data into subsets and creates a separate plot for each subset, arranged in a grid. This is useful for comparing different categories or groups within the data.

#Annotation Layer:
  #  Annotations add context and explanations to the visualization, such as titles, axis labels, legends, and text labels.

#******
##Key Concepts of Statistical Transformations
#Statistical transformations in the Grammar of Graphics are operations applied to the data before visual representation. These transformations help in aggregating, summarizing, or otherwise transforming the raw data into a form that is more meaningful and easier to interpret visually.

#Common Statistical Transformations
#Aggregations:
  #  Summarize data points within groups. Examples: Mean, median, sum, count.

#Smoothing:
  #  Fit a smooth curve to the data to identify trends.Examples: LOESS smoothing, regression lines.

#Density Estimation:
  #  Estimate the probability density function of a continuous variable.Examples: Kernel density estimation.

#Bin Counts:
  #  Aggregate data into bins for histograms or bar charts.Examples: Histogram bins, frequency polygons.

#Statistical Summaries:
  #  Summarize data points for visualization.Examples: Boxplots, error bars.


#******
###
#Outliers
#Definition:
 # Outliers are data points that deviate significantly from the rest of the data. They can unduly influence the estimates of the regression coefficients and distort the model's predictive ability.

#Identification:
#Residuals: Examine the residuals (the differences between observed and predicted values). Large residuals indicate potential outliers.
#Standardized Residuals: Residuals can be standardized (or studentized) to assess their magnitude relative to the standard deviation. Common thresholds for standardized residuals to flag outliers are values greater than ±2 or ±3.
#Boxplots: Visual tools like boxplots can help spot outliers in the dataset.
#Normal Probability Plot: Deviations from the straight line in a Q-Q plot (quantile-quantile plot) can indicate outliers.

#
#Cook's Distance
#Definition:
#Cook's Distance measures the influence of each observation on the fitted values. It assesses how much the predicted values in the model would change if a particular observation were removed.
#Interpretation:
#  A larger Cook's Distance indicates that the observation has a significant impact on the model’s parameters.
#As a rule of thumb, a Cook's Distance greater than 1 suggests a highly influential point, although in smaller datasets, values exceeding 4/(n-k-1) (where n is the number of observations and k is the number of predictors) may also be considered.0

#
#Leverage
#Definition:
#  Leverage measures the influence of an observation on its fitted value. High leverage points are those with unusual predictor values, which can disproportionately affect the regression model.
#Identification:
#  Hat Matrix: Leverage is calculated from the hat matrix (H), where the diagonal elements (h_ii) represent the leverage values for each observation.
#Observations with leverage values significantly larger than the average leverage (2p/n, where p is the number of predictors and n is the number of observations) are considered high leverage points.

#######******
#Supervised Learning: Classification and Regression Models
#Supervised learning involves training a model on a labeled dataset, where the input features (X) are paired with the correct output labels (Y). The goal is for the model to learn the relationship between X and Y so it can make accurate predictions on new, unseen data. Supervised learning can be divided into two main types: classification and regression.

#Classification: The target variable is categorical. Examples include spam detection (spam or not spam) and image classification (cat, dog, or bird).
#Regression: The target variable is continuous. Examples include predicting house prices or stock prices.

#Model Fit Indices
#Model fit indices are metrics used to evaluate how well a model's predictions match the actual data. The choice of indices depends on whether the task is classification or regression.

#For Classification:
#Accuracy: The proportion of correctly classified instances out of the total instances.
#Precision: The proportion of true positive predictions among all positive predictions.
#Recall (Sensitivity): The proportion of true positive predictions among all actual positives.
#F1 Score: The harmonic mean of precision and recall, balancing the two metrics.
#ROC-AUC: The area under the Receiver Operating Characteristic curve, representing the trade-off between true positive rate (recall) and false positive rate.

#******
#For Regression:
#Mean Absolute Error (MAE): The average absolute difference between the actual and predicted values.
#Mean Squared Error (MSE): The average squared difference between the actual and predicted values.
#Root Mean Squared Error (RMSE): The square root of MSE, providing a measure in the same units as the target variable.
#R-squared (R²): The proportion of variance in the dependent variable that is predictable from the independent variables.

#******
#Confusion Matrix with Example
#A confusion matrix is a table used to evaluate the performance of a classification model. It summarizes the correct and incorrect predictions broken down by each class.
#Consider a binary classification problem where we predict whether an email is spam or not.

#   |-------------------|---------------------|------------------------|
#   |                   | Predicted Spam	    |    Predicted Not Spam  |
#   |-------------------|---------------------|------------------------|
#   |    Actual Spam  	|True Positive (TP)  	|   False Negative (FN)  |
#   |-------------------|---------------------|------------------------|
#   | Actual Not Spam	  |False Positive (FP)  |   True Negative (TN)   |
#   |-------------------|---------------------|------------------------|

# Example :

#   |-------------------|---------------------|------------------------|
#   |                   | Predicted Spam	    |    Predicted Not Spam  |
#   |-------------------|---------------------|------------------------|
#   |    Actual Spam  	|         30         	|          10            |
#   |-------------------|---------------------|------------------------|
#   | Actual Not Spam	  |          5          |          55            |
#   |-------------------|---------------------|------------------------|


#******
#*
#In this confusion matrix:

#The top-left cell (30) represents the true positive (TP) instances, where spam emails were correctly classified as spam.
#The top-right cell (10) represents the false negative (FN) instances, where spam emails were incorrectly classified as not spam.
#The bottom-left cell (5) represents the false positive (FP) instances, where not spam emails were incorrectly classified as spam.
#The bottom-right cell (55) represents the true negative (TN) instances, where not spam emails were correctly classified as not spam.
#From this confusion matrix, we can calculate various performance metrics such as accuracy, precision, recall, and F1 score, which provide insights into the model's performance in classifying spam and not spam emails.



#******
# Prediction Accuracy with ROC Curve
# The ROC (Receiver Operating Characteristic) curve is a graphical plot that illustrates the diagnostic ability of a binary classifier.
#The ROC curve is created by plotting the true positive rate (recall) against the false positive rate at various threshold settings.
#The area under the ROC curve (AUC) provides a single measure of overall model performance.


##******
# Poisson regression is a type of regression analysis used when the dependent variable is a count or rate and follows a Poisson distribution. It models the relationship between a set of independent variables and the expected count of occurrences of an event.

# Types of Poisson Regression:

#  Simple Poisson Regression:
  #  In simple Poisson regression, there is only one independent variable. It models the relationship between this independent variable and the count of occurrences of the event.

#Multiple Poisson Regression:
  #  Multiple Poisson regression extends the simple Poisson regression to include multiple independent variables. It allows for modeling the relationship between the count of occurrences and several predictor variables simultaneously.

#******
# Zero-Inflated Poisson Regression:
  #  Zero-inflated Poisson regression is used when there is an excess of zero counts in the dependent variable compared to what would be expected from a Poisson distribution. It assumes that there are two processes generating the zeros: one process that generates zero counts with a probability of excess zeros, and another process that generates counts following a Poisson distribution.

#Negative Binomial Regression:
  #  Negative binomial regression is a generalization of the Poisson regression model that relaxes the assumption of equidispersion (where the mean is equal to the variance). It is useful when the data exhibit overdispersion, meaning that the variance is greater than the mean. Negative binomial regression allows for the variance to be larger than the mean, accommodating the extra variability in the data.

#Application Examples:
#  Simple Poisson Regression: Modeling the number of accidents at an intersection based on the amount of traffic passing through.
#Multiple Poisson Regression: Predicting the number of customer complaints received by a company based on various factors such as product quality, price, and customer service.
#Zero-Inflated Poisson Regression: Analyzing healthcare utilization data, where a large number of patients may have no healthcare visits in a given period.
#Negative Binomial Regression: Modeling the number of days a patient stays in the hospital after surgery, where the variance in length of stay is greater than the mean.

#******
#Supervised Linear Regression Model with Focus on Cross Validation
#Linear regression is a statistical method used to model the relationship between one or more independent variables (predictors) and a dependent variable (outcome). Cross-validation is a technique used to assess the performance of a predictive model by splitting the dataset into training and testing sets. Here's how cross-validation, k-fold cross-validation, and repeated k-fold cross-validation are applied in the context of supervised linear regression:

#Cross Validation:
#Overview:
#Cross-validation involves splitting the dataset into two subsets: a training set used to fit the model and a testing set used to evaluate its performance.
#It helps in estimating the model's ability to generalize to new, unseen data.
#Steps:
#  Data Splitting: Split the dataset randomly into a training set and a testing set.
#Model Fitting: Fit the linear regression model using the training set.
#Model Evaluation: Evaluate the model's performance on the testing set using appropriate metrics (e.g., R-squared, RMSE).

#K-Fold Cross Validation:
#Overview:
#K-fold cross-validation involves splitting the dataset into k subsets (folds).
#The model is trained k times, each time using k-1 folds as the training set and the remaining fold as the testing set.
#It provides a more robust estimate of model performance compared to a single train-test split.

#Repeated K-Fold Cross Validation:
#Overview:
#Repeated k-fold cross-validation extends k-fold cross-validation by repeating the process multiple times with different random splits of the data.
#It provides a more reliable estimate of model performance by reducing the variability introduced by the random splitting process.

#Summary:
#Cross-validation is a technique used to assess the performance of a predictive model by splitting the dataset into training and testing sets.
#K-fold cross-validation divides the data into k subsets and trains the model k times, using each subset as the testing set once.
#Repeated k-fold cross-validation repeats k-fold cross-validation multiple times with different random splits of the data to provide a more reliable estimate of model performance.

###******
#A graphic is a visual representation of data or information designed to communicate complex ideas or relationships effectively. It condenses and presents information in a visually appealing and understandable format, making it easier for viewers to grasp key insights at a glance.

#To succinctly describe a graphic, we can say that it is a visual representation that uses graphical elements such as charts, graphs, diagrams, or images to convey information, patterns, trends, or relationships in data or concepts.

#reating a graphic that we have described involves the following steps:
  
#  Define the Message: Determine the key message or insights that you want to convey through the graphic.

#Choose the Right Visualization: Select the most appropriate type of graphic (e.g., bar chart, line graph, pie chart, scatter plot) based on the nature of the data and the message you want to communicate.

#Collect and Prepare Data: Gather the relevant data and preprocess it if necessary (e.g., cleaning, transforming) to make it suitable for visualization.

#Design the Graphic: Use visualization tools or software to design the graphic, paying attention to visual elements such as colors, labels, scales, and annotations to enhance clarity and readability.

#Create the Graphic: Implement the design using the chosen visualization tool or software, ensuring that the graphic accurately represents the data and effectively communicates the intended message.

#Review and Refine: Review the graphic to ensure accuracy, clarity, and effectiveness. Make any necessary refinements or adjustments to improve the overall quality of the graphic.

#Publish or Share: Once satisfied with the graphic, publish or share it through appropriate channels (e.g., reports, presentations, websites, social media) to reach the intended audience and convey the message effectively.

###******
# Grammar of graphics:
#• A grammar of graphics is a tool that enables us to concisely describe
#the components of a graphic.
#• Such a grammar allows us to move beyond named graphics (e.g., the
 #                                                         “scatterplot”) and gain insight into the deep structure that underlies
#statistical graphics.
#• ggplot2 proposes an alternative parameterization of the grammar,
#based around the idea of building up a graphic from multiple layers
#of data. 

# # #
# Layered grammar of graphics:
#• To be precise, the layered grammar defines the components of a plot as:
 # • a default dataset and set of mappings from variables to aesthetics,
#• one or more layers, with each layer having one geometric object, one statistical
#transformation, one position adjustment, and optionally, one dataset and set of
#aesthetic mappings,
#• one scale for each aesthetic mapping used,
#• a coordinate system,
#• the facet specification

####******
# Geometric objects:
#Geometric objects are fundamental elements in geometry that represent shapes, figures, or entities in space. These objects have distinct properties, such as size, shape, dimensionality, and position, which can be described and analyzed using geometric principles. Some common geometric objects include:
#  
#  Point: A point represents a single location in space and has no size or dimension. It is typically denoted by a dot.#
#
#Line: A line is a straight path that extends infinitely in both directions. It is defined by two points.
#
#Line Segment: A line segment is a finite portion of a line between two endpoints.

#Ray: A ray is a part of a line that has one endpoint and extends infinitely in one direction.

#Plane: A plane is a flat, two-dimensional surface that extends infinitely in all directions. It is defined by three non-collinear points or a point and a normal vector.

#Polygon: A polygon is a closed geometric figure made up of line segments called edges. It has straight sides and does not intersect itself. Examples include triangles, squares, rectangles, pentagons, and hexagons.

#Circle: A circle is a closed curve consisting of all points in a plane that are equidistant from a fixed center point. It is defined by its center and radius.

#Sphere: A sphere is a three-dimensional geometric object consisting of all points in space that are equidistant from a fixed center point. It is defined by its center and radius.

#Cube: A cube is a three-dimensional solid object with six square faces, twelve edges, and eight vertices. All angles are right angles, and all sides are congruent.

#Cylinder: A cylinder is a three-dimensional geometric object with two parallel circular bases connected by a curved surface.


#• Point geom = scatterplot
#• Line geom = line plot etc.
#• Geom Dimensionality as per the “ggplot2” package:
#  • 0d: point, text
#• 1d: path, line (ordered path)
#• 2d: polygon, interval (continuous

####******
#Interval geometric objects represent geometric entities that are bounded by intervals, meaning they have a specific range or extent along one or more dimensions. Here are four common representations of interval geometric objects:

#Interval Lines:
  
#  Interval lines represent line segments that are bounded by two endpoints along a one-dimensional axis.
#They are defined by two points: the start point and the end point, which define the interval.
#Example: A line segment on the x-axis from x = 2 to x = 5.
#Interval Rectangles:
  
#  Interval rectangles represent rectangles that are bounded by intervals along both the x and y dimensions.
#They are defined by two intervals: one for the x-axis (width) and one for the y-axis (height).
#Example: A rectangle with width from x = 2 to x = 5 and height from y = 3 to y = 7.
#Interval Cubes:
  
#  Interval cubes represent three-dimensional cubes that are bounded by intervals along the x, y, and z dimensions.
#They are defined by three intervals: one for the x-axis (length), one for the y-axis (width), and one for the z-axis (height).
#Example: A cube with length from x = 2 to x = 5, width from y = 3 to y = 7, and height from z = 1 to z = 4.
#Interval Cylinders:
  
#  Interval cylinders represent cylindrical objects that are bounded by intervals along the radius and height dimensions.
#They are defined by two intervals: one for the radius (diameter) and one for the height.
#Example: A cylinder with radius from r = 2 to r = 5 and height from z = 1 to z = 4.
#These interval geometric objects are commonly used in geometric modeling, computational geometry, 
#and computer graphics for representing and manipulating geometric shapes with defined ranges or extents along their dimensions.

####******
#aesthetic mapping (often abbreviated as "aes") is a mechanism used in data visualization packages like ggplot2 to map variables in a dataset to visual properties of a plot. Aesthetics define how data variables are represented visually in a plot, such as position, color, size, shape, or transparency.

#Here's how aesthetic mapping works in R:

#Mapping Variables: Aesthetic mapping involves mapping variables from a dataset to specific aesthetic properties of the plot, such as x and y positions, color, shape, size, etc.

#In ggplot2: In ggplot2, aesthetic mapping is specified within the aes() function. Variables from the dataset are mapped to aesthetic properties using the aes() function inside the ggplot() call. For example:

#aes(x = variable1, y = variable2, color = variable3)
#Dynamic Mapping: Aesthetic mapping allows for dynamic visualization of data. By changing the variables mapped to aesthetics, you can create different visualizations to explore different aspects of the data.#

#Automatic Legends: When variables are mapped to aesthetics, ggplot2 automatically generates legends to provide a key for interpreting the visual encoding. Legends help viewers understand the meaning of different colors, shapes, etc., used in the plot.

####******
# Geometric objects
#• A geom is the geometrical object that a plot uses to represent data.
#People often describe plots by the type of geom that the plot uses.
#For example, bar charts use bar geoms, line charts use line geoms,
#boxplots use boxplot geoms, and so on. Scatterplots break the trend;
#they use the point geom.
#• To change the geom in your plot, change the geom function that you
#add to ggplot().
#• ggplot2 provides over 40 geoms


#Average (Arithmetic Mean):
  
#  The average, also known as the arithmetic mean, is the sum of all values in a dataset divided by the number of values.
#It represents the typical value of a dataset by balancing out the contributions of all values.

#Geometric Mean:
  
#  The geometric mean is the nth root of the product of n values in a dataset, where n is the number of values.
#It is useful for averaging rates, ratios, or values that multiply together to produce a result.

#Harmonic Mean:
  
#  The harmonic mean is the reciprocal of the arithmetic mean of the reciprocals of the values in a dataset.
#It is used to average rates, ratios, or values that have a reciprocal relationship, such as speed and time.

# In statistics, moments are quantitative measures that describe the shape, distribution, and variability of a dataset. They are calculated using the values of the data and provide valuable insights into its characteristics. The moments of a dataset are often used in probability theory, descriptive statistics, and inferential statistics. Here are the first four moments:
#  First Order Moment (Mean):
  
#  The first order moment, also known as the mean, represents the center or average of a dataset.
#It is calculated by summing all the values in the dataset and dividing by the total number of values.


#Second Order Moment (Variance):
  
#  The second order moment, also known as the variance, measures the spread or dispersion of the dataset around the mean.
#It is calculated by averaging the squared differences between each value and the mean.

#Third Order Moment (Skewness):
  
#  The third order moment, also known as skewness, measures the asymmetry of the distribution of values.
#It indicates whether the dataset is skewed to the left or right.
#A positive skewness value indicates a right-skewed distribution, while a negative skewness value indicates a left-skewed distribution.

# Fourth Order Moment (Kurtosis):
  
#  The fourth order moment, also known as kurtosis, measures the "tailedness" or peakedness of the distribution of values.
#It indicates whether the dataset has heavier or lighter tails compared to a normal distribution.
#Positive kurtosis values indicate heavier tails (leptokurtic distribution), while negative kurtosis values indicate lighter tails (platykurtic distribution).


 #**********
  ##Normal Distribution:
  
  #The normal distribution, also known as the Gaussian distribution or bell curve, is a continuous probability distribution characterized by a symmetric, bell-shaped curve.
#It is defined by two parameters: the mean (μ) and the standard deviation (σ), which determine the center and spread of the distribution, respectively.
#In a standard normal distribution (with μ = 0 and σ = 1), about 68% of the data falls within one standard deviation of the mean, 95% within two standard deviations, and approximately 99.7% within three standard deviations.


#****************
#  Skewness:
  
#  Skewness is a measure of the asymmetry of the probability distribution of a real-valued random variable.
#It quantifies the degree of symmetry or lack thereof in the distribution.
#A distribution is symmetric if its skewness is close to zero. Positive skewness indicates that the tail of the distribution extends to the right, while negative skewness indicates a longer left tail.
#Skewness is typically measured using the third standardized moment, which is normalized by the standard deviation cubed.

#******
 # Kurtosis:
  
#  Kurtosis is a measure of the "tailedness" or peakedness of the probability distribution of a real-valued random variable.
#It quantifies the degree to which the distribution differs from a normal distribution in terms of the thickness of the tails and the height of the peak.
#A distribution with positive kurtosis (leptokurtic) has heavier tails and a sharper peak than a normal distribution, while a distribution with negative kurtosis (platykurtic) has lighter tails and a flatter peak.
#Kurtosis is typically measured using the fourth standardized moment, which is normalized by the standard deviation raised to the fourth power.

#******
#*Relative Measures:
  
#  Relative measures are statistical measures that express one quantity relative to another, often used for comparison purposes.
#They provide insights into the relationship or proportion between different variables or values within a dataset.
#Common relative measures include proportions, ratios, percentages, and rates.
#Relative measures are useful for comparing data across different groups, time periods, or contexts, as they standardize the data and facilitate meaningful comparisons.

  # Quintiles:
  
 # Quintiles divide a dataset into five equal parts, each representing 20% of the data.
#They are a type of quantile that partitions the data into quintiles, with four cut points separating the five parts.
#The first quintile (Q1) contains the lowest 20% of the data, the second quintile (Q2) contains the next 20%, and so on, with the fifth quintile (Q5) containing the highest 20%.
#Quintiles are often used to analyze the distribution of a variable and identify extreme values or outliers.

#******
  # Percentiles:
  
#  Percentiles divide a dataset into 100 equal parts, each representing 1% of the data.
#They are a type of quantile that partitions the data into percentiles, with 99 cut points separating the 100 parts.
#The pth percentile represents the value below which p% of the data fall. For example, the 25th percentile (also known as the first quartile, Q1) represents the value below which 25% of the data fall.
#Percentiles are commonly used in various fields to assess the relative standing of an individual or observation within a distribution, such as in standardized testing, growth charts, and income distributions.

#******
#*#Standard or Z-Score:
  
#  The standard score, also known as the z-score, measures the number of standard deviations a data point is from the mean of the dataset.
#It standardizes the data by transforming it into a common scale with a mean of 0 and a standard deviation of 1.

# Z-scores are useful for comparing data points from different distributions and for identifying outliers or extreme values in a dataset. A z-score greater than 3 or less than -3 is often considered an outlier.

#******
#*• Breakdown analysis: “apply”
#* breakdown analysis refers to the process of breaking down a dataset into subsets based on one or more categorical variables and then applying a function or analysis to each subset independently. 
#* The apply() function in R is a versatile and powerful tool for performing breakdown analysis.
# Its primary use is to apply a function across the rows or columns of a matrix or array, or even across multiple dimensions.

# Applying a Function to Rows or Columns:
  
#  One of the most common uses of apply() is to apply a function to either the rows or columns of a matrix or array.
#For example, you can calculate the sum, mean, median, or any other statistic for each row or column.

  #Handling Missing Values:
  
#  apply() allows you to apply functions that handle missing values more flexibly than built-in functions like colSums() or rowMeans().
#You can use custom functions within apply() to implement specific handling of missing values.

  #User-Defined Functions:
  
#  You can use apply() to apply custom user-defined functions to each row or column of a data structure.
#This is useful for performing complex operations or calculations that are not readily available in built-in functions.

  #Manipulating Data Frames:
  
#  apply() can be used to manipulate data frames by applying a function to specific columns or rows.
#This can be helpful for data cleaning, preprocessing, or creating new variables based on existing ones.

  #Operations on Higher-Dimensional Arrays:
  
  #apply() can handle higher-dimensional arrays by applying a function across multiple dimensions.
#This is useful for working with multi-dimensional datasets, such as image data or sensor data.

#  Vectorizing Operations:
  
 # Using apply() can sometimes lead to more efficient and vectorized code compared to using loops, especially for large datasets.
#Vectorized operations can improve the performance and readability of your code.

#******
#*Measures of central tendencies
#  • Computing measure of central tendency, dispersion, moments and
#relations position in R using packages and functions/scripts
#• Measures of Central Tendency – mean, median, mode, geometric
#mean, harmonic mean
#• Measure of Dispersion – standard deviation, inter-quartile range,
#range
#• Moments – mean, standard deviation, skewness, kurtosis
#• Relative position – percentile, quartiles and z-score

#******
#*Measures of central tendency are statistical summaries that represent the center or typical value of a dataset. They provide insights into the central or average value around which the data points tend to cluster. The most common measures of central tendency include the mean, median, and mode. Here's how each measure is calculated:
  
#  Mean:
  
#  The mean, also known as the arithmetic average, is calculated by summing up all the values in a dataset and then dividing by the total number of values.  

# Median:
  
#  The median is the middle value of a dataset when the values are arranged in ascending or descending order.
# If the dataset has an odd number of values, the median is the middle value. If it has an even number of values, the median is the average of the two middle values.

# Mode:
  
#  The mode is the value that appears most frequently in a dataset.
#A dataset may have one mode (unimodal), two modes (bimodal), or more than two modes (multimodal).
#Example: For the dataset 2, 4, 4, 6, 6, 6, 8, the mode is 6 because it appears most frequently.

# Measures of dispersion, also known as measures of variability or spread, quantify the extent to which data points in a dataset diverge or deviate from the central tendency. They provide valuable insights into the spread or variability of the data distribution. Three common measures of dispersion include standard deviation, interquartile range (IQR), and range:

 # Standard Deviation:
  
#  The standard deviation measures the average deviation of data points from the mean of the dataset. It indicates the extent of dispersion around the mean.
# A larger standard deviation indicates greater variability or spread, while a smaller standard deviation indicates less variability.

# Interquartile Range (IQR):
  
#  The interquartile range is a measure of statistical dispersion that represents the range between the first quartile (Q1) and the third quartile (Q3) of the dataset.
# It is less sensitive to outliers compared to the range and standard deviation, making it a robust measure of spread, particularly for skewed distributions.

  # Range:
  
# The range is the simplest measure of dispersion and represents the difference between the maximum and minimum values in a dataset.
# It provides a quick indication of the spread of the data but is sensitive to outliers.
  
#
  #In statistics, moments are mathematical quantities that provide information about the shape, spread, and distribution of a dataset. The moments of a distribution are calculated based on the deviations of individual data points from the central tendency (usually the mean) of the dataset. The first four moments, namely mean, standard deviation, skewness, and kurtosis, are particularly important in statistical analysis:
  
 # Mean (First Moment):
  
#  The mean is the arithmetic average of all values in a dataset. It represents the center or typical value of the distribution.

# Standard Deviation (Second Moment):
  
#  The standard deviation measures the dispersion or spread of the data points around the mean.
# A larger standard deviation indicates greater variability, while a smaller standard deviation indicates less variability.

#  Skewness (Third Moment):
  
#  Skewness measures the asymmetry of the distribution of data points around the mean.
# A positive skewness indicates that the tail of the distribution is longer on the right side, while a negative skewness indicates a longer left tail.

#  Kurtosis (Fourth Moment):
  
 # Kurtosis measures the tailedness or peakedness of the distribution of data points relative to a normal distribution.
# A higher kurtosis indicates heavier tails and a sharper peak, while a lower kurtosis indicates lighter tails and a flatter peak.

#******
#*Relative position measures in statistics provide information about the position of individual data points within a dataset relative to other data points. They help to understand how a specific data point compares to the rest of the dataset. Three common relative position measures are percentiles, quartiles, and z-scores:
  
#  Percentile:
  
#  Percentiles divide a dataset into hundred equal parts, each representing 1% of the data.
#The p-th percentile represents the value below which p% of the data fall.
#For example, the 25th percentile (also known as the first quartile, Q1) represents the value below which 25% of the data fall.
#Percentiles are useful for understanding the relative standing of an individual data point within the distribution of the dataset.

  #Quartiles:
  
#  Quartiles divide a dataset into four equal parts, each representing 25% of the data.
#The three quartiles are the first quartile (Q1), the second quartile (Q2), and the third quartile (Q3), representing the 25th, 50th, and 75th percentiles, respectively.
#The interquartile range (IQR) is the range between the first and third quartiles, providing a measure of spread that is robust to outliers.
#Quartiles are commonly used to summarize the spread and distribution of data, particularly in box plots and descriptive statistics.

  #Z-Score:
  
#  The z-score (standard score) measures the number of standard deviations a data point is from the mean of the dataset.
#It standardizes the data by transforming it into a common scale with a mean of 0 and a standard deviation of 1.
#A positive z-score indicates that the data point is above the mean, while a negative z-score indicates that it is below the mean.
#Z-scores are useful for comparing data points from different distributions and for identifying outliers or extreme values in a dataset.

#******
#*Probability distribution functions are mathematical functions that describe the likelihood of various outcomes or events occurring in a given scenario. These functions are fundamental in probability theory and statistics, as they allow us to model uncertainty and make predictions about random phenomena. Probability distributions can be categorized into two main types: discrete and continuous.

#Discrete Probability Distribution Functions:
  
#  Discrete probability distributions describe the probabilities of discrete or countable outcomes.
#The random variables in discrete distributions take on distinct, separate values, typically integers.
#Examples of discrete probability distribution functions include:
#  Probability Mass Function (PMF): Defines the probability distribution of a discrete random variable. It assigns probabilities to each possible value of the random variable.
#Cumulative Distribution Function (CDF): Gives the probability that a discrete random variable is less than or equal to a certain value.
#Examples of discrete distributions include the Bernoulli distribution, binomial distribution, Poisson distribution, and geometric distribution.
#Continuous Probability Distribution Functions:
  
 # Continuous probability distributions describe the probabilities of continuous outcomes or events.
#The random variables in continuous distributions can take on any value within a specified range.
#These distributions are described by probability density functions (PDFs) rather than probability mass functions.
#Examples of continuous probability distribution functions include:
#  Probability Density Function (PDF): Describes the probability distribution of a continuous random variable. The area under the PDF curve represents the probability of observing a value within a certain range.
#Cumulative Distribution Function (CDF): Gives the probability that a continuous random variable is less than or equal to a certain value.
#Examples of continuous distributions include the normal (Gaussian) distribution, uniform distribution, exponential distribution, and beta distribution.

#******
#*Testing for normality is a crucial step in many statistical analyses, as it helps to assess whether a dataset follows a normal distribution. There are several methods to test for normality, including graphical methods and formal statistical tests:

#Graphical Methods:
  
#  Histogram: A histogram is a graphical representation of the distribution of data. It allows you to visualize the shape of the distribution and identify deviations from normality, such as skewness or heavy tails.
#Q-Q Plot (Quantile-Quantile Plot): A Q-Q plot compares the quantiles of the data distribution to the quantiles of a theoretical normal distribution. If the data points fall approximately along a straight line, it suggests that the data are normally distributed.
#Box Plot: A box plot displays the distribution of data using quartiles and helps identify outliers and the symmetry of the distribution.
#Formal Statistical Tests:
  
#  Shapiro-Wilk Test: The Shapiro-Wilk test is a formal statistical test that assesses whether a dataset comes from a normally distributed population. It provides a p-value, and if the p-value is greater than a chosen significance level (e.g., 0.05), we fail to reject the null hypothesis of normality.
#Kolmogorov-Smirnov Test: The Kolmogorov-Smirnov test compares the cumulative distribution function of the sample data to the cumulative distribution function of a normal distribution. It also provides a p-value for the null hypothesis of normality.
#Anderson-Darling Test: The Anderson-Darling test is similar to the Shapiro-Wilk test but places more weight on the tails of the distribution. It provides a critical value based on the chosen significance level and compares it to the Anderson-Darling statistic computed from the data.

#******
#*Hypothesis testing:
#• It is part of inferential statistics i.e.
#taking decision from the sample
#(random) to population
#• It is used to take decision based on
#statistical tests and models using p- value aka Type I error or alpha
#error
#• It can be done using parametric or
#non-parametric methods/models
#• Parametric means they have
#certain assumptions on the data
#(model) and/or errors and we must
#validate them to accept the results
#• Non-parametric means they do not
#have assumptions about the
#distribution of the data (model)
#and errors

#******
#*Two statistical hypothesis:
#• Null hypothesis: Equal, same, no
#difference
#• Denoted as: H0
#• P-value > 0.05 is needed to
#accept (fail to reject) it from
#parametric or non-parametric
#tests (Goodness-of-fit tests)
#• Alternative hypothesis: Not
#equal, not same, different
#• Denoted as H1 or Ha
#• P-value <= 0.05 is needed to
#accept it from parametric or
#non-parametric tests (Research
#                      hypothesis tests!)


# Parametric - Test
# Parametric tests are statistical tests that make certain assumptions about the parameters of the population distribution from which the sample is drawn.
# These assumptions typically include the requirement that the data follow a normal distribution and that the samples have similar variances. 
# Parametric tests are generally more powerful than non-parametric tests when the assumptions are met, meaning they are more likely to detect true effects. Here are some common parametric tests:

#T-Test:
  
#  One-Sample T-Test: Tests whether the mean of a single sample is significantly different from a known or hypothesized population mean.
#Independent Two-Sample T-Test: Compares the means of two independent samples to determine if they are significantly different.
#Paired T-Test: Compares the means of two related groups to determine if they are significantly different.


#ANOVA (Analysis of Variance):
  
#One-Way ANOVA: Tests for significant differences between the means of three or more independent groups.
#Two-Way ANOVA: Tests for significant differences between the means of groups based on two independent variables, and also allows for interaction effects.

#Chi-Square Test:
  
#  Chi-Square Test for Independence: Tests whether two categorical variables are independent.
#Chi-Square Goodness of Fit Test: Tests whether the observed frequency distribution of a categorical variable matches an expected distribution.


#Regression Analysis:
  
#  Simple Linear Regression: Examines the relationship between a single predictor variable and a response variable.

#Multiple Linear Regression: Examines the relationship between multiple predictor variables and a response variable.

#Pearson Correlation Coefficient:
  
#  Measures the strength and direction of the linear relationship between two continuous variables.

#******
#*Residual analysis is a technique used to evaluate the goodness of fit of a statistical model, particularly in regression analysis. Residuals are the differences between the observed values and the values predicted by the model.
#* By analyzing these residuals, we can assess various aspects of model performance and detect potential problems such as non-linearity, heteroscedasticity, and outliers. Here are the main steps and components of residual analysis:

#******
#*Tree classification models are a type of decision tree algorithm used for classification tasks. 
#*They split the dataset into branches to make decisions based on feature values, ultimately classifying the data into different categories.
#* Ensemble methods like bagging, improved bagging, and boosting enhance the performance of tree classification models by combining multiple trees to reduce overfitting and improve accuracy. 

# 1. Bagging (Bootstrap Aggregating)
#Concept: Bagging is an ensemble technique that aims to reduce the variance of a model by training multiple decision trees on different subsets of the dataset and then averaging their predictions.

#Steps:
  
#  Bootstrap Sampling: Generate multiple datasets by sampling with replacement from the original dataset.
#Training: Train a decision tree on each bootstrap sample.
#Aggregation: Combine the predictions of all the individual trees by averaging (for regression) or majority voting (for classification).

# Improved Bagging (Random Forests)
#Concept: Random Forests, an improvement over standard bagging, further reduce correlation between trees by introducing randomness in the feature selection process.

#Steps:
  
#  Bootstrap Sampling: Generate multiple datasets by sampling with replacement from the original dataset.
#Feature Randomness: At each split in the tree, a random subset of features is chosen, and the best split is found among those features.
#Training: Train a decision tree on each bootstrap sample with the additional randomness in feature selection.
#Aggregation: Combine the predictions of all the individual trees by averaging (for regression) or majority voting (for classification).

# Boosting
#Concept: Boosting is an ensemble technique that combines the predictions of multiple weak learners (often decision trees) to create a strong learner. It sequentially trains trees, with each tree focusing on correcting the errors of the previous ones.

#Steps:
  
#  Initialize: Start with an initial prediction, often the mean of the target variable.
#Iterative Training: For each iteration:
#  Compute the residuals (errors) from the current model.
#Train a new decision tree on the residuals.
#Update the model by adding the new tree's predictions, often scaled by a learning rate.
#Aggregation: Combine the predictions of all the individual trees, usually by summing them with the learning rate applied.

#******
#* Correlation
#Correlation measures the strength and direction of the relationship between two variables. The correlation coefficient quantifies this relationship on a scale from -1 to 1:
  
#  +1: Perfect positive linear relationship (as one variable increases, the other increases proportionally).
#  -1: Perfect negative linear relationship (as one variable increases, the other decreases proportionally).
#   0: No linear relationship (the variables do not move together in any predictable pattern).

#******
#*Parametric Tests
# Parametric tests are statistical tests that make specific assumptions about the parameters of the population distribution from which the sample is drawn. These assumptions often include:
  
#  The data are normally distributed.
# The samples have similar variances (homoscedasticity).
# The data are measured on an interval or ratio scale.

#******
#*Common Parametric Tests:

# T-Test:
  
#  One-Sample T-Test: Tests whether the mean of a single sample is significantly different from a known or hypothesized population mean.
#Independent Two-Sample T-Test: Compares the means of two independent samples.
#Paired T-Test: Compares the means of two related groups.
#ANOVA (Analysis of Variance):
  
#  One-Way ANOVA: Tests for significant differences between the means of three or more independent groups.
#Two-Way ANOVA: Tests for significant differences based on two independent variables and their interaction.
#Pearson Correlation Coefficient: Measures the linear relationship between two continuous variables.

#Regression Analysis: Examines the relationship between predictor variables and a response variable.

#******
#*Non-Parametric Tests
#Non-parametric tests are statistical tests that do not make specific assumptions about the population distribution. They are useful when the assumptions of parametric tests are violated (e.g., non-normal distribution, ordinal data, outliers). Non-parametric tests are more flexible and robust in these situations.

#Common Non-Parametric Tests:
  
#  Mann-Whitney U Test: Compares differences between two independent groups when the dependent variable is either ordinal or continuous, but not normally distributed.
#Wilcoxon Signed-Rank Test: Compares differences between two related groups.
#Kruskal-Wallis H Test: Compares differences between three or more independent groups.
#Spearman's Rank Correlation Coefficient: Measures the strength and direction of the monotonic relationship between two variables.
#Kendall's Tau: Measures the strength and direction of the monotonic relationship between two variables.

#******
#*Naive Bayes and Support Vector Machine (SVM)
# Naive Bayes:
  
#  Implementation in R: Naive Bayes models are available in various R packages like e1071 and naivebayes.
#Advantages: Simple and efficient, works well with high-dimensional data, handles missing values well.
#Disadvantages: Assumes independence among predictors (which might not be true), can be outperformed by more complex models.
#Support Vector Machine (SVM):
  
#  Implementation in R: SVM models can be implemented using the e1071 package.
#Advantages: Effective in high-dimensional spaces, memory-efficient, versatile due to different kernel functions.
#Disadvantages: Choice of kernel and parameters can be challenging, not suitable for very large datasets.

#Comparison:
  
#  Naive Bayes is simpler and faster, suitable for text classification, spam filtering, etc.
#SVM tends to perform better in complex classification tasks with high-dimensional data but requires careful parameter tuning.

#******
#*Decision Tree and Random Forest

#Decision Tree:
  
#  Implementation in R: Decision trees can be built using the rpart package.
#Advantages: Easy to interpret, handles both numerical and categorical data, implicit feature selection.
#Disadvantages: Prone to overfitting, can create biased trees without proper pruning.

#Random Forest:
  
#  Implementation in R: Random forest models are available in the randomForest package.
#Advantages: Reduces overfitting by averaging multiple trees, handles missing values and categorical variables well, provides feature importance scores.
#Disadvantages: Less interpretable than a single decision tree, slower training compared to decision trees.

#Comparison:
  
#  Decision trees are simpler and easier to understand, but prone to overfitting.
# Random forests improve upon decision trees by reducing overfitting and increasing accuracy, but are more computationally expensive.

#******
#*Feed-forward and Feed-backward Neural Network
# Feed-forward Neural Network:
  
#  Implementation in R: Feed-forward neural networks can be built using packages like neuralnet, keras, or tensorflow.
#Advantages: Capable of learning complex patterns, suitable for large datasets, widely used in image and text processing.
#Disadvantages: Requires large amounts of data, tuning of architecture and parameters can be complex.
#Feed-backward Neural Network (assuming you meant Backpropagation):
  
#  Implementation in R: Backpropagation is a technique used to train feed-forward neural networks and is inherent in most neural network implementations in R.
#Advantages: Efficiently trains neural networks by adjusting weights to minimize error, widely used in various deep learning architectures.
#Disadvantages: Sensitive to initialization and hyperparameters, prone to overfitting with complex models and insufficient data.

#Comparison:
  
#  Feed-forward neural networks are the basic architecture of neural networks, suitable for various tasks.
#Backpropagation (used for training feed-forward networks) is a crucial algorithm for updating weights and minimizing error during training.



































































































