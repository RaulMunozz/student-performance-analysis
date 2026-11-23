temps <- c(98.5, 99.4, 101.2, 98.1)
mean(temps)
colleges <- read.csv("colleges.csv")
mean(colleges$num.FT.undergrad)
colleges[2,5]
colleges[2,]
colleges[,5]
colleges$Acceptance.rate <- colleges$num.applications.accepted / colleges$num.applications.received
hist(colleges$num.FT.undergrad)
boxplot(colleges$Graduation.rate)
boxplot(colleges$out.of.state.tuition ~ colleges$Region)
plot(colleges$Verbal.SAT, colleges$Math.SAT)
table(colleges$Region, colleges$Public.or.Private)

library(ggplot2)

