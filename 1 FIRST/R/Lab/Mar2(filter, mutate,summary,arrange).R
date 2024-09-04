#install.packages("dplyr")
#install.packages("dbplyr")
#install.packages("nycflights13")

####nycflights13 data########
library(dplyr)
library(nycflights13)
flights

str(flights)
#########  FILTER  #################33
#filter(flights,month==1,day==1)              #filter fights on Jan 1st
#jan1<-filter(flights,month==1,day==1)
#(jan1<-filter(flights,month==1,day==1))      #Object inside () prints the output
#(dec25<-filter(flights,month==12,day==25))     #filter and store in object and also prints the outcome

filter(flights,month==11 | 12)                  #filter with or operator
filter(flights,month==11 | month==12)
nov_dec<-filter(flights,month %in% c(11,12))

########DeMorgan's Law
filter(flights,!(arr_delay>120 | dep_delay>120))
filter(flights,arr_delay<=120 , dep_delay<=120)         # , is also OR operator

############  ARRANGE  ###############
arrange(flights,year,month,day)
arrange(flights,desc(dep_delay))

# Most delayed Airlines
delay<-arrange(flights,desc(dep_delay)) 
dep_delay_20<- head(delay,n=20)
most_delayed_airlines_table<-table(dep_delay_20$carrier)

##Average departed delayed time 
average_departed_delay<-mean(dep_delay_20$dep_delay)

#############SELECT#######################3
select(flights,year,month,day)
select(flights,year,month:day)    #Column between month and day

select(flights,-(year:day))     #Exclude column between year and day


select(flights,time_hour,air_time)
select(flights,-(year:day))       #Select column Except year to day 
select(flights,time_hour,air_time,everything())


################  MUTATE  #############

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

##############  TRNASMUTE  ###########only to keep new variables

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

###########summaries##########
summarise(flights,delay=mean(dep_delay,na.rm=TRUE))

by_day<-group_by(flights,year,month,day)
summarise(by_day,delay=mean(dep_delay,na.rm=TRUE))

###############  MULTIPLE OPERATION WITH PIPES  #########
#########
delays<-flights %>% 
  group_by(dest) %>% 
  summarise(
    count=n(),
    dist=mean(distance,na.rm = TRUE),
    delay = mean(arr_delay,na.rm = TRUE),
  ) %>% 
  filter(count>20,dest != "HNL")

#######CLASSWORK######################CANCELLED FIGHT
not_cancelled<- flights %>% 
  filter(!is.na(dep_delay),!is.na(arr_delay))

not_cancelled %>% 
  group_by(year,month,day) %>% 
  summarise(mean=mean(dep_delay))           

####################
delays<-not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay=mean(arr_delay)
  )

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
### When do the first and last flight leave each day
not_cancelled %>% 
  group_by(year,month,day) %>% 
  summarise(
    first= min(dep_time),
    last = max(dep_time)
  )

### When do the first and last flight leave each month
not_cancelled %>% 
  group_by(year,month) %>% 
  summarise(
    first= min(dep_time),
    last = max(dep_time)
  )

###Why is distance to some destinations more variable than to others
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(
    distance_mean=mean(distance),distance_sd=sd(distance)) %>% 
    arrange(desc(distance_sd))

### Which destination have the most carries
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers=n_distinct(carrier)) %>% 
  arrange(desc(carriers))


###How many flights left before 5am daily?###
not_cancelled %>% 
  group_by(year,month,day) %>% 
  summarise(n_early=sum(dep_time<500))

###How many flights left before 5am monthly?###
not_cancelled %>% 
  group_by(year,month) %>% 
  summarise(n_early=sum(dep_time<500))

####what proportion of flight are delayed by more than an hour###
not_cancelled %>% 
  group_by(year,month,day) %>% 
  summarise(hour_prop=mean(arr_delay>60))

#find all groups bigger than a threshold
popular_dests<- flights %>% 
  group_by(dest) %>% 
  filter(n()>365)
popular_dests

#POPULAR DESTINATION IN DESCENDING ORDER#########HOMEWORK#####

head(popular_dest$dest)

333333333333333333333333333333333333333333333333333333333333

flights %>% slice_sample(n=5)
