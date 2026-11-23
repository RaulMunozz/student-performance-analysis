burritos <- read.csv("burritos.csv", stringsAsFactors = TRUE)


burritos_train <- burritos[1:100, ]
burritos_test <- burritos[101:122, ]

library(ggplot2)

ggplot(data = burritos_train) +
  geom_point(mapping = aes(x = Fillings, y = Overall))

lm_burritos <- lm(Overall ~ Fillings, data = burritos_train)

ggplot(data = burritos_train, mapping = aes(x = Fillings, y = Overall)) +
  geom_point() +
  geom_abline(intercept = lm_burritos$coefficients[1],
              slope = lm_burritos$coefficients[2])

summary(lm_burritos)

lm_burritos$coefficients[1] + lm_burritos$coefficients[2] * 4

predict(lm_burritos, data.frame(Fillings = 4))

predict(lm_burritos, data.frame(Fillings = 4), interval = "prediction")

lm_burritos_all <- lm(Overall ~ ., data = burritos_train)

summary(lm_burritos_all)

