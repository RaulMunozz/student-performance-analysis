country <- read.csv("country_data_no_na_columns.csv", stringsAsFactors = T)
country_norm <- as.data.frame(scale(country[ , sapply(country, is.numeric) ]))

within_ss <- rep(0, 15)
for (k in 1:15) {
  country_clusters1 <- kmeans(country_norm, k)
  within_ss[k] <- sum(country_clusters1$withinss)
}

plot(1:15, within_ss, type = "p",
     xlab = "Number of clusters (k)",
     ylab = "Within-cluster sum of squares",
     main = "Elbow Method for Optimal k")

set.seed(123)
country_clusters <- kmeans(country_norm, 5)
country_clusters$size
country_clusters$centers

cluster_assignments <- cbind(country[, "country"], country_clusters$cluster)
colnames(cluster_assignments) <- c("Country", "Cluster")
head(cluster_assignments)

library(ggplot2)
clusters <- as.factor(country_clusters$cluster)

ggplot(country, aes(x = GDP_per_capita, y = life_expectancy_female, color = clusters)) +
  geom_point() +
  labs(x = "GDP per Capita", y = "Life Expectancy (Female)", color = "Cluster",
       title = "GDP per Capita vs Life Expectancy (Female) by Cluster")

ggplot(country, aes(x = fertility_rate, y = infant_mortality_rate, color = clusters)) +
  geom_point() +
  labs(x = "Fertility Rate", y = "Infant Mortality Rate", color = "Cluster",
       title = "Fertility Rate vs Infant Mortality Rate by Cluster")

ggplot(country, aes(x = CO2_emission_per_capita, y = urban_population, color = clusters)) +
  geom_point() +
  labs(x = "CO2 Emission per Capita", y = "Urban Population (%)", color = "Cluster",
       title = "CO2 Emission per Capita vs Urban Population by Cluster")

set.seed(200)
country_clusters2 <- kmeans(country_norm, 5)

set.seed(321)
country_clusters3 <- kmeans(country_norm, 5)

set.seed(999)
country_clusters4 <- kmeans(country_norm, 5)

country_clusters$size
country_clusters2$size
country_clusters3$size
country_clusters4$size

country_clusters$centers
country_clusters2$centers
country_clusters3$centers
country_clusters4$centers
