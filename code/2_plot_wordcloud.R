#load packages
library(tidyverse)
library(wordcloud)

#define arguments
args = 	commandArgs(trailingOnly = TRUE)
CONDITION = args[1]

#read in data
dta <- 	read_csv(paste('../data/derived/intermediate/word_rankings_',
		      CONDITION,'.csv',sep=''))


pal <- 	brewer.pal(8,"Dark2")

# wordcloud for words
png(paste('../results/wordcloud_',CONDITION,'.png',sep=''))
wordcloud(dta$word, dta$word_frequency, random.order = FALSE, max.words = 50, colors=pal)
dev.off()

# wordcloud for bigrams
png(paste('../results/bigramcloud_',CONDITION,'.png',sep=''))
wordcloud(dta$bigram, dta$bigram_frequency,random.order = FALSE,max.words = 50, colors=pal)
dev.off()

