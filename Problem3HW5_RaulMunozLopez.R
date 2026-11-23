library(caret)
library(C50)

colleges <- read.csv("colleges.csv", stringsAsFactors = TRUE)

set.seed(123)
colleges <- colleges[sample(1:1285),]

colleges_train <- colleges[1:1028, -(1:2)]
colleges_test  <- colleges[1029:1285, -(1:2)]

set.seed(123)
colleges_tree <- C5.0(Region ~ ., data = colleges_train)

colleges_pred <- predict(colleges_tree, newdata = colleges_test)

conf_colleges <- confusionMatrix(colleges_pred, colleges_test$Region)
print(conf_colleges)

midwest_total <- sum(colleges_test$Region == "MW")
midwest_incorrect <- sum(colleges_test$Region == "MW" & colleges_pred != "MW")
midwest_error_pct <- (midwest_incorrect / midwest_total) * 100
cat("Midwest misclassification (%):", round(midwest_error_pct, 2), "\n")

