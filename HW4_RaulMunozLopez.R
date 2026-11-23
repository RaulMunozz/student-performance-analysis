#Load the spam data 
spam <- read.csv("spam.csv", stringsAsFactors = T)

#Make training and test sets
spam_train <- spam[1:3601,]
spam_test <- spam[3602:4601,]

#Exploratory data analysis graphs using the training data
library(ggplot2)

#1a Side-by-side boxplots
ggplot(data = spam_train, mapping = aes(x = result, y = you)) +
  geom_boxplot() + 

#1b Another boxplot
ggplot(data = spam_train, mapping = aes(x = result, y = dollarsign)) +
  geom_boxplot() + 

#1c Scatterplot
ggplot(data = spam_train) +
  geom_point(mapping = aes(x = receive, y = your, color = result))

#1d Another scatterplot
ggplot(data = spam_train) +
  geom_point(mapping = aes(x = free, y = money, color = result))


#2 Make a decision tree "by hand" via the ifelse function
spam_by_hand_predictions <- ifelse(spam_test$you > 1, ifelse(spam_test$dollarsign > 0.2, "spam", "non-spam"), "non-spam")

#Confusion matrix to evaluate the predictions
table(spam_by_hand_predictions, spam_test$result)

#Accuracy
confusion_matrix <- table(spam_by_hand_predictions, spam_test$result)
sum(diag(confusion_matrix)) / sum(confusion_matrix)

#False negative rate
confusion_matrix[1,2] / sum(confusion_matrix[,2])

#False positive rate
confusion_matrix[2,1] / sum(confusion_matrix[,1])

#Better than guessing "nono-spam" every time?
all_no_predictions <- rep("non-spam", nrow(spam_test))
table(all_no_predictions, spam_test$result)


#3C50 algorithm
library(C50)

#3a Decision tree
spam_tree <- C5.0(result ~ ., data = spam_train)

#3b Predict the test data
spam_test_predictions <- predict(spam_tree, spam_test)

#3cde Evaluate the results
confusion_matrix <- table(spam_test_predictions, spam_test$result)

#Prediction accuracy
sum(diag(confusion_matrix)) / sum(confusion_matrix)

#False negative rate
confusion_matrix[1,2] / sum(confusion_matrix[,2])

#False positive rate
confusion_matrix[2,1] / sum(confusion_matrix[,1])


#4 Making a new decision tree with error cost
error_cost <- matrix(c(0,5,1,0), nrow=2)
spam_tree <- C5.0(result ~ ., data = spam_train, costs = error_cost)

spam_test_predictions <- predict(spam_tree, spam_test)

table(spam_test_predictions, spam_test$result)
