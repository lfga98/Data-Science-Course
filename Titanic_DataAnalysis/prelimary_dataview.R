setwd("~/Documents/Ingenieria de Software/Ciencia de Datos/Titanic_DataAnalysis")
install.packages("moments")
library(moments)
titanic_data <- read.csv("titanic.csv",header = TRUE)

head(titanic_data)
tail(titanic_data)
nrow(titanic_data)


summary(titanic_data$Survived)
summary(titanic_data$Pclass)

summary(titanic_data$Sex)
summary(titanic_data$Age)
summary(titanic_data)

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

boxplot(titanic_data$Pclass)
getmode(titanic_data$Pclass)
hist(titanic_data$Pclass)


boxplot(titanic_data$Survived)
getmode(titanic_data$Survived)
hist(titanic_data$Survived)


boxplot(titanic_data$Age)
hist(titanic_data$Age)
boxplot(titanic_data$SibSp)
getmode(titanic_data$SibSp)
hist(titanic_data$SibSp)


boxplot(titanic_data$Parch)
getmode(titanic_data$Parch)
hist(titanic_data$Parch)


plot(titanic_data$Pclass,titanic_data$Fare)
plot(titanic_data$Sex,titanic_data$Survived)
quantile(titanic_data$Pclass)
skewness(titanic_data$Parch)

