#install.packages("twitteR")
#install.packages("tm")
#install.packages("SnowballC)
#install.packages("wordcloud")
#install.packages("topicmodels")
#install.packages("BiocManager")
#BiocManager::install("Rgraphviz")

library(twitteR)
library(tm)
library(SnowballC)
library(graph)
library(Rgraphviz)
library(wordcloud)
library(topicmodels)

load(file="./rdmTweets.RData")
tweets<-rdmTweets
str(tweets)

(n.tweet<-length(tweets))   #number of tweets
strwrap(tweets[[154]]$text,width = 55)  #text variable of tweet 154 with its width 55

tweets[1:3]   #Get tweet variable from 1 to 3

df<-twListToDF(tweets)
str(df)

## Build Corpus and display in plain text
myCorpus <- Corpus(VectorSource(df$text))
inspect(myCorpus[1:3])

## convert to lower case
myCorpus <- tm_map(myCorpus,tolower)
inspect(myCorpus[1:3])

## Remove punctuation and number
myCorpus <- tm_map(myCorpus,removePunctuation)
inspect(myCorpus[1:3])

myCorpus <- tm_map(myCorpus,removeNumbers)
inspect(myCorpus[1:3])

## Remove URL http followed by non-space characters.
removeURL <- function(X) gsub("http[^[:space:]]*","",X)
myCorpus <- tm_map(myCorpus,removeURL)
inspect(myCorpus[1:3])

## Remove r and big from the list of stopwords and remove other stopwords.
myStopwords <- setdiff(stopwords("english"),c("r","big"))
myCorpus <- tm_map(myCorpus,removeWords,myStopwords)
inspect(myCorpus[1:3])

################# Stemming(be careful) text cleaning ##### I will not stream #########3
myCorpusCopy <- myCorpus      #Backup up
inspect(myCorpusCopy[1:3])
#remove stem
myCorpus < tm_map(myCorpus,stemDocument)
inspect(myCorpus[1:3])


myCorpus <- tm_map(myCorpus,gsub,pattern="posit",replacement="position")
strw
########################################################333

## Create TDM 
myTdm <- TermDocumentMatrix(myCorpusCopy,control = list(wordLengths=c(1,Inf)))
myTdm
str(myTdm)

## inspect frequency word on TDM greater than 10
(freq.terms<- findFreqTerms(myTdm,lowfreq=10))

## which words are associated with r on 0.2 probability
findAssocs(myTdm,"r",0.2)

## 
plot(myTdm,term=freq.terms,corThreshold=0.1,weighting=T)

## Word Cloud
m <- as.matrix(myTdm)
freq <- sort(rowSums(m),decreasing = T)
wordcloud(words=names(freq),freq=freq,min.freq = 4,random.order = F)


## 5 ota topic ani topic anusar word
set.seed(123)


