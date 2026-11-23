planets <- read.csv("planets.csv")

#Scatterplot
library(ggplot2)
ggplot(data = planets) +
  geom_point(mapping = aes(x = Distance, y = Length.of.year))

#Scatterplot for log transformed versions
ggplot(data = planets) +
  geom_point(mapping = aes(x = log(Distance), y = log(Length.of.year)))

#Step 1: Linear regression on the log transformed versions
lm_planets_log = lm(log(Length.of.year) ~ log(Distance), data=planets)
summary(lm_planets_log)   

#Scatterplot for log transformed versions with regression line
ggplot(data = planets, mapping = aes(x = log(Distance), y = log(Length.of.year))) +
  geom_point() +
  geom_abline(intercept = lm_planets_log$coefficients[1], slope = lm_planets_log$coefficients[2])

#Final prediction (undo the transformation)
exp(predict(lm_planets_log, data.frame(Distance = 5000), interval = "prediction"))
