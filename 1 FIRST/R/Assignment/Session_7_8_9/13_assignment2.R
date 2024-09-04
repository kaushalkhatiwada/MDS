###################SESSION7################
###Read JSON file from URL###
install.packages("jsonlite")
library(jsonlite)
Raw<- fromJSON("https://data.ny.gov/api/views/9a8c-vfzj/rows.json?accessType=DOWNLOAD")
food_market<-Raw[['data']]    #Fetch data
Names<-food_market[,14]     #Get 14th Column only
head(Names)

nineteen<-table(food_market[,19])   #Represent 19th column in table with frequency
nineteen


###HTML Scrapping###
install.packages("rvest")
library(rvest)
simple<-read_html("https://dataquestio.github.io/web-scraping-pages/simple.html")
simple %>% 
  html_nodes("p") %>%   #Get <p> HTML tag
  html_text()           #Extract text content



#Extract Covid Table from wikipedia#
library(rvest)
wiki_link<-"https://en.wikipedia.org/wiki/COVID-19_pandemic_in_Nepal"
wiki_page<-read_html(wiki_link)
covid_table<-wiki_page %>% 
  html_elements(".COVID-19_pandemic_data_Nepal_medical_cases") %>%      #Get div class
  html_nodes("table") %>%                                               #Get table tag
  html_table() %>%.[[1]]                                                #Get table content
tail(covid_table)



#Change names of column by adding values of first row
names(covid_table)<- paste(names(covid_table),covid_table[1,], sep="_")
covid_table<-covid_table[-1,]
tail(covid_table)

#Change columns name
colnames(covid_table) <- c("Date", "Confirmed_Cases_Total", 
                           "Confirmed_Cases_New", "Confirmed_Cases_Active", 
                           "Recoveries_Total", "Recoveries_New", "Deaths_Total", 
                           "Deaths_New", "PCR_Total", "PCR_New", "TPR", "RR", "CFR", "Ref")
tail(covid_table)


#Remove "+" , "%" and "," from variables
covid_table$Confirmed_Cases_New <- gsub('[+]', '', covid_table$Confirmed_Cases_New)     #Remove "+" from "Confirmed_Cases_New" column's record
covid_table$Recoveries_New <- gsub('[+]', '', covid_table$Recoveries_New)
covid_table$Deaths_New <- gsub('[+]', '', covid_table$Deaths_New)
covid_table$PCR_New <- gsub('[+]', '', covid_table$PCR_New)

covid_table$TPR <- gsub('[%]', '', covid_table$TPR)                                   #Remove "%" from "TPR" column's record
covid_table$RR <- gsub('[%]', '', covid_table$RR)
covid_table$CFR <- gsub('[%]', '', covid_table$CFR)

covid_table$Confirmed_Cases_Total <- gsub('[,]', '', covid_table$Confirmed_Cases_Total)   #Remove "," from "Confirmed_Cases_Total" column's record
covid_table$Confirmed_Cases_New <- gsub('[,]', '', covid_table$Confirmed_Cases_New)
covid_table$Confirmed_Cases_Active <- gsub('[,]', '', covid_table$Confirmed_Cases_Active)
covid_table$Recoveries_Total <- gsub('[,]', '', covid_table$Recoveries_Total)
covid_table$Recoveries_New <- gsub('[,]', '', covid_table$Recoveries_New)
covid_table$Deaths_Total <- gsub('[,]', '', covid_table$Deaths_Total)
covid_table$Deaths_New <- gsub('[,]', '', covid_table$Deaths_New)
covid_table$PCR_Total <- gsub('[,]', '', covid_table$PCR_Total)
covid_table$PCR_New <- gsub('[,]', '', covid_table$PCR_New)
covid_table$TPR <- gsub('[,]', '', covid_table$TPR)
covid_table$RR <- gsub('[,]', '', covid_table$RR)
covid_table$CFR <- gsub('[,]', '', covid_table$CFR)

tail(covid_table)


