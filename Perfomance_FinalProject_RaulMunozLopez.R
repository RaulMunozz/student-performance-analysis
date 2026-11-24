
if (!file.exists("student_perfomance.csv")) {
  stop("student_perfomance.csv not found. Run this script from the project directory.")
}
student <- read.csv("student_perfomance.csv", stringsAsFactors = TRUE)
library(ggplot2)
library(C50)



# Boxplot: G3 by sex
ggplot(student, aes(x = sex, y = G3)) +
  geom_boxplot() +
  labs(title = "G3 by Sex")

# Boxplot: G3 by internet
ggplot(student, aes(x = internet, y = G3)) +
  geom_boxplot() +
  labs(title = "G3 by Internet Access")

# Scatterplot: studytime vs G3
ggplot(student, aes(x = studytime, y = G3, color = sex)) +
  geom_point() +
  labs(title = "Study Time vs G3")

# Scatterplot: failures vs G3
ggplot(student, aes(x = failures, y = G3, color = internet)) +
  geom_point() +
  labs(title = "Failures vs G3")


set.seed(123)
student <- student[sample(1:359), ]

student_train <- student[1:100, ]
student_test  <- student[100:359, ]


# Simple rule ("by hand")
student_by_hand_predictions <- ifelse(
  student_test$studytime > 2,
  ifelse(student_test$failures > 0, "no", "yes"),
  "no"
)

table(student_by_hand_predictions, student_test$internet)

# Accuracy
confusion_matrix <- table(student_by_hand_predictions, student_test$internet)
sum(diag(confusion_matrix)) / sum(confusion_matrix)

# FNR
confusion_matrix[1,2] / sum(confusion_matrix[,2])

# FPR
confusion_matrix[2,1] / sum(confusion_matrix[,1])



# Decision tree (C5.0)
student_tree <- C5.0(internet ~ ., data = student_train)
student_tree_predictions <- predict(student_tree, student_test)

table(student_tree_predictions, student_test$internet)

# Accuracy
confusion_matrix <- table(student_tree_predictions, student_test$internet)
sum(diag(confusion_matrix)) / sum(confusion_matrix)

#FNR
confusion_matrix[1,2] / sum(confusion_matrix[,2])

#FPR
confusion_matrix[2,1] / sum(confusion_matrix[,1])




# Simple regression
lm_simple <- lm(G3 ~ studytime, data = student_train)
summary(lm_simple)

ggplot(student_train, aes(x = studytime, y = G3)) +
  geom_point() +
  geom_abline(
    intercept = lm_simple$coefficients[1],
    slope = lm_simple$coefficients[2]
  )

predict(lm_simple, data.frame(studytime = 2), interval = "prediction")


# Multiple regression
lm_multiple <- lm(G3 ~ ., data = student_train)
summary(lm_multiple)

# Remove NAs for RMSE
clean_test <- student_test[!is.na(student_test$G3), ]

preds_mult <- predict(lm_multiple, clean_test)

rmse <- sqrt(mean((clean_test$G3 - preds_mult)^2))
rmse


student_num <- as.data.frame(scale(student[, sapply(student, is.numeric)]))

within_ss <- rep(0, 15)
for (k in 1:15) {
  model_k <- kmeans(student_num, k)
  within_ss[k] <- sum(model_k$withinss)
}

plot(1:15, within_ss, type = "p",
     xlab = "Clusters (k)",
     ylab = "Within SS",
     main = "Elbow Method")


set.seed(123)
student_clusters <- kmeans(student_num, 5)
clusters <- as.factor(student_clusters$cluster)

# Cluster Plot 1
ggplot(student, aes(x = age, y = G3, color = clusters)) +
  geom_point() +
  labs(title = "Age vs G3 by Cluster")

# Cluster Plot 2
ggplot(student, aes(x = absences, y = failures, color = clusters)) +
  geom_point() +
  labs(title = "Absences vs Failures by Cluster")

# Cluster Plot 3
ggplot(student, aes(x = G1, y = G2, color = clusters)) +
  geom_point() +
  labs(title = "G1 vs G2 by Cluster")

