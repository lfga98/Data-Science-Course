setwd("~/Documents/Ingenieria de Software/Ciencia de Datos/BreastCancerAnalysis")
wbcd <- read.csv("wisc_bc_data.csv", stringsAsFactors = FALSE)
str(wbcd)
#Exclude id
wbcd <- wbcd[-1] 
#Selecting the outcome variable
table(wbcd$diagnosis)
#Output variable as factor
wbcd$diagnosis <- factor(wbcd$diagnosis,
                         levels=c("B","M"),
                         labels = c(" Benign","Malignant"))

round( prop.table(table(wbcd$diagnosis))*100, digits = 1)
summary(wbcd[ c("radius_mean","area_mean","smoothness_mean")])

normalize <-function(x){
    return((x-min(x))/(max(x) -min(x)))
}

wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))
summary(wbcd_n$area_mean)

##Prepared the train and test data
wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]

## We ommit the target variable these are the target labelss
wbcd_train_labels <-wbcd[1:469,1]
wbcd_test_labels <-wbcd[470:569,1]
install.packages("class")
library(class)
## Applied knn 
wbcd_test_pred <- knn(train = wbcd_train,test = wbcd_test,cl = wbcd_train_labels,k=21)
install.packages("gmodels")
library(gmodels)
## Comparing the results
CrossTable(x=wbcd_test_labels,
           y=wbcd_test_pred,
           prop.chisq = FALSE)


## Improving perfomance
wbcd_z <- as.data.frame(scale(wbcd[-1]))
summary(wbcd_z$area_mean)
wbcd_train <- wbcd_z[1:469, ]
wbcd_test <- wbcd_z[470:569, ]
wbcd_test_pred <- knn(train = wbcd_train,test = wbcd_test,cl = wbcd_train_labels,k=21)
CrossTable(x=wbcd_test_labels,
           y=wbcd_test_pred,
           prop.chisq = FALSE)
## It did not work but we saw another way on normalization
