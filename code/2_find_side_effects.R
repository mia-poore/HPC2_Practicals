#load packages
library(tidyverse)
library(tidytext)

args = commandArgs(trailingOnly = TRUE)

#read in data
dta <- read_tsv('../data/original/drugLibTrain_raw.tsv')

#define arguments
CONDITION = args[1]


#top <- dta %>%
#  	count(condition, sort=TRUE) %>%
#  	head(40) %>%
#  	select(condition)

#CONDITION <- top$condition[CONDITION_IDX]

#describe
tokens <-dta %>% 
        filter(condition==CONDITION) %>%
        unnest_tokens(word, sideEffectsReview) %>% #tokenize reviews
        anti_join(get_stopwords()) %>% #remove stopwords
        filter(! word %in% c('effect','effects','side',
                             'experienced')) %>%
	filter(str_detect(word, "[a-z]"))

#find most common words for negative side effects
negative_words <- tokens %>%
          filter(rating<5) %>%
          count(word, sort=TRUE) %>% #count instances of each word
          head(10) #top 10

#find most common words for positive side effects
positive_words <- tokens %>%
          filter(rating>=5) %>%
          count(word, sort=TRUE) %>% #count instances of each word
          head(10) #top 10

#repeat for bigrams (word pairs)
bigrams <- dta %>% 
  filter(condition==CONDITION) %>%
  unnest_tokens(bigram, sideEffectsReview, token = "ngrams", n = 2)

# remove stop words
bigrams <- bigrams %>%
  separate(bigram, into = c("first","second"), sep = " ", remove = FALSE) %>%
  anti_join(stop_words, by = c("first" = "word")) %>%
  anti_join(stop_words, by = c("second" = "word")) %>%
  filter(str_detect(first, "[a-z]") &
           str_detect(second, "[a-z]"))

#find most common bigrams for negative side effects
negative_bigrams <- bigrams %>%
  filter(rating<4) %>%
  count(bigram, sort=TRUE) %>% #count instances of each word
  head(10) #top 10

#find most common bigrams for positive side effects
positive_bigrams <- bigrams %>%
  filter(rating>7) %>%
  count(bigram, sort=TRUE) %>% #count instances of each word
  head(10) #top 10

results <- tibble('rank' = c(1:10),
                  'negative_word' = negative_words$word,
                  'positive_word' = positive_words$word,
                  'negative_bigram' = negative_bigrams$bigram,
                  'positive_bigram' = positive_bigrams$bigram,) %>%
           write_csv(paste('../data/derived/word_rankings',
                           CONDITION,'.csv',sep='_'))


