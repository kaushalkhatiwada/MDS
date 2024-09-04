
## Download 10 free pdfs of "Data Mining" in https://scholar.google.com

install.packages("pdftools")
library(pdftools)
library(tm)
library(wordcloud)
library(RColorBrewer)

getwd()
setwd("~/MDS503P2")

# list pdf files in working directory
pdfs <- list.files(pattern="*.pdf")

# lapply function is used to apply pdf_text function to all the element of list "pdfs"
alltext <- lapply(pdfs, pdf_text)
alltext.head()

# unlist() function takes list of text from PDFs, returns into a single character vector where all the text from different PDFs are combined together.
alltext <- unlist(alltext)

# create a single Corpus object containing all the text data, rather than separate Corpus objects for each PDF.
# Load the data as Corpus
myCorpus <- Corpus(VectorSource(alltext))
inspect(myCorpus[1:5])

# Text Transformation
myCorpus <- tm_map(myCorpus, content_transformer(function(X) gsub("http[^[:space:]]*","",X)))
inspect(myCorpus[4:5])
myCorpus <- tm_map(myCorpus, content_transformer(tolower))
myCorpus <- tm_map(myCorpus,removePunctuation)
myCorpus <- tm_map(myCorpus,removeNumbers)
myCorpus <- tm_map(myCorpus, content_transformer(function(x) gsub("\\\n", " ", x)))
myCorpus <- tm_map(myCorpus,stripWhitespace)
myCorpus <- tm_map(myCorpus,removeWords,stopwords("english"))
inspect(myCorpus[4:7])
myCorpusCopy <- myCorpus

# Build a term-document matrix which contains the frequency of the words
#Column names are words and row names are documents
myTdm <- TermDocumentMatrix(myCorpus,control = list(wordLengths=c(3,Inf)))

# Get the most frequent terms considering lower frequency = 20
freq_terms <- findFreqTerms(myTdm, lowfreq = 20)
findAssocs(myTdm, terms = "data", corlimit = 0.3)


## Word Cloud
m <- as.matrix(myTdm)
freq <- sort(rowSums(m),decreasing = T)

set.seed(1234)
wordcloud(words=names(freq),freq=freq, min.freq = 50,random.order = F,
          max.words = 120, colors = brewer.pal(8,"Dark2"),
          rot.per = 0.35,scale = c(5, 0.3),)

          