#Convert character to integer and number
covid_table$Confirmed_Cases_Total <- as.integer(covid_table$Confirmed_Cases_Total)  #Convert the data type of column "Confirmed_Cases_Total" from character to integer
covid_table$Confirmed_Cases_New <- as.integer(covid_table$Confirmed_Cases_New)
covid_table$Confirmed_Cases_Active <- as.integer(covid_table$Confirmed_Cases_Active)
covid_table$Recoveries_Total <- as.integer(covid_table$Recoveries_Total)
covid_table$Recoveries_New <- as.integer(covid_table$Recoveries_New)
covid_table$Deaths_Total <- as.integer(covid_table$Deaths_Total)
covid_table$Deaths_New <- as.integer(covid_table$Deaths_New)
covid_table$PCR_Total <- as.integer(covid_table$PCR_Total)
covid_table$PCR_New <- as.integer(covid_table$PCR_New)

covid_table$TPR <- as.numeric(covid_table$TPR)
covid_table$RR <- as.numeric(covid_table$RR)
covid_table$CFR <- as.numeric(covid_table$CFR)
tail(covid_table)


######################## Convert Date format  #############3

date_format <- as.Date(covid_table$Date,format = "%d %b")
final_format <- format(date_format,"%m-%d") 
covid_table$Date <- final_format
tail(covid_table)



#####################################################################
#                        SESSION 8 & 9                              #
#######################################################################

#Create Tibble
library(tidyr)
table1 <- tibble(
  country = c("Afghanistan","Afghanistan","Brazil","Brazil","China","China"),
  year = c(1999,2000,1999,2000,1999,2000),
  cases = c(745,2666,37737,80488,212258,213766),
  population = c(19987071,20595360,172006362, 174504898, 1272915272,1280428583)
)
table1

#Pivoting [Longer to Wider]
table2
table2 %>%pivot_wider(names_from = type, values_from = count)

#Pivoting [Wider to Longer]
table4a
table4a %>% pivot_longer(c('1999','2000'),names_to = "year",values_to="cases")

#Separate
table3
table3 %>% separate(rate,into = c("cases","population"))

#Unite
table5
table5 %>% unite(new,century,year)



######################    Missing values in tibble     ##############
## Explicitly missing: 4th Quarter of 2015
## Implicitly missing: 1st Quarter of 2016
stocks <- tibble(
  year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr = c( 1, 2, 3, 4, 2, 3, 4),                          
  return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
)

#Pivot and changing the data set to handle the missing values
stocks
stocks %>% pivot_wider(names_from = year,values_from = return)

#Handle the missing value and drop the NA value.
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(
    cols = c(`2015`, `2016`), 
    names_to = "year", 
    values_to = "return", 
    values_drop_na = TRUE
  )

stocks %>% complete(year,qtr)   #Using complete function

treatment <- tribble(
  ~ person, ~ treatment, ~response,
  "Derrick Whitmore", 1, 7,
  NA, 2, 10,
  NA, 3, 9,
  "Katherine Burke", 1, 4
)
treatment
treatment %>% fill(person)    #Using fill function


#####################################################
##############   Data Manipulation    ################
#filter() function is used to pick the observation by their values.
#arrange() function is used to reorder the rows.
#select() function is used to pick the variables by their names.
#mutate() function is used to create new variable with respect to existing variables
#summarise() function is used to merge down the values to single summary



################  FILTER  #################
library(dplyr)
library(nycflights13)                       #nycflights13 data
filter(flights, month == 1, day == 1)         #filter fights on Jan 1st
filter(flights,month==11 | 12)                  #filter with or operator
filter(flights,month==11 | month==12)
nov_dec<-filter(flights,month %in% c(11,12))

#To filter the arrival delay and departure delay less than 120 minutes.
filter(flights,!(arr_delay>120 | dep_delay>120))
filter(flights,arr_delay<=120 , dep_delay<=120)



#########  ARRANGE  ###############
#To reorder the data set in year,month,day in descending order 
arrange(flights,year,month,day)     

# Most delayed Airlines
delay<-arrange(flights,desc(dep_delay))                   #arrange departure delay in descending order
dep_delay_20<- head(delay,n=20)                           #Get Top 20 
most_delayed_airlines_table<-table(dep_delay_20$carrier)  #Represent the carrier and its dep_delay frequency
most_delayed_airlines_table

##Average departed delayed time 
average_departed_delay<-mean(dep_delay_20$dep_delay)
average_departed_delay


