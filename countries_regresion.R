countries <- read.csv("countries.csv")


set.seed(123)
countries <- countries[sample(nrow(countries)), ]


countries_train <- countries[1:100, ]
countries_test <- countries[101:159, ]


library(ggplot2)


ggplot(data = countries_train) +
  geom_point(mapping = aes(x = fertility_rate, y = infant_mortality_rate))


lm_country <- lm(infant_mortality_rate ~ fertility_rate, data = countries_train)


ggplot(data = countries_train, mapping = aes(x = fertility_rate, y = infant_mortality_rate)) +
  geom_point() +
  geom_abline(intercept = lm_country$coefficients[1], slope = lm_country$coefficients[2])


summary(lm_country)

lm_country$coefficients[1] + lm_country$coefficients[2] * 3

predict(lm_country, data.frame(fertility_rate = 3))

predict(lm_country, data.frame(fertility_rate = 3), interval = "prediction")

country_preds <- predict(lm_country, countries_test)

rmse <- sqrt(mean((countries_test$infant_mortality_rate - country_preds)^2))
rmse



ggplot(data = countries_train) +
  geom_point(mapping = aes(x = GDP_per_capita, y = infant_mortality_rate))

ggplot(data = countries_train) +
  geom_point(mapping = aes(x = log(GDP_per_capita), y = log(infant_mortality_rate)))

lm_country_log <- lm(log(infant_mortality_rate) ~ log(GDP_per_capita), data = countries_train)
summary(lm_country_log)

ggplot(data = countries_train, mapping = aes(x = log(GDP_per_capita), y = log(infant_mortality_rate))) +
  geom_point() +
  geom_abline(intercept = lm_country_log$coefficients[1], slope = lm_country_log$coefficients[2])

exp(predict(lm_country_log, data.frame(GDP_per_capita = 20000), interval = "prediction"))

country_preds_log <- exp(predict(lm_country_log, countries_test))

rmse_log <- sqrt(mean((countries_test$infant_mortality_rate - country_preds_log)^2))
rmse_log

