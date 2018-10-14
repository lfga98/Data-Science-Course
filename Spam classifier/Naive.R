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
## Creating the second sparse matrix this does all the past tasks
sms_dtm2 <- DocumentTermMatrix(sms_corpus,
                               control = list(
                                 tolower= TRUE,
                                 removeNumbers = TRUE,
                                 stopwords= TRUE,
                                 removePunctuation = TRUE,
                                 stemming=TRUE
                                 ))
sms_dtm_train <- sms_dtm[1:4169, ]
sms_dtm_test <- sms_dtm[4170:5559, ]
sms_train_labels <- sms_raw[1:4169, ]$ type
sms_test_labels <- sms_raw[4170:5559, ] $ type
##Confirming the subsets are representative
prop.table(table(sms_train_labels))
prop.table(table(sms_test_labels))
install.packages ('wordcloud')
library('wordcloud')
install.packages ('RColorBrewer')
library('RColorBrewer')
library(tm)
library(NLP)
wordcloud(sms_corpus_clean,min.freq = 50,random.order = FALSE)
spam <- subset(sms_raw,type=="spam")
##Removing words that dont appear to much
sms_freq_words <-findFreqTerms(sms_dtm_train, 5)
sms_dtm_freq_train <- sms_dtm_train[ , sms_freq_words]
sms_dtm_freq_test <- sms_dtm_test[ , sms_freq_words]

convert_counts <- function( x){
  x <- ifelse( x > 0 ,"Yes","No")
}

sms_train <- apply(sms_dtm_freq_train,MARGIN = 2,convert_counts)
sms_test <- apply(sms_dtm_freq_test,MARGIN = 2,convert_counts)
##Applying naive bayes
library(e1071)
sms_classifier <-naiveBayes(sms_train,sms_train_labels)
sms_test_pred <- predict(sms_classifier,sms_test)
library(gmodels)
##Results
CrossTable(sms_test_pred,sms_test_labels,prop.chisq = FALSE,prop.t = FALSE,dnn=c('predicted','actual'))