#########  SELECT  #################
select(flights,year,month,day)
select(flights,year,month:day)    #Column between month and day
select(flights,-(year:day))     #Exclude column between year and day
select(flights,time_hour,air_time)
select(flights,time_hour,air_time,everything())



################  MUTATE  ############# Add new variable with existing variable

flights_sml<-select(flights,
                    year:day,
                    ends_with("delay"),
                    distance,
                    air_time
)

mutate(flights_sml,
       gain=dep_delay - arr_delay,
       speed= distance / air_time * 60,
       hours = air_time /60,
       gain_per_hour = gain /hours
)



##############  TRNASMUTE  ########### only to keep new variables

transmute(flights,
          gain=dep_delay - arr_delay,
          hours = air_time/60,
          gain_per_hour=gain/hours,
)

transmute(flights,
          dep_time,
          hour =dep_time %/% 100,      #Modular
          minute =dep_time %% 100,     #Remainder
)



###########summaries to group ##########
summarise(flights,delay=mean(dep_delay,na.rm=TRUE))
by_day<-group_by(flights,year,month,day)
by_day
summarise(by_day,delay=mean(dep_delay,na.rm=TRUE), .groups = 'drop')




###############  MULTIPLE OPERATION WITH PIPES  #########
##Displays the mean distance of flights and mean arrival delay of flights
##to each destination with more than 20 flights excluding destination "HNL"
delays<-flights %>% 
  group_by(dest) %>% 
  summarise(
    count=n(),
    dist=mean(distance,na.rm = TRUE),
    delay = mean(arr_delay,na.rm = TRUE),
  ) %>% 
  filter(count>20,dest != "HNL")
delays




###############  CANCELLED FIGHT  ######################
#First, Filters only those rows where departure delay and arrival delay is not missing 
#which means the flight has take-off and landed (not cancelled).

not_cancelled<- flights %>% 
  filter(!is.na(dep_delay),!is.na(arr_delay))

#Calculate the mean departure delay for each day.
not_cancelled %>% 
  group_by(year,month,day) %>% 
  summarise(mean=mean(dep_delay), .groups = 'drop')           

##Calculate the mean arrival delay for each unique tail number
delays<-not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay=mean(arr_delay)
  )
delays
hist(delays$delay)

####################
delays<-not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay=mean(arr_delay,na.rm=TRUE),
    n=n()
  )

hist(delays$n)
hist(delays$delay)
plot(delays$n,delays$delay)



#######  SUMMARY FUNCTION  #########
### When do the first and last flight leave each day?
not_cancelled %>% 
  group_by(year,month,day) %>% 
  summarise(
    first= min(dep_time),
    last = max(dep_time)
  )

### When do the first and last flight leave each month?
not_cancelled %>% 
  group_by(year,month) %>% 
  summarise(
    first= min(dep_time),
    last = max(dep_time)
  )

###Why is distance to some destinations more variable than to others?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(
    distance_mean=mean(distance),distance_sd=sd(distance)) %>% 
  arrange(desc(distance_sd))

### Which destination have the most carries?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers=n_distinct(carrier)) %>% 
  arrange(desc(carriers))


###How many flights left before 5am daily?
not_cancelled %>% 
  group_by(year,month,day) %>% 
  summarise(n_early=sum(dep_time<500))

###How many flights left before 5am monthly?
not_cancelled %>% 
  group_by(year,month) %>% 
  summarise(n_early=sum(dep_time<500))

###what proportion of flight are delayed by more than an hour?
not_cancelled %>% 
  group_by(year,month,day) %>% 
  summarise(hour_prop=mean(arr_delay>60))

###find all groups bigger than a threshold?
popular_dests<- flights %>% 
  group_by(dest) %>% 
  filter(n()>365)
popular_dests


#############  POPULAR DESTINATION  ##########
#head(popular_dest$dest)    #This result in not valid

popular_destination <- flights %>%
  group_by(dest) %>%
  summarise(total_flights = n()) %>%
  filter(total_flights > 365) %>%
  arrange(desc(total_flights))
head(popular_destination$dest)

########################################
#Slice function to slice the sample for training and testing
flights %>% slice_sample(n=5,replace = TRUE)
set.seed(123)
train_data <- flights %>% slice_sample(prop = 0.8)
train_data
test_data <- flights %>% slice_sample(prop = 0.2)
test_data



