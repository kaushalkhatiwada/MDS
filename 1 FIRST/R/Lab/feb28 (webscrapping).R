
install.packages("jsonlite")
library(jsonlite)

##############################################################################
Raw<- fromJSON("https://data.ny.gov/api/views/9a8c-vfzj/rows.json?accessType=DOWNLOAD")
food_market<-Raw[['data']]      #fetch data
head(food_market)
Names<-food_market[,14] 
head(Names)

table(Names)

############GETS_ERROR##########
table(V19)
table(food_market$V19)
################################

table(food_market[,19])
###############SCRAPING FROM HTML################
install.packages("rvest")
library(rvest)
#https://dataquestio.github.io/web-scraping-pages/simple.html
simple<-read_html("https://dataquestio.github.io/web-scraping-pages/simple.html")
simple %>% 
  html_nodes("p") %>% 
  html_text()
##################GET COVID DATA FROM WIKIPEDIA#############################

#https://en.wikipedia.org/wiki/COVID-19_pandemic_in_Nepal
library(rvest)
wiki_link<-"https://en.wikipedia.org/wiki/COVID-19_pandemic_in_Nepal"
wiki_page<-read_html(wiki_link)
str(wiki_page)
covid_table<-wiki_page %>% 
  html_elements(".COVID-19_pandemic_data_Nepal_medical_cases") %>% 
  html_nodes("table") %>% 
  html_table() %>%.[[1]]
covid_table

########Change names of column by adding values of first row

names(covid_table)<- paste(names(covid_table),covid_table[1,], sep="_")
covid_table<-covid_table[-1,]
str(covid_table)
head(covid_table)

####################change data variable

