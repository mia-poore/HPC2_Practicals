#load packages
library(tidyverse)

#read in data
dta <- read_tsv('../data/original/drugLibTrain_raw.tsv')

#10 most common conditions

dta %>% 
  count(condition, sort=TRUE) %>%
  head(4) %>%
  select(condition) %>%
  write_csv('../data/derived/top_conditions.csv')
