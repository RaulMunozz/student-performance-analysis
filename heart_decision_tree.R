#Load the heart disease data 
#stringsAsFactors makes categorical vars the correct data type
spam <- read.csv("spam.csv", stringsAsFactors = T)

#Make training and test sets
#The training set is used to create the prediction method
#The test set is used to evaluate its accuracy
spam_train <- heart[1:3601,]
spam_test <- heart[3602:4601,]

#Exploratory data analysis graphs using the training data
library(ggplot2)

#Side-by-side boxplots
ggplot(data = spam_train, mapping = aes(x = you, y = result)) +
  geom_boxplot() + 
  coord_flip()

#Scatterplots
ggplot(data = heart_train) +
  geom_point(mapping = aes(x = RestBP, y = MaxHR, color = HD))


#Make a decision tree "by hand" via the ifelse function
#300 and 100 are placeholder numbers!
heart_by_hand_predictions <- ifelse(heart_test$RestBP < 300, ifelse(heart_test$MaxHR > 100, "No", "Yes"), "Yes")

#Make a confusion matrix to evaluate the predictions
table(heart_by_hand_predictions, heart_test$HD)

#Calculate the prediction accuracy
confusion_matrix <- table(heart_by_hand_predictions, heart_test$HD)
sum(diag(confusion_matrix)) / sum(confusion_matrix)

#Calculate the false negative rate
confusion_matrix[1,2] / sum(confusion_matrix[,2])

#Calculate the false positive rate
confusion_matrix[2,1] / sum(confusion_matrix[,1])

#Was this better than just guessing "No" every time?
all_no_predictions <- rep("No", 100)
table(all_no_predictions, heart_test$HD)


#Try the C50 algorithm to make a decision tree
#Load the C50 package so the C50 function is available
library(C50)

#1. Create the decision tree
heart_tree <- C5.0(HD ~ ., data = heart_train)

#2. Use the decision tree to predict the test data
heart_test_predictions <- predict(heart_tree, heart_test)

#3. Evaluate the results
confusion_matrix <- table(heart_test_predictions, heart_test$HD)

#Prediction accuracy
sum(diag(confusion_matrix)) / sum(confusion_matrix)

#False negative rate
confusion_matrix[1,2] / sum(confusion_matrix[,2])

#False positive rate
confusion_matrix[2,1] / sum(confusion_matrix[,1])


#Making a new decision tree to lower the false negative rate
#1.
error_cost <- matrix(c(0,1,3,0), nrow=2)
heart_tree <- C5.0(HD ~ ., data = heart_train, costs = error_cost)

#2.
heart_test_predictions <- predict(heart_tree, heart_test)

#3.
table(heart_test_predictions, heart_test$HD)
