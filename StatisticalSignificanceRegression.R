# Homework 8
baseball <- read.csv("baseball_wins_10years.csv")

library(ggplot2)

lm_SB <- lm(W ~ SB, data = baseball)

ggplot(data = baseball, mapping = aes(x = SB, y = W)) +
  geom_point() +
  geom_abline(intercept = lm_SB$coefficients[1], slope = lm_SB$coefficients[2])

summary(lm_SB)

lm_ERA <- lm(W ~ ERA, data = baseball)

ggplot(data = baseball, mapping = aes(x = ERA, y = W)) +
  geom_point() +
  geom_abline(intercept = lm_ERA$coefficients[1], slope = lm_ERA$coefficients[2])

summary(lm_ERA)

set.seed(234)
random_SB <- baseball$SB[sample(1:300)]
lm_random_SB <- lm(baseball$W ~ random_SB)
summary(lm_random_SB)

lm_SO <- lm(W ~ SO, data = baseball)

ggplot(data = baseball, mapping = aes(x = SO, y = W)) +
  geom_point() +
  geom_abline(intercept = lm_SO$coefficients[1], slope = lm_SO$coefficients[2])

summary(lm_SO)

lm_SO$coefficients[1] + lm_SO$coefficients[2] * 1000

lm_SO$coefficients[1] + lm_SO$coefficients[2] * 1300

