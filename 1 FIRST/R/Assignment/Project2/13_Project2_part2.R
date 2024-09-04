
library(rvest)
library(jsonlite)
## Web scraping and data wrangling
# https://data.covid19india.org (two JSON files)


# Find all the hyperlinks in the site
hrefs <- read_html("https://data.covid19india.org") %>% 
  html_elements("a") %>% 
  html_attr("href") 

# Filter URLs with ".json" extension
urls <- hrefs[grep("\\json$",hrefs)]
urls
 
########## FOR FIRST LINK ############### 
covid_india_timeseries <- lapply(urls[1],fromJSON)
timeseries <- covid_india_timeseries[[1]]

###########
#Tried to get the values
timeseries$WB$dates$`2021-10-31`$total$vaccinated1
# Converted to data frame
timeseries_df <- as.data.frame(timeseries)

# Unlisted all the elements from the list
test <- unlist(timeseries, recursive = T)
test1 <- as_tibble(test)
test

#Get Colname of the data frame
timeseries_colname <- colnames(timeseries_df)
####################

########## FOR SECOND LINK ###############

covid_india_data <- lapply(urls[2],fromJSON)
datas <- covid_india_data[[1]]

##############
# Tried to get values
datas$AN$districts$`South Andaman`$total$vaccinated1
datas$WB$districts$Darjeeling$total$vaccinated1


data_df <- as.data.frame(covid_india_data)
colnames(data_df)
###############









# https://aqicn.org/city/kathmandu (aqi forecast table)

#aqi_forecast_table <- read_html("https://aqicn.org/city/kathmandu") %>%
#  html_nodes("table") %>%
#  html_table() %>% .[[6]]
#aqi_forecast_table
#head(aqi_forecast_table)
####Could not get appropriate table so used Rselenium for web scrapping

install.packages("RSelenium") 
install.packages("netstat")
library(RSelenium)
library(netstat)
library(rvest)

# Create the remote Driver from firefox using RSelenium
remote_driver <- rsDriver(remoteServerAddr = "localhost", browser = "firefox", port=free_port(), chromever = NULL, verbose = F)
mybrowser <- remote_driver$client

# Navugate to the URL
mybrowser$navigate("https://aqicn.org/city/kathmandu/")

# Inspect the HTML element and scrape the table data
aqi_html  <- read_html(mybrowser$getPageSource() %>% unlist())
aqi_html %>% html_element("table.aqiforecast-table") %>% html_table() -> forecast_table

# Close the browser session
mybrowser$close
remote_driver[["server"]]$stop()


df <- data.frame(forecast_table)

#Remove all column with NA 
new_df<- df[,colSums(is.na(df))==0]

#Replace column names with first row of data frame
names(new_df) <- new_df[1,]

#Remove 1st row
forecast_df <- new_df[-1,]

#Remove empty row
forecast_df <- forecast_df[!apply(forecast_df == "", 1, all), ]
forecast_df


