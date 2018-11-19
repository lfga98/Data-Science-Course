##Loading data

setwd("~/Documents/Ingenieria de Software/Ciencia de Datos/Message_predicting")
messages <- read.csv("Messages_dataset.csv",stringsAsFactors = FALSE)
str(messages)


## Preparing data

## Choosing factor
## Sender will be factor
messages$type <- factor(messages$Emisor)
str(messages$type)
table(messages$type)
library("tm")
library("SnowballC")
## To corpus
message_corpus <- VCorpus(VectorSource(messages$Mensaje))
print(message_corpus)

##To lower case
message_corpus_clean <- tm_map(message_corpus, content_transformer(tolower))

