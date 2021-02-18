#install.packages("caret")
#install.packages("janitor")
#install.packages("mda")
#install.packages("e1071")
library(caret)
library(janitor)

trainfile <- "reducedData.csv"
testfile <- "reducedDataTest.csv"
# load the CSV file from the local directory
train <- read.csv(trainfile, header=TRUE, stringsAsFactors=T)
test <- read.csv(testfile, header=TRUE , stringsAsFactors=T)


dim(train) 

dim(test) 

df <- train
df_test <- test

#df <- train[ -c(199,200:3198)] 
#df_test <- test[ -c(199,200:3198)] 
#df <- df[which(1:nrow(df) %% 2 == 1) , ]
#df <- df[which(1:nrow(df) %% 2 == 1) , ]
#df_test <- df_test[which(1:nrow(df_test) %% 2 == 1) , ]

library(mda)
# fit model
fit <- mda(LABEL~., data=df)
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, df_test)
# summarize accuracy
predictions

wfact = cut(df_test$LABEL, 2, labels=c('1','2')) 

xtab <- table(predictions, wfact)
library(caret) 
confusionMatrix(xtab)

#summary(xtab)
