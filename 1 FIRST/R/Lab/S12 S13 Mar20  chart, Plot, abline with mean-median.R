
##https://r-coder.com/plot-r/    

gd <- as.data.frame(VADeaths)
View(gd)

#################### BAR PLOT ################
barplot(gd$'Rural Male')

# Bar plot of Rural Male column in continuous series with labels
barplot(gd$'Rural Male',names.arg=c("50-54","55-59","60-64","65-69","70-74"),
        main="Deadth Rate in Virginia,USA",xlab="Age group",ylab="Rate")

# Bar plot of Rural Male column in continuous series with labels in horizontal and color
barplot(gd$'Rural Male',horiz=T,names.arg=c("50-54","55-59","60-64","65-69","70-74"),
        main="Deadth Rate in Virginia,USA",xlab="Rate",ylab="Age group",col="blue",border="red")

# Bar plot of Rural Male column in continuous series with labels in horizontal and color with xlimit to 70
barplot(gd$'Rural Male',horiz=T,names.arg=c("50-54","55-59","60-64","65-69","70-74"),
        main="Deadth Rate in Virginia,USA",xlab="Rate",ylab="Age group",col="blue",border="red",
        xlim = c(0,70), cex.axis = 0.80)

########### SUPPOSE TO GETS ERROR #####################
barplot((gd,
         col=c("lightblue","mistyrose","lightcyan","lavender","cornsilk"),
         legend=rownames(gd)))
############

###### STACKED BAR PLOT
gdm <- as.matrix(gd)
gdm
barplot(gdm,
        col=c("lightblue","mistyrose","lightcyan","lavender","cornsilk"),
         legend=rownames(gd))

##
my_colors <- c("lightblue","mistyrose","lightcyan","lavender","cornsilk")
#Bar plot
barplot(gdm, col=my_colors)
#Add legend
legend("topleft",legend=rownames(gdm),
       fill=my_colors,box.lty = 0,cex = 0.8)  

##
##### Multiple Bar Diagram
barplot(gdm,
        col=c("lightblue","mistyrose","lightcyan","lavender","cornsilk"),
        legend=rownames(gdm),
                        beside=T)   #Beside to plt bar beside each other

##### Multiple Bar Diagram legend in topleft
my_colors <- c("lightblue","mistyrose","lightcyan","lavender","cornsilk")
#Bar plot
barplot(gdm, col=my_colors,beside = T)
#Add legend
legend("topleft",legend=rownames(gdm),
       fill=my_colors,box.lty = 0,cex = 0.8)  


##################### HISTOGRAM ##################
# TO find the interval (square root of range)
gdcar<- as.data.frame(cars)
hist(gdcar$speed,col="steelblue")
hist(gdcar$speed,col="steelblue",breaks = 10)  # Break interval into 10
summary(gdcar) 


######## Normal Q-Q Plot with Q-Q line#######
#Q-Q plot
qqnorm(gdcar$speed)
#Q-Q line
qqline(gdcar$speed,col="red")

#Density plot for the verification
#Density
dens <-density(cars$speed)
#plot density
plot(dens,frame=F,col="steelblue",main="Density plot of mpg")
polygon(dens,col="red")


#################### PIE CHART ########################33
gdcar <- as.data.frame(VADeaths)
gdcar
pie(gd$'Rural Male',labels=rownames(gd),radius=1)

## changing colors
pie(gd$'Rural Male',labels=rownames(gd),radius=1,
    col=c("#999999","#E69F00","#56B4E9","red","blue"))

#Adding % and legend using rainbow function
gd$piepercent <- round(100*gd$"Rural Male"/sum(gd$'Rural Male'),1)
pie(gd$'Rural Male',labels=gd$piepercent, main="% Deaths by Age groups for Rural Male",
    col=rainbow(length(gd$'Rural Male')))
legend("topright",c("50-54","55-59","60-64","65-69","70-74"),
       cex = 0.8, fill = rainbow(length(gd$'Rural Male')))


###################  LINE CHART #####################
gdcar<- as.data.frame(cars)
plot(gdcar$speed)
plot(gdcar$speed, type="o")

############### SCATTER PLOT ##################
plot(gdcar$speed,gdcar$dist)    #(X-axis,Y-axis)
plot(gdcar$dist,gdcar$speed)

#Which correlation coefficient is appropriate??

###############  BOX PLOT ############
boxplot(gdcar$speed)

##
boxplot(mpg ~cyl,data=mtcars)

##
boxplot(mpg ~gear,data=mtcars,xlab = "Number of cylinders",ylab="Miles Per Gallon",
        main="Mileage Data")

############### GRAPH FROM DATA FRAME #######
str(mtcars)
barplot(mtcars$mpg) #BARPLOT
hist(mtcars$mpg)   #HISTOGRAM
# Which one do you prefer?? ANS:- 

plot(density(mtcars$mpg)) #Density
qqnorm(mtcars$mpg)    # Q-Q
qqline(mtcars$mpg,col="red") #Q-Q line

df <- as.
boxplot(mpg ~ ,data=mtcars)   #BOXPLOT


######################################

#Get bar gram of categorical variable from data frame
df <- as.data.frame(mtcars)
f.cyl <- as.factor(df$cyl)  
barplot(f.cyl)  #Gets error  : height' must be a vector or a matrix

# SO use this
barplot(table(df$cyl))
bpd <- table(df$cyl)

barplot(table(df$gear))   #for gear
barplot(table(df$mpg))    #for mpg
########################

############## ASSIGNMENT##################3
# How to get bar plot pf "mpg" variable???

# Histogram and abline for mean of mpg and median of mpg
hist(df$mpg,col="steelblue",main="Histogram",xlab="MPG")
abline(v=mean(df$mpg))


# Histogram and abline median of mpg
hist(df$mpg,col="steelblue",main="Histogram",xlab="MPG")
abline(v=median(df$mpg),hwd=3,lty=2)

#How to locate mode graphically in r with histogram????

##############################################

#lty (line type) 1=solid line, 
#lwd (lide width)
#pch ()

#iqn (inter quartile)

##################################
#### Scatter plot with horizontal "abline"
plot(df$mpg,df$wt,pch=16,main="Scatterplot of MPG and Weight",xlab="MPG",ylab="Weight")
abline(h=2,col="blue",lwd=2)
abline(h=4,col="blue",lwd=2)

#### Scatter plot with vertical "abline"
plot(df$mpg,df$wt,pch=16,main="Scatterplot of MPG and Weight",xlab="MPG",ylab="Weight")
abline(v=15,col="red",lwd=2)
abline(v=30,col="red",lwd=2)

### Scatter with mean +-1*sd of y variable
plot(df$mpg,df$mpg,pch=16)
abline(h=mean(df$mpg),col="red")
abline(h=mean(df$mpg)+1*sd(df$mpg),col="blue",lwd=3,lty=2)
abline(h=mean(df$mpg)-1*sd(df$mpg),col="blue",lwd=3,lty=2)

## Scatter plot with abline from a model
plot(df$wt,df$mpg,main="Scatterplot with abline",xlab="Weight",ylab="MPG")
reg_mod <- lm(df$mpg ~df$wt)
abline(reg_mod)

## Scatter plot with "abline" and "lines" for a non-linear data
plot(df$hp,df$disp,main="Scatterplot with model abline",xlab="Horse power",ylab="Displacement")
abline(lm(df$disp ~df$hp))
lines(lowess(df$hp,df$disp))
##############3incomplete

################################


