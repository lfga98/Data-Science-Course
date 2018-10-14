##Loading data
setwd("~/Documents/Ingenieria de Software/Ciencia de Datos/Spam classifier")
sms_raw <- read.csv("sms_spam.csv",stringsAsFactors = FALSE)
str(sms_raw)

## Preparing data

## Choosing factor
## Type will be factor
sms_raw$type <- factor(sms_raw$type)
str(sms_raw$type)
table(sms_raw$type)

## Cleaning data
install.packages("tm")
library("tm")
install.packages("SnowballC")
library("SnowballC")
sms_corpus <- VCorpus(VectorSource(sms_raw $text))
print(sms_corpus)
## summary of messages of a group of messages
inspect(sms_corpus[1:2])
## See the actual message
as.character(sms_corpus[[1]])
## Lapply apply this to some messages
lapply(sms_corpus[1 :2] ,as.character)
## To lower case
sms_corpus_clean <- tm_map(sms_corpus, content_transformer(tolower))
## Remove numbers
sms_corpus_clean <- tm_map(sms_corpus_clean,removeNumbers)
## Remove STOP WORDS
sms_corpus_clean <- tm_map(sms_corpus_clean,removeWords,stopwords())
## Remove punctuation
sms_corpus_clean <- tm_map(sms_corpus_clean,removePunctuation)
## Stem data learned learning etc = learn
sms_corpus_clean <- tm_map(sms_corpus_clean,stemDocument)
## White spaces 
sms_corpus_clean <- tm_map(sms_corpus_clean,stripWhitespace)
##Creating sparse matrix
sms_dtm <- DocumentTermMatrix(sms_corpus_clean)

 