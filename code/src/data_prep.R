
# creating a production dataset -----------------------------------------------------------------------------------

## load packages
library(tidyverse)

## read in data
data_clv <- read_delim("data/src/CDNOW_master.txt", delim = " ")

## create a database to hold the data
db <- dbConnect(RSQLite::SQLite(), dbname = "data/prod/cdnow.sqlite")

## data prep
data_prep <- data_clv %>%
     rename(id = " customer_id",
            date = " date",
            num = number_of_cds,
            amount = " dollar_value") %>%
     mutate(date = as.Date(as.character(date), "%Y%m%d")) 

## write final data to sqlite table
dbWriteTable(db, "cust_clv_dat", data_prep, overwrite = TRUE)
