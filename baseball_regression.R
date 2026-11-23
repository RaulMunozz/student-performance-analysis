baseball <- read.csv("baseball_wins_10years.csv")

#Exploratory data analysis
library(ggplot2)

#Histogram
ggplot(data = baseball) + 
  geom_histogram(mapping = aes(x = W))

#Histogram with fewer bins
ggplot(data = baseball) + 
  geom_histogram(mapping = aes(x = W), bins = 10)

#Scatterplot
ggplot(data = baseball) +
  geom_point(mapping = aes(x = ERA, y = W))

#Correlation between AVE and W
cor(baseball$ERA, baseball$W)


#Simple linear regression to predict W, using ERA

#Split into training/test sets
baseball_train <- baseball[1:150,]
baseball_test <- baseball[151:300,]

#Create linear regression to predict Wins from ERA, using training data
lm_baseball <- lm(W ~ ERA, data = baseball_train)

#Scatterplot with regression line, using training data only:
ggplot(data = baseball_train, mapping = aes(x = ERA, y = W)) +
  geom_point() +
  geom_abline(intercept = lm_baseball$coefficients[1], slope = lm_baseball$coefficients[2])

#Info about regression
summary(lm_baseball)

#Predict W for team with ERA = 4.0 (by hand)
127.590 - 11.405*4.0

#Prediction using the predict function=
predict(lm_baseball, data.frame(ERA = 4))

#Prediction with a 95% prediction interval. A 95% prediction interval is 
#  a range that the regression estimates to have a 95% probability of
#  containing the number of wins for a team with a particular ERA.
predict(lm_baseball, data.frame(ERA = 4), interval = "prediction")

#Predict number of wins for the entire test data
baseball_preds = predict(lm_baseball, baseball_test)

#Calculate the root mean squared error ("average" prediction error)
rmse = sqrt(mean((baseball_test$W - baseball_preds)^2))

#Run the name rmse to show the result:
rmse

