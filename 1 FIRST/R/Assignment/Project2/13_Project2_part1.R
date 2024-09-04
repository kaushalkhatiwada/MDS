

setwd("~")
#####################  COVID_NEPAL ##########################
## PROBLEM: Minimum value 0 

covid<- read.csv("covnep_252days.csv")
summary(covid$totalCases)

# Subsetting based on Total cases greater than 1
new_covid<-subset(covid,covid$totalCases>=1)
summary(new_covid$totalCases)


####################  SURVEY ##########################
## Get frequencies of q01, q03, q06 & q08
## Compute frequencies, percentage, valid percentage and cumulative percentage

library(foreign)
data <- read.spss("SAQ8.sav",to.data.frame=TRUE)    # Retrieve the data from sav file

#For Q1  "Statistics makes me cry"
q01 <- data$q01         # Get the q01 column 
q01_level <- levels(q01)     # Get the categorical levels
q01_freq <- as.numeric(table(q01))  # Get the frequency to each category
q01_perc <- as.numeric(round(prop.table(q01_freq) * 100, 1))  # Calculate the Percentage
q01_valid_per <- as.numeric(round(prop.table(q01_freq) * 100, 1))   #Calculate valid percentage
q01_cum_per <- cumsum(q01_perc)       #Calculate Cumulative Percentage

q1_df <- data.frame(                   #Create Data Frame
  Levels = q01_level,
  Frequency = q01_freq,
  Percent = q01_perc,
  Valid_Percent = q01_valid_per,
  Cumulative_Percent = q01_cum_per
)
q1_total = c("Total",sum(q1_df$Frequency),sum(q1_df$Percent),sum(q1_df$Valid_Percent),"") 
q1<-rbind(q1_df,q1_total)     # Row bind the Total of frequency, percentage and valid percentage in data frame
q1

#For Q3  "Standard deviations excite me"
q03 <- data$q03
q03_level <- levels(q03)
q03_freq <- as.numeric(table(q03))
q03_perc <- as.numeric(round(prop.table(q03_freq) * 100, 1))
q03_valid_per <- as.numeric(round(prop.table(q03_freq) * 100, 1))
q03_cum_per <- cumsum(q03_perc)

q3_df <- data.frame(
  Levels = q03_level,
  Frequency = q03_freq,
  Percent = q03_perc,
  Valid_Percent = q03_valid_per,
  Cumulative_Percent = q03_cum_per
)
q3_total = c("Total",sum(q3_df$Frequency),sum(q3_df$Percent),sum(q3_df$Valid_Percent),"")
q3<-rbind(q3_df,q3_total)
q3

#For Q6  "I have little experience of computers"
q06 <- data$q06
q06_level <- levels(q06)
q06_freq <- as.numeric(table(q06))
q06_perc <- as.numeric(round(prop.table(q06_freq) * 100, 1))
q06_valid_per <- as.numeric(round(prop.table(q06_freq) * 100, 1))
q06_cum_per <- cumsum(q06_perc)

q6_df <- data.frame(
  Levels = q06_level,
  Frequency = q06_freq,
  Percent = q06_perc,
  Valid_Percent = q06_valid_per,
  Cumulative_Percent = q06_cum_per
)
q6_total = c("Total",sum(q6_df$Frequency),sum(q6_df$Percent),sum(q6_df$Valid_Percent),"")
q6<-rbind(q6_df,q6_total)
q6

#For Q8  "I have never been good at mathematics"
q08 <- data$q08
q08_level <- levels(q08)
q08_freq <- as.numeric(table(q08))
q08_perc <- as.numeric(round(prop.table(q08_freq) * 100, 1))
q08_valid_per <- as.numeric(round(prop.table(q08_freq) * 100, 1))
q08_cum_per <- cumsum(q08_perc)

q8_df <- data.frame(
  Levels = q08_level,
  Frequency = q08_freq,
  Percent = q08_perc,
  Valid_Percent = q08_valid_per,
  Cumulative_Percent = q08_cum_per
)
q8_total = c("Total",sum(q8_df$Frequency),sum(q8_df$Percent),sum(q8_df$Valid_Percent),"")
q8<-rbind(q8_df,q8_total)
q8

###################  INCOME FREQUENCY #########################
## Create Table using inco1, inco2, inco3, inco4, inco5, inco6 and inco7
## Has multiple response 0 as NO and 1 as YES)
install.packages("readxl")
library(readxl)
library(dplyr)
mr_drug <- read_xlsx("MR_Drugs.xlsx")   # Retrieve data from excel file

incomes_freq_table <- select(mr_drug, inco1, inco2, inco3, inco4, inco5, inco6, inco7)   # Only select inco1,...,inco7 column
has_income <- colSums(incomes_freq_table)    # Calculate the frequency of observation with respect to each income source.
Total_has_income <- sum(has_income)          # Total frequency of observation having income source
Total_observation <- colSums(!is.na(incomes_freq_table))    # Total observation 
Perc_per_income <- round(as.numeric((has_income/Total_has_income)*100),2)   # Percentage of having income source to total observation = (Has Income frequency/Total frequency) * 100
perc_per_case <- round(as.numeric(has_income/Total_observation*100),2)    # percentage of having the observation from the individual income source i.e(226/972)*100

income_frequencies<-data.frame(                   # Create Data Frame
  Income_Response = names(incomes_freq_table),
  N = has_income,
  Percent = Perc_per_income,
  Percent_of_cases = perc_per_case
)

total <- c("Total",Total_has_income, sum(Perc_per_income), sum(perc_per_case))  
income_frequencies <- rbind(income_frequencies, total)       # Row bind the Total of frequency, percentage and percentage of cases
row.names(income_frequencies) <- NULL        # Remove the rownames.
income_frequencies



