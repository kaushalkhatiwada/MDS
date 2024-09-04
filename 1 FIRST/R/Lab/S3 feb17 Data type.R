
# Matrix
m<-matrix(c(1:30),nrow=6,ncol = 5)
m[5:6,]  # select last two rows
m[c(3,5),c(2,4)]  # select 3rd and 5th row with 2nd and eth column
n<- matrix(c(31:45),nrow=3,ncol=5) # new matrix with 3 row 5 column
new_m<-rbind(m,n) # rbind old and new matrix

#Factor and attributes
gender <- factor(c("male","female","female","male"))
typeof(gender)
attributes(gender)
unclass(gender)

#########################################
date1 <- as.Date("2024-02-17")
class(date1)
date2 <- as.POSIXct("2024-02-17 09:00")
class(date2)

#########################################
#k<-TRUE
#class(k)
#is.logical(k)
#TRUE*5
#FALSE*5
##########################################
#2==3
#"data"<"stats"
#"data"=="stats"
#"data"=="datb"
#"data"=="dat" 
########################################
#x<-c(1,2,3)
#x*3 #scale vector by 3
#sqrt(x)
##############################
#Extend vector
x<-1:10
y<-c(1,2)
x+y
a<-1:10
b<-c(1,2,3)
a+b
############################
#Compare Vector
#x<-10:1
#y<--4:5
#any(x<y)
#all(x<y)
######################3
#Vector naming


##########################
#display all inbuild function with word "mea"
#apropos("mea")
###################################

zchar<-c("a",NA,"c")
z<-c(1,2,3,4,NA,5,6)
mean(z) #OUTPUT NA
mean(z,na.rm = TRUE)
