library(randomForest)
library(caret)

spam <- read.csv("spam.csv", stringsAsFactors = TRUE)
spam_train <- spam[1:3601, ]
spam_test  <- spam[3602:4601, ]

set.seed(123)
spam_rf <- randomForest(result ~ ., data = spam_train, ntree = 500)
spam_rf_pred <- predict(spam_rf, newdata = spam_test)

conf_rf <- confusionMatrix(spam_rf_pred, spam_test$result, positive = "spam")
print(conf_rf)

cm <- conf_rf$table
TN <- cm["non-spam","non-spam"]
FP <- cm["spam","non-spam"]
FN <- cm["non-spam","spam"]
TP <- cm["spam","spam"]

accuracy <- (TP + TN) / sum(cm)
fpr <- FP / (FP + TN)
fnr <- FN / (FN + TP)

cat("Accuracy:", round(accuracy, 4), "\n")
cat("False Positive Rate:", round(fpr, 4), "\n")
cat("False Negative Rate:", round(fnr, 4), "\n")
