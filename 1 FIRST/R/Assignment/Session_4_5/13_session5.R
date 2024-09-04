
##Built-in function##
round(3.1415)
round(3.1415,digit=2)
factorial(3)
mean(1:6)


##Random sampling## 
die<-1:6
sample(x=die,size = 2) #replace value is FALSE by default, sample cannot occur more than once
sample(x=die,size=2,replace=TRUE) #sample can occur more than once


##Data set split into training and test Data set in 70:30 ratio##
setwd("~/R")
getwd()
iris<-read.csv("iris.csv")
set.seed(123)
tt.sample<-sample(c(TRUE,FALSE),nrow(iris),replace=T,prob=c(0.7,0.3))
train<-iris[tt.sample,]
test<-iris[!tt.sample,]
head(train)
head(test)


##User-defined function##
roll<-function(){
      die<-1:6
      dice<-sample(die,size=2,replace=TRUE)
      sum(dice)
}
roll()

##user-defined function with value passing as a parameter##
roll2<- function(dice=1:6){
  dice<-sample(die,size=2,replace=TRUE)
  sum(dice)
}
roll2()

##user-defined function with valu passing as argument##
roll3<- function(dice){
    dice<-sample(die,size=2,replace=TRUE)
    sum(dice)
}
roll3(dice=1:6)
roll3(dice=1:12)
roll3(dice=1:24)


##Ugly method##
best_practice<- c("Let","the","computer","do","the","work")
print_words<- function(sentences){
  print(sentences[1])
  print(sentences[2])
  print(sentences[3])
  print(sentences[4])
  print(sentences[5])
  print(sentences[6])
}
print_words(best_practice)
print_words(best_practice[-6])
best_practice[-6]


#Using for loop
best_practice<- c("Let","the","computer","do","the","work")
print_words<- function(sentences){
  for(word in sentences){
    print(word)
  }
}
print_words(best_practice)


#Checking value of y with x
y<-30
if(y<20){
  x<- "Too low"
}else{
  x<- "Too high"
}

#Using function to check values of y
check.y<-function(y){
  if(y<20){
    print("Too Low")
  }else{
    print("Too High")
  }
}
check.y(10)
check.y(30)


#########Binary variables################
y<-1:40
ifelse(y<20,"Too low","Too High")

y<-1:40
ifelse(y<20,1,0)

##Function to check
check.x<- function(x=1:99){
  if(x<20){
    print("Less than 20")
  }else{
    if(x<40){
    print("20-39")
    }else{
      if(x<100){
      print("41-99")
      }
    }
  }
}
check.x(15)
check.x(30)
check.x(45)

#Multiple condition
x<-1:99
x1<-ifelse(x<20,1,0)
x2.1<-ifelse(x<20,"<20","20+")
x2.2<-ifelse(20<=x & x<40,"in","out")
x2.3<- ifelse(40<=x & x<100,"in","out")
x3<- ifelse(x<20,1,ifelse(x<40,2,3))
x3

#Petal Length categories in respect to Petal Length
iris<- within(iris,{
  Petal.cat<-NA
  Petal.cat[Petal.Length<1.5] <- "small"
  Petal.cat[Petal.Length>=1.6 & Petal.Length<5.1] <- "Medium"
  Petal.cat[Petal.Length<1.5] <- "Large"
})
iris$Petal.cat
table(iris$Petal.cat)

############HOMEWORK#####################
temperature<- function(temp){
if (temp <= 0) {
  "freezing"
  } 
else if(temp <= 10) {
    "cold"
  }
else if (temp <= 20) {
    "cool"
  }
    
else if (temp <= 30) {
      "warm"
    }
else{
      "hot"
    }
} 


temperature(29)
 


