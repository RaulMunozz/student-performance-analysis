library(caret)
library(randomForest)
library(rpart)
library(pROC)

spam <- read.csv("spam.csv", stringsAsFactors = TRUE)
spam_train <- spam[1:3601, ]
spam_test  <- spam[3602:4601, ]

set.seed(123)
spam_rf <- randomForest(result ~ ., data = spam_train, ntree = 500)

spam_test_pred_prob <- predict(spam_rf, spam_test, type="prob")[,2]

roc_rf <- roc(spam_test$result, spam_test_pred_prob, levels=c("non-spam","spam"))
plot(roc_rf, col="blue", main="ROC Curve - Random Forest vs Decision Tree")
auc(roc_rf)

spam_dt <- rpart(result ~ ., data = spam_train, method = "class")
spam_dt_pred_prob <- predict(spam_dt, spam_test, type="prob")[,2]

roc_dt <- roc(spam_test$result, spam_dt_pred_prob, levels=c("non-spam","spam"))
lines(roc_dt, col="red")
legend("bottomright", legend=c("Random Forest","Decision Tree"), col=c("blue","red"), lwd=2)
