#load packages
library(tidyverse)
library(tidytext)

#read in data
dta <- read_tsv('../data/original/drugLibTrain_raw.tsv')

#define arguments
args = commandArgs(trailingOnly = TRUE)
CONDITION = args[1]

#get tokens
tokens <-dta %>% 
        filter(condition==CONDITION) %>%
        unnest_tokens(word, sideEffectsReview) %>% #tokenize reviews
        anti_join(stop_words) %>% #remove stopwords
        filter(! word %in% c('effect','effects','side',
                             'experienced')) %>%
	filter(str_detect(word, "[a-z]"))

#find most common words side effects
words <- tokens %>%
        count(word, sort=TRUE) %>% #count instances of each word
        head(100) #top 100


#repeat for bigrams (word pairs)
bigrams <- dta %>% 
  	filter(condition==CONDITION) %>%
  	unnest_tokens(bigram, sideEffectsReview, 
			token = "ngrams", n = 2)

# remove stop words
bigrams <- bigrams %>%
  	separate(bigram, into = c("first","second"),
		   sep = " ", remove = FALSE) %>%
  	anti_join(stop_words, by = c("first" = "word")) %>%
  	anti_join(stop_words, by = c("second" = "word")) %>%
  	filter(str_detect(first, "[a-z]") & 
		 str_detect(second, "[a-z]"))

#find most common bigrams for side effects
bigrams <- bigrams %>%
  	count(bigram, sort=TRUE) %>% #count instances
  	head(100) #top 100


results <- tibble('rank' = c(1:100),
                  'word' = words$word,
		  'word_frequency' = words$n,
                  'bigram' = bigrams$bigram,
		  'bigram_frequency' = bigrams$n,) %>%
           write_csv(paste('../data/derived/word_rankings_',
                           CONDITION,'.csv',sep=''))


