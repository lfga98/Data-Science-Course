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
